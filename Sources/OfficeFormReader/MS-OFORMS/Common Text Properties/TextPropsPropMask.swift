//
//  TextPropsPropMask.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.3.2 TextPropsPropMask
/// Specifies the text properties of the control are not set to the file format default. For each bit, a value of zero specifies that the corresponding
/// property is the file format default and is not stored in the file.
public struct TextPropsPropMask {
    public let fFontName: Bool
    public let fFontEffects: Bool
    public let fFontHeight: Bool
    public let unusedBits1: Bool
    public let fFontCharSet: Bool
    public let fFontPitchAndFamily: Bool
    public let fParagraphAlign: Bool
    public let fFontWeight: Bool
    public let unusedBits2: UInt32
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fFontName (1 bit): Specifies whether the size and compression flag of the FontName property are stored in the
        /// DataBlock.FontName of the TextProps that contains this TextPropsPropMask and the FontName string is stored in the
        /// ExtraDataBlock.FontName of the TextProps.
        self.fFontName = flags.readBit()
        
        /// B - fFontEffects (1 bit): Specifies whether the FontEffects property is stored in the DataBlock.FontEffects of the TextProps that
        /// contains this TextPropsPropMask.
        self.fFontEffects = flags.readBit()
        
        /// C - fFontHeight (1 bit): Specifies whether the FontHeight property is stored in the DataBlock.FontHeight of the TextProps that
        /// contains this TextPropsPropMask.
        self.fFontHeight = flags.readBit()
        
        /// D - UnusedBits1 (1 bit): MUST be set to zero.
        self.unusedBits1 = flags.readBit()
        
        /// E - fFontCharSet (1 bit): Specifies whether the FontCharSet property is stored in the DataBlock.FontCharSet of the TextProps that
        /// contains this TextPropsPropMask.
        self.fFontCharSet = flags.readBit()
        
        /// F - fFontPitchAndFamily (1 bit): Specifies whether the FontPitchAndFamily property is stored in the DataBlock.FontPitchAndFamily
        /// of the TextProps that contains this TextPropsPropMask.
        self.fFontPitchAndFamily = flags.readBit()
        
        /// G - fParagraphAlign (1 bit): Specifies whether the ParagraphAlign property is stored in the DataBlock.ParagraphAlign of the
        /// TextProps that contains this TextPropsPropMask.
        self.fParagraphAlign = flags.readBit()
        
        /// H - fFontWeight (1 bit): Specifies whether the FontWeight property is stored in the DataBlock.FontWeight of the TextProps that
        /// contains this TextPropsPropMask.
        self.fFontWeight = flags.readBit()
        
        /// UnusedBits2 (24 bits): MUST be set to zero.
        self.unusedBits2 = flags.readRemainingBits()
    }
}
