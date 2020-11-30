//
//  fmFontEffects.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.26.1 fmFontEffects
/// Specifies the possible values of the FontEffects property.
public struct fmFontEffects {
    public let fBold: Bool
    public let fItalic: Bool
    public let fUnderline: Bool
    public let fStrikeout: Bool
    public let unusedBits1: UInt16
    public let fDisabled: Bool
    public let unusedBits2: UInt16
    public let fAutoColor: Bool
    public let unusedBits3: Bool
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fBold (1 bit): Specifies whether the Bold effect has been applied to the font.
        self.fBold = flags.readBit()
        
        /// B - fItalic (1 bit): Specifies whether the Italic effect has been applied to the font.
        self.fItalic = flags.readBit()
        
        /// C - fUnderline (1 bit): Specifies whether the Underline effect has been applied to the font.
        self.fUnderline = flags.readBit()
        
        /// D - fStrikeout (1 bit): Specifies whether the Strikeout effect has been applied to the font.
        self.fStrikeout = flags.readBit()
        
        /// UnusedBits1 (9 bits): MUST be set to zero.
        self.unusedBits1 = UInt16(flags.readBits(count: 9))
        
        /// E - fDisabled (1 bit): Specifies whether the Disabled effect has been applied to the font.
        self.fDisabled = flags.readBit()
        
        /// UnusedBits2 (16 bits): MUST be set to zero.
        self.unusedBits2 = UInt16(flags.readBits(count: 16))
        
        /// F - fAutoColor (1 bit): Specifies whether the AutoColor effect has been applied to the font.
        self.fAutoColor = flags.readBit()
        
        /// G - UnusedBits3 (1 bit): MUST be set to zero.
        self.unusedBits3 = flags.readBit()
    }
}
