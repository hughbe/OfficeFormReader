//
//  fmClickControlMode.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.12.1 fmClickControlMode
/// The following table specifies the values of this enumeration and their meanings.
public enum fmClickControlMode: UInt8 {
    /// fmClickControlModeInherit 0xFE Use the same value as the client application design-time settings.
    case inherit = 0xFE
    
    /// fmClickControlModeDefault 0xFF Use the client application default value.
    case `default` = 0xFF
    
    /// fmClickControlModeInsertionPoint 0x00 Select the control under the cursor, and set the insertion point under the cursor, both on the
    /// same click.
    case insertionPoint = 0x00
    
    /// fmClickControlModeSelectThenInsert 0x01 If the control under the cursor is already selected, set the insertion point under the cursor;
    /// otherwise, select the control.
    case selectThenInsert = 0x01
    
    public init(dataStream: inout DataStream) throws {
        guard let value = Self(rawValue: try dataStream.read()) else {
            throw OfficeFormFileError.corrupted
        }
        
        self = value
    }
}
