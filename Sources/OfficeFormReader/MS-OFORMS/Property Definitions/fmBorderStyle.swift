//
//  fmBorderStyle.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

import DataStream

/// [MS-OFORMS] 2.5.8.1 fmBorderStyle
/// The following table specifies the values of the fmBorderStyle enumeration and their meanings.
public enum fmBorderStyle: UInt8 {
    /// fmBorderStyleNone 0x00 The control has no visible border line.
    case none = 0x00
    
    /// fmBorderStyleSingle 0x01 The control has a single-line border.
    case single = 0x01
    
    public init(dataStream: inout DataStream) throws {
        guard let value = Self(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFormFileError.corrupted
        }
        
        self = value
    }
}
