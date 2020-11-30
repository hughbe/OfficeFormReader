//
//  TextPropsDataBlock.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.3.3 TextPropsDataBlock
/// Specifies the text properties of the control that are 4 bytes or smaller and are not set to the file format defaults. If the corresponding bit in
/// the PropMask of the TextProps that contains this TextPropsDataBlock is set to zero, the property value MUST NOT be stored in the file.
public struct TextPropsDataBlock {
    public let fontName: CountOfBytesWithCompressionFlag?
    public let fontEffects: fmFontEffects?
    public let fontHeight: FontHeight?
    public let fontCharSet: UInt8?
    public let fontPitchAndFamily: fmFontPitchAndFamily?
    public let paragraphAlign: PARAFORMAT_Alignment?
    public let fontWeight: FontWeight?
    
    public init(dataStream: inout DataStream, mask: TextPropsPropMask) throws {
        let startPosition = dataStream.position
        
        /// FontName (4 bytes): A CountOfBytesWithCompressionFlag that specifies the size and compression of the FontName property.
        if mask.fFontName {
            self.fontName = try CountOfBytesWithCompressionFlag(dataStream: &dataStream)
        } else {
            self.fontName = nil
        }
        
        /// FontEffects (4 bytes): An fmFontEffects that specifies the value of the FontEffects property.
        if mask.fFontEffects {
            self.fontEffects = try fmFontEffects(dataStream: &dataStream)
        } else {
            self.fontEffects = nil
        }
        
        /// FontHeight (4 bytes): An unsigned integer that specifies the value of the FontHeight property.
        if mask.fFontHeight {
            self.fontHeight = try FontHeight(dataStream: &dataStream)
        } else {
            self.fontHeight = nil
        }
        
        /// FontCharSet (1 byte): An unsigned integer that specifies the value of the FontCharSet property.
        if mask.fFontCharSet {
            self.fontCharSet = try dataStream.read()
        } else {
            self.fontCharSet = nil
        }
        
        /// FontPitchAndFamily (1 byte): An fmFontPitchAndFamily that specifies the value of the FontPitchAndFamily property.
        if mask.fFontPitchAndFamily {
            self.fontPitchAndFamily = try fmFontPitchAndFamily(dataStream: &dataStream)
        } else {
            self.fontPitchAndFamily = nil
        }
        
        /// ParagraphAlign (1 byte): A PARAFORMAT_Alignment that specifies the value of the ParagraphAlign property.
        if mask.fParagraphAlign {
            self.paragraphAlign = try PARAFORMAT_Alignment(dataStream: &dataStream)
        } else {
            self.paragraphAlign = nil
        }
        
        /// Padding1 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fFontWeight {
            try dataStream.twoByteAlign(startPosition: startPosition)
        }
        
        /// FontWeight (2 bytes): An unsigned integer that specifies the value of the FontWeight property.
        if mask.fFontWeight {
            self.fontWeight = try FontWeight(dataStream: &dataStream)
        } else {
            self.fontWeight = nil
        }
        
        /// Padding2 (variable): MUST be set to zero. The size of this field is the least number of bytes required to make the total size, in
        /// bytes, of this TextPropsDataBlock divisible by 4.
        try dataStream.fourByteAlign(startPosition: startPosition)
    }
}
