//
//  RgbColorOrPaletteEntry.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.4.11 RgbColorOrPaletteEntry
/// Specifies the red, green, and blue values of a color or an index into a color palette, based on the value of an associated OleColorType.
public struct RgbColorOrPaletteEntry {
    public let greenAndBlueOrPaletteIndex: UInt16
    public let red: UInt8
    
    public init(dataStream: inout DataStream) throws {
        /// GreenAndBlueOrPaletteIndex (2 bytes): An unsigned integer that specifies the green and blue values of a color or an index into a
        /// color palette. If the value of the associated OleColorType is PaletteEntry or SystemPalette, or if the value is set to Default and the
        /// client application determines that the color is a PaletteEntry, this field is an index into the corresponding color palette. Otherwise,
        /// the low-order byte specifies the blue value of a color and the high-order byte specifies the green value of the color.
        self.greenAndBlueOrPaletteIndex = try dataStream.read(endianess: .littleEndian)
        
        /// Red (1 byte): An unsigned integer that specifies the red value of a color. If the value of the associated OleColorType is PaletteEntry
        /// or SystemPalette, or if the value is set to Default and the client application determines that the color is a PaletteEntry, this field
        /// MUST be set to zero.
        self.red = try dataStream.read()
    }
}
