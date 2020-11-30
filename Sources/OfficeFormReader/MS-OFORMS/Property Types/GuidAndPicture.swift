//
//  GuidAndPicture.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream
import WindowsDataTypes

/// [MS-OFORMS] 2.4.8 GuidAndPicture
/// Specifies a combination of a GUID, as specified in [MS-DTYP] section 2.3.4, and a StdPicture that specify the StreamData for both the
/// MouseIcon and Picture properties.
public struct GuidAndPicture {
    public let CLSID_stdPicture: GUID
    public let stdPicture: StdPicture
    
    public init(dataStream: inout DataStream) throws {
        /// CLSID_StdPicture (16 bytes): A GUID, as specified in [MS-DTYP] section 2.3.4. MUST be set to {0BE35204-8F91-11CE-9DE3-00AA004BB851}.
        self.CLSID_stdPicture = try GUID(dataStream: &dataStream)
        guard self.CLSID_stdPicture == GUID(0x0BE35204, 0x8F91, 0x11CE, 0x9DE3, 0x00AA004BB851) else {
            throw OfficeFormFileError.corrupted
        }
        
        /// StdPicture (variable): A StdPicture that specifies the picture data for either the MouseIcon or Picture property.
        self.stdPicture = try StdPicture(dataStream: &dataStream)
    }
}
