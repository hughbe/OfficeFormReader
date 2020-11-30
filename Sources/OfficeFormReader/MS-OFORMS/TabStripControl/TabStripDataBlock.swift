//
//  TabStripDataBlock.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.9.3 TabStripDataBlock
/// Specifies the properties of the control that are 4 bytes or smaller and are not set to the file format defaults. If the corresponding bit in the
/// PropMask of the TabStripControl that contains this TabStripDataBlock is set to zero, the property value MUST NOT be stored in the file.
public struct TabStripDataBlock {
    public let listIndex: Int32?
    public let backColor: OLE_COLOR?
    public let foreColor: OLE_COLOR?
    public let itemsSize: UInt32?
    public let mousePointer: UInt8?
    public let tabOrientation: fmTabOrientation?
    public let tabStyle: fmTabStyle?
    public let tabFixedWidth: TabFixedWidth?
    public let tabFixedHeight: TabFixedHeight?
    public let tipStringsSize: UInt32?
    public let namesSize: UInt32?
    public let variousPropertyBits: VariousPropertiesBitfield?
    public let tabsAllocated: UInt32?
    public let tagsSize: UInt32?
    public let tabData: UInt32?
    public let acceleratorsSize: UInt32?
    public let mouseIcon: UInt16?
    
    public init(dataStream: inout DataStream, mask: TabStripPropMask) throws {
        let startPosition = dataStream.position
        
        /// ListIndex (4 bytes): A signed integer that specifies the value of the ListIndex property.
        if mask.fListIndex {
            self.listIndex = try dataStream.read(endianess: .littleEndian)
        } else {
            self.listIndex = nil
        }
        
        /// BackColor (4 bytes): An OLE_COLOR that specifies the value of the BackColor property.
        if mask.fBackColor {
            self.backColor = try OLE_COLOR(dataStream: &dataStream)
        } else {
            self.backColor = nil
        }
        
        /// ForeColor (4 bytes): An OLE_COLOR that specifies the value of the ForeColor property.
        if mask.fForeColor {
            self.foreColor = try OLE_COLOR(dataStream: &dataStream)
        } else {
            self.foreColor = nil
        }
        
        /// ItemsSize (4 bytes): An unsigned integer that specifies the size, in bytes, of the ExtraDataBlock.Items of the TabStripControl that contains
        /// this TabStripDataBlock. MUST be greater than zero.
        if mask.fItems {
            let itemsSize: UInt32 = try dataStream.read(endianess: .littleEndian)
            guard itemsSize > 0 else {
                throw OfficeFormFileError.corrupted
            }
            
            self.itemsSize = itemsSize
        } else {
            self.itemsSize = nil
        }
        
        /// MousePointer (1 byte): An unsigned integer that specifies the value of the MousePointer property.
        if mask.fMousePointer {
            self.mousePointer = try dataStream.read()
        } else {
            self.mousePointer = nil
        }
        
        /// Padding1 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the following
        /// property, as specified by PaddingAndAlignment.
        if mask.fTabOrientation {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// TabOrientation (4 bytes): An fmTabOrientation that specifies the value of the TabOrientation property.
        if mask.fTabOrientation {
            self.tabOrientation = try fmTabOrientation(dataStream: &dataStream)
        } else {
            self.tabOrientation = nil
        }
        
        /// Padding2 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the following
        /// property, as specified by PaddingAndAlignment.
        if mask.fTabStyle {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// TabStyle (4 bytes): An fmTabStyle that specifies the value of the TabStyle property.
        if mask.fTabStyle {
            self.tabStyle = try fmTabStyle(dataStream: &dataStream)
        } else {
            self.tabStyle = nil
        }
    
        /// Padding3 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the following
        /// property, as specified by PaddingAndAlignment.
        if mask.fTabFixedWidth {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// TabFixedWidth (4 bytes): An unsigned integer that specifies the value of the TabFixedWidth property.
        if mask.fTabFixedWidth {
            self.tabFixedWidth = try TabFixedWidth(dataStream: &dataStream)
        } else {
            self.tabFixedWidth = nil
        }
        
        /// Padding4 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the following
        /// property, as specified by PaddingAndAlignment.
        if mask.fTabFixedHeight {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// TabFixedHeight (4 bytes): An unsigned integer that specifies the value of the TabFixedHeight property.
        if mask.fTabFixedHeight {
            self.tabFixedHeight = try TabFixedHeight(dataStream: &dataStream)
        } else {
            self.tabFixedHeight = nil
        }
        
        /// Padding5 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the following
        /// property, as specified by PaddingAndAlignment.
        if mask.fTipStrings {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// TipStringsSize (4 bytes): An unsigned integer that specifies the size, in bytes, of the ExtraDataBlock.TipStrings of the TabStripControl
        /// that contains this TabStripDataBlock. MUST be greater than zero.
        if mask.fTipStrings {
            let tipStringsSize: UInt32 = try dataStream.read(endianess: .littleEndian)
            guard tipStringsSize > 0 else {
                throw OfficeFormFileError.corrupted
            }
            
            self.tipStringsSize = tipStringsSize
        } else {
            self.tipStringsSize = nil
        }
        
        /// Padding6 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the following
        /// property, as specified by PaddingAndAlignment.
        if mask.fNames {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// NamesSize (4 bytes): An unsigned integer that specifies the size, in bytes, of the ExtraDataBlock.TabNames of the TabStripControl that
        /// contains this TabStripDataBlock. MUST be greater than zero.
        if mask.fNames {
            let namesSize: UInt32 = try dataStream.read(endianess: .littleEndian)
            guard namesSize > 0 else {
                throw OfficeFormFileError.corrupted
            }
            
            self.namesSize = namesSize
        } else {
            self.namesSize = nil
        }
        
        /// Padding7 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the following
        /// property, as specified by PaddingAndAlignment.
        if mask.fVariousPropertyBits {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// VariousPropertyBits (4 bytes): A VariousPropertiesBitfield that specifies the value of the VariousPropertyBits properties.
        if mask.fVariousPropertyBits {
            self.variousPropertyBits = try VariousPropertiesBitfield(dataStream: &dataStream)
        } else {
            self.variousPropertyBits = nil
        }
        
        /// Padding8 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the following
        /// property, as specified by PaddingAndAlignment.
        if mask.fTabsAllocated {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// TabsAllocated (4 bytes): An unsigned integer that specifies the value of the TabsAllocated property.
        if mask.fTabsAllocated {
            self.tabsAllocated = try dataStream.read(endianess: .littleEndian)
        } else {
            self.tabsAllocated = nil
        }
        
        /// Padding9 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the following
        /// property, as specified by PaddingAndAlignment.
        if mask.fTags {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// TagsSize (4 bytes): An unsigned integer that specifies the size, in bytes, of the ExtraDataBlock.Tags of the TabStripControl that contains
        /// this TabStripDataBlock. MUST be greater than zero.
        if mask.fTags {
            let tagsSize: UInt32 = try dataStream.read(endianess: .littleEndian)
            guard tagsSize > 0 else {
                throw OfficeFormFileError.corrupted
            }
            
            self.tagsSize = tagsSize
        } else {
            self.tagsSize = nil
        }
        
        /// Padding10 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the following
        /// property, as specified by PaddingAndAlignment.
        if mask.fTabData {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// TabData (4 bytes): An unsigned integer that specifies the value of the TabData property.
        if mask.fTabData {
            self.tabData = try dataStream.read(endianess: .littleEndian)
        } else {
            self.tabData = nil
        }

        /// Padding11 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the following
        /// property, as specified by PaddingAndAlignment.
        if mask.fAccelerator {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// AcceleratorsSize (4 bytes): An unsigned integer that specifies the size, in bytes, of the ExtraDataBlock.Accelerators of the TabStripControl
        /// that contains this TabStripDataBlock. MUST be greater than zero.
        if mask.fAccelerator {
            let acceleratorsSize: UInt32 = try dataStream.read(endianess: .littleEndian)
            guard acceleratorsSize > 0 else {
                throw OfficeFormFileError.corrupted
            }
            
            self.acceleratorsSize = acceleratorsSize
        } else {
            self.acceleratorsSize = nil
        }
        
        /// Padding12 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the following
        /// property, as specified by PaddingAndAlignment.
        if mask.fMouseIcon {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// MouseIcon (2 bytes): MUST be set to 0xFFFF when the PropMask.fMouseIcon of the TabStripControl that contains this TabStripDataBlock
        /// is set to 1. Not present when PropMask.fMouseIcon is set to zero.
        if mask.fMouseIcon {
            self.mouseIcon = try dataStream.read(endianess: .littleEndian)
            guard self.mouseIcon == 0xFFFF else {
                throw OfficeFormFileError.corrupted
            }
        } else {
            self.mouseIcon = nil
        }
        
        /// Padding13 (variable): MUST be set to zero. The size of this field is the least number of bytes required to make the total size, in bytes, of
        /// this TabStripDataBlock divisible by 4.
        try dataStream.fourByteAlign(startPosition: startPosition)
    }
}
