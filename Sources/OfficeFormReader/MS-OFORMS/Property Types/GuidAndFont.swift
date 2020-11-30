//
//  GuidAndFont.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream
import WindowsDataTypes

/// [MS-OFORMS] 2.4.7 GuidAndFont
/// A GUID and a FormFont that specify the StreamData for the Font property.
public struct GuidAndFont {
    public let fontGUID: GUID
    public let font: FormFont
    
    public init(dataStream: inout DataStream) throws {
        /// FontGUID (16 bytes): A GUID, as specified in [MS-DTYP] section 2.3.4, that specifies the type of font that is stored in Font.
        /// MUST be the GUID of one of the types of FormFont.
        self.fontGUID = try GUID(dataStream: &dataStream)
        
        /// Font (variable): A FormFont that specifies a font.
        self.font = try FormFont(dataStream: &dataStream, guid: self.fontGUID)
    }
}
