//
//  fmDblClickControlMode.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.18.1 fmDblClickControlMode
/// The following table specifies the values of this enumeration and their meanings.
public enum fmDblClickControlMode: UInt8 {
    /// fmDblClickControlModeInherit 0xFE Use the same value as the client application design-time settings.
    case inherit = 0xFE
    
    /// fmDblClickControlModeSelectText 0x00 Select any text that is under the cursor.
    case selectText = 0x00
    
    /// fmDblClickControlModeEditCode 0x01 Display and set focus to the code associated with the control that is under the cursor.
    case editCode = 0x01
    
    /// fmDblClickControlModeEditProperties 0x02 Display the properties of the control that is under the cursor.
    case editProperties = 0x02
    
    public init(dataStream: inout DataStream) throws {
        guard let value = Self(rawValue: try dataStream.read()) else {
            throw OfficeFormFileError.corrupted
        }
        
        self = value
    }
}
