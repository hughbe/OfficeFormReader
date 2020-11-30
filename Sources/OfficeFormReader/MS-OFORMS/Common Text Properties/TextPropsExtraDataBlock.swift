//
//  TextPropsExtraDataBlock.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.3.4 TextPropsExtraDataBlock
/// Specifies the text properties of the control that are larger than 4 bytes and are not set to the file format defaults. If the corresponding bit in
/// the PropMask of the TextProps that contains this TextPropsExtraDataBlock is set to zero, the property value MUST NOT be stored in the file.
public struct TextPropsExtraDataBlock {
    public let fontName: fmString?
    
    public init(dataStream: inout DataStream, mask: TextPropsPropMask, data: TextPropsDataBlock) throws {
        /// FontName (variable): An fmString that specifies the FontName property. The size and compression of the string is specified by
        /// the DataBlock.FontName of the TextProps that contains this TextPropsExtraDataBlock.
        if mask.fFontName {
            self.fontName = try fmString(dataStream: &dataStream, count: data.fontName!)
        } else {
            self.fontName = nil
        }
    }
}
