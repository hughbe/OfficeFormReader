//
//  StdFont.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.4.12 StdFont
/// Specifies the format of a standard font structure as persisted to a stream.
public struct StdFont {
    public let version: UInt8
    public let sCharset: Int16
    public let bFlags: FONTFLAGS
    public let sWeight: Int16
    public let ulHeight: UInt32
    public let bFaceLen: UInt8
    public let fontFace: String
    
    public init(dataStream: inout DataStream) throws {
        /// Version (1 byte): An unsigned integer that specifies the version of StdFont that is stored in the file. MUST be set to 1.
        self.version = try dataStream.read()
        guard self.version == 1 else {
            throw OfficeFormFileError.corrupted
        }
        
        /// sCharset (2 bytes): A signed integer that specifies the character set of the font.
        self.sCharset = try dataStream.read(endianess: .littleEndian)
        
        /// bFlags (1 byte): A FONTFLAGS that specifies style characteristics of the font.
        self.bFlags = try FONTFLAGS(dataStream: &dataStream)
        
        /// sWeight (2 bytes): A signed integer that specifies the weight of the font. MUST be in the range from zero through 1000. A value of
        /// zero specifies that the weight is to be determined by the application. A value in the range from 1 through 1000 specifies a weight,
        /// where 1 specifies the lightest type and 1000 specifies the darkest type.
        let sWeight: Int16 = try dataStream.read(endianess: .littleEndian)
        guard sWeight >= 0 && sWeight <= 1000 else {
            throw OfficeFormFileError.corrupted
        }
        
        self.sWeight = sWeight
        
        /// ulHeight (4 bytes): An unsigned integer that specifies the height, in ten-thousandths of a point, of the font. MUST be greater than
        /// zero and less than or equal to 655350000.
        self.ulHeight = try dataStream.read(endianess: .littleEndian)
        guard self.ulHeight <= 655350000 else {
            throw OfficeFormFileError.corrupted
        }
        
        /// bFaceLen (1 byte): An unsigned integer that specifies the length, in bytes, of FontFace. MUST be less than 32.
        self.bFaceLen = try dataStream.read()
        guard self.bFaceLen < 32 else {
            throw OfficeFormFileError.corrupted
        }
        
        /// FontFace (variable): An ASCII string that specifies the name of the font.
        self.fontFace = try dataStream.readString(count: Int(self.bFaceLen), encoding: .ascii)!
    }
}
