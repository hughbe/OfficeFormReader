//
//  fmFontFamily.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

/// [MS-OFORMS] 2.5.29.3 fmFontFamily
/// The following table specifies the values of the fmFontFamily enumeration and their meanings.
public enum fmFontFamily: UInt8 {
    /// FF_DONTCARE 0x0 Specifies that the default font is used.
    case dontCare = 0x0
    
    /// FF_ROMAN 0x1 Specifies that fonts with variable stroke width (proportional) and with serifs are used.
    case roman = 0x1
    
    /// FF_SWISS 0x2 Specifies that fonts with variable stroke width (proportional) and without serifs are used.
    case swiss = 0x2
    
    /// FF_MODERN 0x3 Specifies that fonts with constant stroke width (monospace), with or without serifs are used.
    case modern = 0x3
    
    /// FF_SCRIPT 0x4 Specifies that fonts designed to look like handwriting are used.
    case script = 0x4
    
    /// FF_DECORATIVE 0x5 Specifies that novelty fonts are used.
    case decorative = 0x5
}
