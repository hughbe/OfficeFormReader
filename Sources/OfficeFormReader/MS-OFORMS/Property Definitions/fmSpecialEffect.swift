//
//  fmSpecialEffect.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.80.1 fmSpecialEffect
/// The following table specifies the values of this enumeration and their meanings. In this enumeration, "form" refers to the surface on which the
/// control appears.
public enum fmSpecialEffect: UInt8 {
    /// fmSpecialEffectFlat 0x00 Control appears flat.
    case flat = 0x00
    
    /// fmSpecialEffectRaised 0x01 Control appears to be raised up from the form.
    case raised = 0x01
    
    /// fmSpecialEffectSunken 0x02 Control appears to be carved into the form.
    case sunken = 0x02
    
    /// fmSpecialEffectEtched 0x03 The control border appears to be carved into the form.
    case etched = 0x03
    
    /// fmSpecialEffectBump 0x06 The control border appears to be raised up from the form.
    case bump = 0x06
    
    public init(dataStream: inout DataStream) throws {
        guard let value = Self(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFormFileError.corrupted
        }
        
        self = value
    }
}
