//
//  fmListStyle.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.42.1 fmListStyle
/// The following table specifies the values of this enumeration and their meanings.
public enum fmListStyle: UInt8 {
    /// fmListStylePlain 0x00 Displays a list in which the background of an item is highlighted when it is selected.
    case plain = 0x00
    
    /// fmListStyleOption 0x01 Displays a list in which an option button (when the MultiSelect property is set to fmMultiSelectSingle) or a
    /// checkbox (when the MultiSelect property is fmMultiSelectMulti or fmMultiSelectExtended) next to each entry displays the selection
    /// state of that item.
    case option = 0x01
    
    public init(dataStream: inout DataStream) throws {
        guard let value = Self(rawValue: try dataStream.read()) else {
            throw OfficeFormFileError.corrupted
        }
        
        self = value
    }
}
