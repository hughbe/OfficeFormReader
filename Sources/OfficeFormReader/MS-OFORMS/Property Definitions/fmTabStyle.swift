//
//  fmTabStyle.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.87.1 fmTabStyle
/// The following table specifies the values of this enumeration and their meanings.
public enum fmTabStyle: UInt32 {
    /// fmTabStyleTabs 0x00000000 Tabs
    case tabs = 0x00000000
    
    /// fmTabStyleButtons 0x00000001 Toggle buttons
    case buttons = 0x00000001
    
    /// fmTabStyleNone 0x00000002 Not displayed
    case none = 0x00000002
    
    public init(dataStream: inout DataStream) throws {
        guard let value = Self(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFormFileError.corrupted
        }
        
        self = value
    }
}
