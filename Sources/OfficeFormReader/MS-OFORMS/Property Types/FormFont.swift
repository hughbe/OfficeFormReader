//
//  FormFont.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream
import WindowsDataTypes

/// [MS-OFORMS] 2.4.6 FormFont
/// Specifies the font type to load based on the FontGUID of the GuidAndFont that contains this structure. The value of FontGUID is stored as
/// specified by [MS-DTYP] section 2.3.4.2, but it is displayed in the following table using Curly Braced GUID String Syntax, as specified by
/// [MS-DTYP] section 2.3.4.3.
public enum FormFont {
    /// {0BE35203-8F91-11CE-9DE3- 00AA004BB851} Specifies that the Font of the GuidAndFont that contains this FormFont is a StdFont.
    case stdFont(_: StdFont)
    
    /// {AFC20920-DA4E-11CE-B94300AA006887B4} Specifies that the Font of the GuidAndFont that contains this FormFont is a TextProps.
    case textProps(_: TextProps)
    
    public init(dataStream: inout DataStream, guid: GUID) throws {
        switch guid {
        case GUID(0x0BE35203, 0x8F91, 0x11CE, 0x9DE3, 0x00AA004BB851):
            self = .stdFont(try StdFont(dataStream: &dataStream))
        case GUID(0xAFC20920, 0xDA4E, 0x11CE, 0x87B4, 0xB94300AA0068):
            self = .textProps(try TextProps(dataStream: &dataStream))
        default:
            throw OfficeFormFileError.corrupted
        }
    }
}
