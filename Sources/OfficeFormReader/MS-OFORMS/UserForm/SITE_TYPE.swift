//
//  SITE_TYPE.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.10.8 SITE_TYPE
/// Specifies the type of an embedded control. MUST be set to 1.
public enum SITE_TYPE: UInt8 {
    /// ST_Ole 0x01 An OLE control.
    case ole = 0x01
    
    public init(dataStream: inout DataStream) throws {
        guard let value = Self(rawValue: try dataStream.read()) else {
            throw OfficeFormFileError.corrupted
        }
        
        self = value
    }
}
