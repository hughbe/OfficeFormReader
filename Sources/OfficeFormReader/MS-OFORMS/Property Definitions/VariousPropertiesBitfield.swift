//
//  VariousPropertiesBitfield.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.96.1 VariousPropertiesBitfield
/// Specifies the VariousPropertyBits property.
public struct VariousPropertiesBitfield {
    public let reserved1: Bool
    public let enabled: Bool
    public let locked: Bool
    public let backStyle: Bool
    public let reserved2: Bool
    public let unusedBits1: UInt8
    public let columnHeads: Bool
    public let integralHeight: Bool
    public let matchRequired: Bool
    public let alignment: Bool
    public let editable: Bool
    public let imeMode: fmIMEMode
    public let dragBehavior: Bool
    public let enterKeyBehavior: Bool
    public let enterFieldBehavior: Bool
    public let tabKeyBehavior: Bool
    public let wordWrap: Bool
    public let unusedBits2: Bool
    public let bordersSuppress: Bool
    public let selectionMargin: Bool
    public let autoWordSelect: Bool
    public let autoSize: Bool
    public let hideSelection: Bool
    public let autoTab: Bool
    public let multiLine: Bool
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - Reserved1 (1 bit): MUST be set to 1 and MUST be ignored.
        /// Applies to: CheckBox | ComboBox | CommandButton | Image | Label | ListBox | OptionButton | ScrollBar | SpinButton | TabStrip |
        /// TextBox | ToggleButton
        self.reserved1 = flags.readBit()
        
        /// B - Enabled (1 bit): Specifies whether the control can receive the focus and respond to usergenerated events.
        /// Applies to: CheckBox | ComboBox | CommandButton | Image | Label | ListBox | OptionButton | ScrollBar | SpinButton | TabStrip |
        /// TextBox | ToggleButton
        self.enabled = flags.readBit()
        
        /// C - Locked (1 bit): Specifies whether data in the control is locked for editing.
        /// Applies to: CheckBox | ComboBox | CommandButton | ListBox | OptionButton | TextBox | ToggleButton
        self.locked = flags.readBit()
        
        /// D - BackStyle (1 bit): Specifies the background style for this control. A value of 1 specifies that the control is opaque, and a value
        /// of zero specifies that the control is transparent. MUST be set to 1 for the following controls: ListBox, TabStrip, ScrollBar, SpinButton
        /// Applies to: CheckBox | ComboBox | CommandButton | Image | Label | ListBox | OptionButton | ScrollBar | SpinButton | TabStrip |
        /// TextBox | ToggleButton
        self.backStyle = flags.readBit()
        
        /// E - Reserved2 (1 bit): MUST be set to 1 and MUST be ignored.
        /// Applies to: CheckBox | ComboBox | CommandButton | Image | Label | ListBox | OptionButton | ScrollBar | SpinButton | TabStrip |
        /// TextBox | ToggleButton
        self.reserved2 = flags.readBit()
        
        /// UnusedBits1 (5 bits): MUST be set to zero.
        self.unusedBits1 = UInt8(flags.readBits(count: 5))
        
        /// F - ColumnHeads (1 bit): Specifies whether column headings are displayed.
        /// Applies to: ComboBox | ListBox
        self.columnHeads = flags.readBit()
        
        /// G - IntegralHeight (1 bit): For ListBox and TextBox controls, specifies whether the control shows only complete lines of text. MUST
        /// be set to 1 for the following controls: CheckBox, OptionButton, and ToggleButton.
        /// Applies to: CheckBox | ListBox | OptionButton | TextBox | ToggleButton
        self.integralHeight = flags.readBit()
        
        /// H - MatchRequired (1 bit): Specifies whether a value entered into the TextBox part of a ComboBox is required to match an entry in
        /// the ListBox part of the control.
        /// Applies to: ComboBox
        self.matchRequired = flags.readBit()
        
        /// I - Alignment (1 bit): Specifies the position of the Caption relative to the control. A value of 1 specifies that the Caption is to the left
        /// of the control, and a value of zero specifies that the Caption is to the right of the control.<15>
        /// Applies to: CheckBox | OptionButton
        self.alignment = flags.readBit()
        
        /// J - Editable (1 bit): Specifies whether the user can type into the control. MUST be set to 1 for TextBox controls. MUST be set to 1
        /// for ComboBox controls in which the DisplayStyle property is set to 0x03 (fmDisplayStyleCombo). SHOULD be set to zero for
        /// ComboBox controls in which the DisplayStyle property is set to 0x07 (fmDisplayStyleDropList), but MAY be set to 1, and MUST
        /// be ignored.<16>
        /// Applies to: ComboBox | TextBox
        self.editable = flags.readBit()
        
