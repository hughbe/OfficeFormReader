//
//  FONTFLAGS.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.4.3 FONTFLAGS
/// Specifies a bit field that specifies style characteristics of a font.
public struct FONTFLAGS {
    public let fBold: Bool
    public let fItalic: Bool
    public let fUnderline: Bool
    public let fStrikethrough: Bool
    public let unused: UInt8
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - FONT_fBold (1 bit): Specifies whether the font style is bold. MUST be set to zero.
        self.fBold = flags.readBit()
        
        /// B - FONT_fItalic (1 bit): Specifies whether the font style is italic.
        self.fItalic = flags.readBit()
        
        /// C - FONT_fUnderline (1 bit): Specifies whether the font style is underlined.
        self.fUnderline = flags.readBit()
        
        /// D - FONT_fStrikethrough (1 bit): Specifies whether the font style is strikethrough.
        self.fStrikethrough = flags.readBit()
        
        /// Unused (4 bits): MUST be set to zero.
        self.unused = flags.readRemainingBits()
    }
}
