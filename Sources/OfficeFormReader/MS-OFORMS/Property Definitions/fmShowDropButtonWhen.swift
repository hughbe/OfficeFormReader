//
//  fmShowDropButtonWhen.swift
//
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.77.1 fmShowDropButtonWhen
/// The following table specifies the values of this enumeration and their meanings.
public enum fmShowDropButtonWhen: UInt8 {
    /// fmShowDropButtonWhenNever 0x00 Never show the drop button.
    case never = 0x00
    
    /// fmShowDropButtonWhenFocus 0x01 Show the drop button when the control has the focus.
    case focus = 0x01
    
    /// fmShowDropButtonWhenAlways 0x02 Always show the drop button.
    case always = 0x02
    
    public init(dataStream: inout DataStream) throws {
        guard let value = Self(rawValue: try dataStream.read()) else {
            throw OfficeFormFileError.corrupted
        }
        
        self = value
    }
}
