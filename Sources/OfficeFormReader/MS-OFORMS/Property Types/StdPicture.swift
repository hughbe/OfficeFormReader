//
//  StdPicture.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.4.13 StdPicture
/// Specifies a picture as persisted to a stream.
public struct StdPicture {
    public let preamble: UInt32
    public let size: UInt32
    public let picture: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// Preamble (4 bytes): MUST be set to 0x0000746C.
        self.preamble = try dataStream.read(endianess: .littleEndian)
        guard self.preamble == 0x0000746C else {
            throw OfficeFormFileError.corrupted
        }
        
        /// Size (4 bytes): An unsigned integer that specifies the size, in bytes, of Picture.
        self.size = try dataStream.read(endianess: .littleEndian)
        
        /// Picture (variable): A sequence of bytes that specify a picture. The length of the sequence is Size.
        /// The bytes MUST specify a picture in one of the following formats:
        ///  Bitmap [MS-WMF] section 2.2.2.3
        ///  GIF image [GIF89a]
        ///  JPEG image [JFIF]
        ///  Windows Metafile [MS-WMF]
        ///  Enhanced Metafile [MS-EMF]
        ///  Icon [MC-IcoWin32]
        self.picture = try dataStream.readBytes(count: Int(self.size))
    }
}
