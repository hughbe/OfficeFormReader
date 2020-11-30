//
//  fmMultiSelect.swift
//
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.52.1 fmMultiSelect
/// The following table specifies the values of this enumeration and their meanings.
public enum fmMultiSelect: UInt8 {
    /// fmMultiSelectSingle 0x00 Only one item can be selected.
    case single = 0x00
    
    /// fmMultiSelectMulti 0x01 Pressing the SPACEBAR or clicking selects or deselects an item in the list.
    case multi = 0x01
    
    /// fmMultiSelectExtended 0x02 Pressing SHIFT and clicking the mouse, or pressing SHIFT and one of the arrow keys, extends the
    /// selection from the previously selected item to the current item. Pressing CTRL and clicking the mouse selects or deselects an item.
    case extended = 0x02
    
    public init(dataStream: inout DataStream) throws {
        guard let value = Self(rawValue: try dataStream.read()) else {
            throw OfficeFormFileError.corrupted
        }
        
        self = value
    }
}
