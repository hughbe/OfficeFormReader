//
//  PARAFORMAT_Alignment.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.60.1 PARAFORMAT_Alignment
/// The following table specifies the values of this enumeration and their meanings.
public enum PARAFORMAT_Alignment: UInt8 {
    /// PFA_LEFT 0x01 The text used by the control is aligned to the left.
    case left = 0x01
    
    /// PFA_RIGHT 0x02 The text used by the control is aligned to the right.
    case right = 0x02
    
    /// PFA_CENTER 0x03 The text used by the control is aligned to the center.
    case center = 0x03
    
    public init(dataStream: inout DataStream) throws {
        guard let value = Self(rawValue: try dataStream.read()) else {
            throw OfficeFormFileError.corrupted
        }
        
        self = value
    }
}
