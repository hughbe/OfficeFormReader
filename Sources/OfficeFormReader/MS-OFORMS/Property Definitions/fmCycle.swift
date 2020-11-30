//
//  fmCycle.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.16.1 fmCycle
/// The following table specifies the values of the fmCycle enumeration and their meanings.
public enum fmCycle: UInt8 {
    /// fmCycleAllForms 0x00 The focus is next set to the first control on the next form, returning to the first control of this form only after
    /// all controls on all other forms have been reached.
    case allForms = 0x00
    
    /// fmCycleCurrentForm 0x02 The focus is next set to the first control on this form, ignoring other forms.
    case currentForm = 0x02
    
    public init(dataStream: inout DataStream) throws {
        guard let value = Self(rawValue: try dataStream.read()) else {
            throw OfficeFormFileError.corrupted
        }
        
        self = value
    }
}
