//
//  FormEmbeddedActiveXControlCached.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import CompoundFileReader
import DataStream

/// [MS-OFORMS] 2.4.5 FormEmbeddedActiveXControlCached
/// Specifies the type of embedded control for values of the ClsidCacheIndex property less than 0x7FFF. Parent controls are stored as specified
/// in section 2.1.2.2.2. Controls that cannot be parents are stored as specified in section 2.1.2.2.1.
public enum FormEmbeddedActiveXControlCached {
    /// 7 Form
    case form(_: UserForm)
    
    /// 12 Image
    case image(_: ImageControl)
    
    /// 14 Frame
    case frame(_: FrameControl)
    
    /// 15 MorphData
    case morphData(_: MorphDataControl)
    
    /// 16 SpinButton
    case spinButton(_: SpinButtonControl)
    
    /// 17 CommandButton
    case commandButton(_: CommandButtonControl)
    
    /// 18 TabStrip
    case tabStrip(_: TabStripControl)
    
    /// 21 Label
    case label(_: LabelControl)
    
    /// 23 TextBox
    case textBox(_: MorphDataControl)
    
    /// 24 ListBox
    case listBox(_: MorphDataControl)
    
    /// 25 ComboBox
    case comboBox(_: MorphDataControl)
    
    /// 26 CheckBox
    case checkBox(_: MorphDataControl)
    
    /// 27 OptionButton
    case optionButton(_: MorphDataControl)
    
    /// 28 ToggleButton
    case toggleButton(_: MorphDataControl)
    
    /// 47 ScrollBar
    case scrollBar(_: ScrollBarControl)
    
    /// 57 MultiPage
    case multiPage(_: MultiPageControl)
    
    public init(dataStream: inout DataStream, storage: CompoundFileStorage, site: OleSiteConcreteControl) throws {
        switch site.dataBlock.clsidCacheIndex {
        case 7:
            self = .form(try UserForm(parentStorage: storage, site: site))
        case 12:
            self = .image(try ImageControl(dataStream: &dataStream))
        case 14:
            self = .frame(try FrameControl(parentStorage: storage, site: site))
        case 15:
            self = .morphData(try MorphDataControl(dataStream: &dataStream))
        case 16:
            self = .spinButton(try SpinButtonControl(dataStream: &dataStream))
        case 17:
            self = .commandButton(try CommandButtonControl(dataStream: &dataStream))
        case 18:
            self = .tabStrip(try TabStripControl(dataStream: &dataStream))
        case 21:
            self = .label(try LabelControl(dataStream: &dataStream))
        case 23:
            self = .textBox(try MorphDataControl(dataStream: &dataStream))
        case 24:
            self = .listBox(try MorphDataControl(dataStream: &dataStream))
        case 25:
            self = .comboBox(try MorphDataControl(dataStream: &dataStream))
        case 26:
            self = .checkBox(try MorphDataControl(dataStream: &dataStream))
        case 27:
            self = .optionButton(try MorphDataControl(dataStream: &dataStream))
        case 28:
            self = .toggleButton(try MorphDataControl(dataStream: &dataStream))
        case 47:
            self = .scrollBar(try ScrollBarControl(dataStream: &dataStream))
        case 57:
            self = .multiPage(try MultiPageControl(parentStorage: storage, site: site))
        default:
            throw OfficeFormFileError.corrupted
        }
    }
}
