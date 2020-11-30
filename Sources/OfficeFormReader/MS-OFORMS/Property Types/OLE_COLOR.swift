//
//  OLE_COLOR.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.4.9 OLE_COLOR
/// Specifies a color.
public struct OLE_COLOR {
    public let rgbColorOrPaletteEntry: RgbColorOrPaletteEntry
    public let oleColorType: OleColorType
    
    public init(dataStream: inout DataStream) throws {
        /// RgbColorOrPaletteEntry (3 bytes): An RgbColorOrPaletteEntry that specifies either the red, green, and blue values of a color or an
        /// index into a color palette, based on the value of OleColorType.
        self.rgbColorOrPaletteEntry = try RgbColorOrPaletteEntry(dataStream: &dataStream)
        
        /// OleColorType (1 byte): An OleColorType that specifies the meaning of RgbColorOrPaletteEntry.
        self.oleColorType = try OleColorType(dataStream: &dataStream)
    }
}