        /// IMEMode (4 bits): An fmIMEMode that specifies the default run-time mode of the Input Method Editor (IME) for the control as it
        /// receives focus.
        /// Applies to<17>: CheckBox | ComboBox | CommandButton | Image | Label | ListBox | OptionButton | ScrollBar | SpinButton |
        /// TabStrip | TextBox | ToggleButton
        guard let imeMode = fmIMEMode(rawValue: UInt8(flags.readBits(count: 4))) else {
            throw OfficeFormFileError.corrupted
        }
        
        self.imeMode = imeMode
        
        /// K - DragBehavior (1 bit): Specifies whether dragging and dropping is enabled for the control.
        /// Applies to: ComboBox | TextBox
        self.dragBehavior = flags.readBit()
        
        /// L - EnterKeyBehavior (1 bit): Specifies the behavior of the ENTER key. A value of 1 specifies that pressing ENTER creates a new line.
        /// A value of zero specifies that pressing ENTER moves the focus to the next object in the tab order.
        /// Applies to: TextBox
        self.enterKeyBehavior = flags.readBit()
        
        /// M - EnterFieldBehavior (1 bit): Specifies selection behavior when entering the control. A value of 1 specifies that the selection remains
        /// unchanged from the last time that the control was active. A value of zero specifies that all text in the control is selected when
        /// entering the control.
        /// Applies to: ComboBox | TextBox
        self.enterFieldBehavior = flags.readBit()
        
        /// N - TabKeyBehavior (1 bit): Specifies whether tab characters can exist in the text of the control. A value of 1 specifies that pressing
        /// the TAB key inserts a tab character into the text of the control. A value of zero specifies that pressing the TAB key moves the focus
        /// to the next object in the tab order.
        /// Applies to: TextBox
        self.tabKeyBehavior = flags.readBit()
        
        /// O - WordWrap (1 bit): Specifies whether the contents of the control automatically wrap at the end of a line. MUST be set to 1 for the
        /// following controls: ComboBox and ListBox.
        /// Applies to: CheckBox | ComboBox | CommandButton | Label | ListBox | OptionButton | TextBox | ToggleButton
        self.wordWrap = flags.readBit()
        
        /// P - UnusedBits2 (1 bit): MUST be set to zero.
        self.unusedBits2 = flags.readBit()
        
        /// Q - BordersSuppress (1 bit): SHOULD be set to zero.<18>
        /// Applies to: CheckBox | ComboBox | ListBox | OptionButton | TextBox | ToggleButton
        self.bordersSuppress = flags.readBit()
        
        /// R - SelectionMargin (1 bit): Specifies whether the user can select a line of text by clicking in the region to the left of the text.
        /// MUST be set to 1 for the following controls: CheckBox, ListBox, OptionButton, and ToggleButton.
        /// Applies to: CheckBox | ComboBox | ListBox | OptionButton | TextBox | ToggleButton
        self.selectionMargin = flags.readBit()
        
        /// S - AutoWordSelect (1 bit): Specifies the basic unit used to extend a selection. A value of 1 specifies that the basic unit is a single
        /// character. A value of zero specifies that the basic unit is a whole word. MUST be set to 1 for the following controls: CheckBox,
        /// ListBox, OptionButton, and ToggleButton.
        /// Applies to: CheckBox | ComboBox | ListBox | OptionButton | TextBox | ToggleButton
        self.autoWordSelect = flags.readBit()
        
        /// T - AutoSize (1 bit): Specifies whether the control automatically resizes to display its entire contents.
        /// This bit does not apply to the Image control and MUST be set to zero for that type of control. The Image control uses a separate
        /// AutoSize property that is stored in the ImagePropMask.
        /// Applies to: CheckBox | ComboBox | CommandButton | Label | OptionButton | TextBox | ToggleButton
        self.autoSize = flags.readBit()
        
        /// U - HideSelection (1 bit): Specifies whether selected text in the control appears highlighted when the control does not have focus.
        /// MUST be set to 1 for the following controls: CheckBox, ListBox, OptionButton, and ToggleButton.
        /// Applies to: CheckBox | ComboBox | ListBox | OptionButton | TextBox | ToggleButton
        self.hideSelection = flags.readBit()
        
        /// V - AutoTab (1 bit): Specifies whether the focus automatically moves to the next control when the user enters the maximum number
        /// of characters specified by the MaxLength property.
        /// Applies to: ComboBox | TextBox
        self.autoTab = flags.readBit()
        
        /// W - MultiLine (1 bit): Specifies whether the control can display more than one line of text.
        /// Applies to: TextBox
        self.multiLine = flags.readBit()
    }
}
