//
//  fmDisplayStyle.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.20.1 fmDisplayStyle
/// The following table specifies the values of this enumeration and their meanings.
public enum fmDisplayStyle: UInt8 {
    /// fmDisplayStyleText 0x01 A TextBox control.
    case text = 0x01
    
    /// fmDisplayStyleList 0x02 A ListBox control.
    case list = 0x02
    
    /// fmDisplayStyleCombo 0x03 A ComboBox control in which the TextBox part is directly editable.<4>
    case combox = 0x03
    
    /// fmDisplayStyleCheckBox 0x04 A CheckBox control.
    case checkBox = 0x04
    
    /// fmDisplayStyleOptionButton 0x05 An OptionButton control.
    case optionButton = 0x05
    
    /// fmDisplayStyleToggle 0x06 A ToggleButton control.
    case toggle = 0x06
    
    /// fmDisplayStyleDropList 0x07 A ComboBox control in which the TextBox part is not editable except by selecting a different value from
    /// the ListBox part.<5>
    case dropList = 0x07
    
    public init(dataStream: inout DataStream) throws {
        guard let value = Self(rawValue: try dataStream.read()) else {
            throw OfficeFormFileError.corrupted
        }
        
        self = value
    }
}
