//
//  TabStripPropMask.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.9.2 TabStripPropMask
/// Specifies the properties of the control that are not set to the file format default. For each bit, a value of zero specifies that the corresponding property
/// is the file format default and is not stored in the file.
public struct TabStripPropMask {
    public let fListIndex: Bool
    public let fBackColor: Bool
    public let fForeColor: Bool
    public let unused1: Bool
    public let fSize: Bool
    public let fItems: Bool
    public let fMousePointer: Bool
    public let unused2: Bool
    public let fTabOrientation: Bool
    public let fTabStyle: Bool
    public let fMultiRow: Bool
    public let fTabFixedWidth: Bool
    public let fTabFixedHeight: Bool
    public let fTooltips: Bool
    public let unused3: Bool
    public let fTipStrings: Bool
    public let unused4: Bool
    public let fNames: Bool
    public let fVariousPropertyBits: Bool
    public let fNewVersion: Bool
    public let fTabsAllocated: Bool
    public let fTags: Bool
    public let fTabData: Bool
    public let fAccelerator: Bool
    public let fMouseIcon: Bool
    public let unusedBits: UInt8
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fListIndex (1 bit): Specifies whether the ListIndex property is stored in the DataBlock.ListIndex of the TabStripControl that contains
        /// this TabStripPropMask.
        self.fListIndex = flags.readBit()

        /// B - fBackColor (1 bit): Specifies whether the BackColor property is stored in the DataBlock.BackColor of the TabStripControl that contains
        /// this TabStripPropMask.
        self.fBackColor = flags.readBit()

        /// C - fForeColor (1 bit): Specifies whether the ForeColor property is stored in the DataBlock.ForeColor of the TabStripControl that contains
        /// this TabStripPropMask.
        self.fForeColor = flags.readBit()

        /// D - Unused1 (1 bit): MUST be set to zero.
        self.unused1 = flags.readBit()

        /// E - fSize (1 bit): Specifies whether the Size property is stored in the ExtraDataBlock.Size of the TabStripControl that contains this
        /// TabStripPropMask. MUST be set to 1.
        self.fSize = flags.readBit()

        /// F - fItems (1 bit): Specifies whether ExtraDataBlock.Items and DataBlock.ItemsSize are stored in the TabStripControl that contains this
        /// TabStripPropMask.
        self.fItems = flags.readBit()

        /// G - fMousePointer (1 bit): Specifies whether the MousePointer property is stored in the DataBlock.MousePointer of the TabStripControl
        /// that contains this TabStripPropMask.
        self.fMousePointer = flags.readBit()

        /// H - Unused2 (1 bit): MUST be set to zero.
        self.unused2 = flags.readBit()

        /// I - fTabOrientation (1 bit): Specifies whether the TabOrientation property is stored in the DataBlock.TabOrientation of the TabStripControl
        /// that contains this TabStripPropMask.
        self.fTabOrientation = flags.readBit()

        /// J - fTabStyle (1 bit): Specifies whether the TabStyle property is stored in the DataBlock.TabStyle of the TabStripControl that contains this
        /// TabStripPropMask.
        self.fTabStyle = flags.readBit()

        /// K - fMultiRow (1 bit): Specifies whether the value of the MultiRow property is not the file format default.
        self.fMultiRow = flags.readBit()

        /// L - fTabFixedWidth (1 bit): Specifies whether the TabFixedWidth property is stored in the DataBlock.TabFixedWidth of the TabStripControl
        /// that contains this TabStripPropMask.
        self.fTabFixedWidth = flags.readBit()

        /// M - fTabFixedHeight (1 bit): Specifies whether the TabFixedHeight property is stored in the DataBlock.TabFixedHeight of the TabStripControl
        /// that contains this TabStripPropMask.
        self.fTabFixedHeight = flags.readBit()

        /// N - fTooltips (1 bit): Specifies whether the value of the Tooltips property is not the file format default.
        self.fTooltips = flags.readBit()

        /// O - Unused3 (1 bit): MUST be set to zero.
        self.unused3 = flags.readBit()

        /// P - fTipStrings (1 bit): Specifies whether ExtraDataBlock.TipStrings and DataBlock.TipStringsSize are stored in the TabStripControl that
        /// contains this TabStripPropMask.
        self.fTipStrings = flags.readBit()

        /// Q - Unused4 (1 bit): MUST be set to zero.
        self.unused4 = flags.readBit()

        /// R - fNames (1 bit): Specifies whether ExtraDataBlock.TabNames and DataBlock.NamesSize are stored in the TabStripControl that contains
        /// this TabStripPropMask.
        self.fNames = flags.readBit()

        /// S - fVariousPropertyBits (1 bit): Specifies whether the VariousPropertyBits property is stored in the DataBlock.VariousPropertyBits of the
        /// TabStripControl that contains this TabStripPropMask.
        self.fVariousPropertyBits = flags.readBit()

        /// T - fNewVersion (1 bit): Specifies whether the value of the NewVersion property is not the file format default. MUST be set to 1.
        self.fNewVersion = flags.readBit()

        /// U - fTabsAllocated (1 bit): Specifies whether the TabsAllocated property is stored in the DataBlock.TabsAllocated of the TabStripControl
        /// that contains this TabStripPropMask.
        self.fTabsAllocated = flags.readBit()

        /// V - fTags (1 bit): Specifies whether ExtraDataBlock.Tags and DataBlock.TagsSize are stored in the TabStripControl that contains this
        /// TabStripPropMask.
        self.fTags = flags.readBit()

        /// W - fTabData (1 bit): Specifies whether the TabData property is stored in the DataBlock.TabData of the TabStripControl that contains this
        /// TabStripPropMask.
        self.fTabData = flags.readBit()

        /// X - fAccelerator (1 bit): Specifies whether ExtraDataBlock.Accelerators and DataBlock.AcceleratorsSize are stored in the TabStripControl
        /// that contains this TabStripPropMask.
        self.fAccelerator = flags.readBit()

        /// Y - fMouseIcon (1 bit): Specifies whether the MouseIcon property is stored in the StreamData.MouseIcon of the TabStripControl that
        /// contains this TabStripPropMask. When this bit is set to 1, a value of 0xFFFF MUST be stored in the DataBlock.MouseIcon of the
        /// TabStripControl.
        self.fMouseIcon = flags.readBit()


        
        /// UnusedBits (7 bits): MUST be set to zero.
        self.unusedBits = UInt8(flags.readBits(count: 7))
    }
}
