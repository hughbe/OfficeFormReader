//
//  OleColorType.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.4.10 OleColorType
/// The following table specifies the values of the OleColorType enumeration and their meanings with respect to an RgbColorOrPaletteEntry.
public enum OleColorType: UInt8 {
    /// Default 0x00 Specifies that the client application determines whether the RgbColorOrPaletteEntry is a PaletteEntry, in which case Red
    /// MUST be set to zero, or an RgbColor, in which case Red specifies the red value of a color.
    case `default` = 0x00
    
    /// PaletteEntry 0x01 Specifies that the GreenAndBlueOrPaletteIndex is an index into a client application color palette and that Red MUST
    /// be set to zero.
    case paletteEntry = 0x01
    
    /// RgbColor 0x02 Specifies that GreenAndBlueOrPaletteIndex specifies the green and blue values of a color, where the low-order byte
    /// specifies blue and the high-order byte specifies green, and that Red specifies the red value of a color.
    case rgbColor = 0x02
    
    /// SystemPalette 0x80 Specifies that GreenAndBlueOrPaletteIndex is an index into the system color palette and that Red MUST be set to zero.
    case systemPalette = 0x80
    
    public init(dataStream: inout DataStream) throws {
        guard let value = Self(rawValue: try dataStream.read()) else {
            throw OfficeFormFileError.corrupted
        }
        
        self = value
    }
}
