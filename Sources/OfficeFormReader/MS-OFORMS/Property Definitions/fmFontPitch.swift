//
//  fmFontPitch.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

/// [MS-OFORMS] 2.5.29.2 fmFontPitch
/// The following table specifies the values of the fmFontPitch enumeration and their meanings.
public enum fmFontPitch: UInt8 {
    /// DEFAULT_PITCH 0x0 Does not specify a character pitch. Behavior is determined by the client application using this field.
    case `default` = 0x0
    
    /// FIXED_PITCH 0x1 All characters have the same width.
    case fixd = 0x1
    
    /// VARIABLE_PITCH 0x2 Characters have varying widths.
    case variable = 0x2
}
