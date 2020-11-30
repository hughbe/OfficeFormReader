//
//  ScrollBarPropMask.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.7.2 ScrollBarPropMask
/// Specifies the properties of the control are not set to the file format default. For each bit, a value of zero specifies that the corresponding property is
/// the file format default and is not stored in the file
public struct ScrollBarPropMask {
    public let fForeColor: Bool
    public let fBackColor: Bool
    public let fVariousPropertyBits: Bool
    public let fSize: Bool
    public let fMousePointer: Bool
    public let fMin: Bool
    public let fMax: Bool
    public let fPosition: Bool
    public let UnusedBits1: Bool
    public let fPrevEnabled: Bool
    public let fNextEnabled: Bool
    public let fSmallChange: Bool
    public let fLargeChange: Bool
    public let fOrientation: Bool
    public let fProportionalThumb: Bool
    public let fDelay: Bool
    public let fMouseIcon: Bool
    public let unusedBits2: UInt16
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)

        /// A - fForeColor (1 bit): Specifies whether the ForeColor property is stored in the DataBlock.ForeColor of the ScrollBarControl that contains
        /// this ScrollBarPropMask.
        self.fForeColor = flags.readBit()

        /// B - fBackColor (1 bit): Specifies whether the BackColor property is stored in the DataBlock.BackColor of the ScrollBarControl that contains
        /// this ScrollBarPropMask.
        self.fBackColor = flags.readBit()

        /// C - fVariousPropertyBits (1 bit): Specifies whether the VariousPropertyBits property is stored in the DataBlock.VariousPropertyBits of the
        /// ScrollBarControl that contains this ScrollBarPropMask.
        self.fVariousPropertyBits = flags.readBit()

        /// D - fSize (1 bit): Specifies whether the Size property is stored in the ExtraDataBlock.Size of the ScrollBarControl that contains this
        /// ScrollBarPropMask. MUST be set to 1.
        self.fSize = flags.readBit()

        /// E - fMousePointer (1 bit): Specifies whether the MousePointer property is stored in the DataBlock.MousePointer of the ScrollBarControl
        /// that contains this ScrollBarPropMask.
        self.fMousePointer = flags.readBit()

        /// F - fMin (1 bit): Specifies whether the Min property is stored in the DataBlock.Min of the ScrollBarControl that contains this
        /// ScrollBarPropMask.
        self.fMin = flags.readBit()

        /// G - fMax (1 bit): Specifies whether the Max property is stored in the DataBlock.Max of the ScrollBarControl that contains this
        /// ScrollBarPropMask.
        self.fMax = flags.readBit()

        /// H - fPosition (1 bit): Specifies whether the Position property is stored in the DataBlock.Position of the ScrollBarControl that contains this
        /// ScrollBarPropMask.
        self.fPosition = flags.readBit()

        /// I - UnusedBits1 (1 bit): MUST be set to zero.
        self.UnusedBits1 = flags.readBit()

        /// J - fPrevEnabled (1 bit): When fVariousPropertyBits is set to 1, this MUST be equal to the inverse value of
        /// DataBlock.VariousPropertyBits.Enabled of the ScrollBarControl that contains this ScrollBarPropMask. When fVariousPropertyBits is set to
        /// zero, this MUST be set to zero.
        self.fPrevEnabled = flags.readBit()

        /// K - fNextEnabled (1 bit): MUST be equal to fPrevEnabled.
        self.fNextEnabled = flags.readBit()

        /// L - fSmallChange (1 bit): Specifies whether the SmallChange property is stored in the DataBlock.SmallChange of the ScrollBarControl that
        /// contains this ScrollBarPropMask.
        self.fSmallChange = flags.readBit()

        /// M - fLargeChange (1 bit): Specifies whether the LargeChange property is stored in the DataBlock.LargeChange of the ScrollBarControl that
        /// contains this ScrollBarPropMask.
        self.fLargeChange = flags.readBit()

        /// N - fOrientation (1 bit): Specifies whether the Orientation property is stored in the DataBlock.Orientation of the ScrollBarControl that
        /// contains this ScrollBarPropMask.
        self.fOrientation = flags.readBit()

        /// O - fProportionalThumb (1 bit): Specifies whether the ProportionalThumb property is stored in the DataBlock.ProportionalThumb of the
        /// ScrollBarControl that contains this ScrollBarPropMask.
        self.fProportionalThumb = flags.readBit()

        /// P - fDelay (1 bit): Specifies whether the Delay property is stored in the DataBlock.Delay of the ScrollBarControl that contains this
        /// ScrollBarPropMask.
        self.fDelay = flags.readBit()

        /// Q - fMouseIcon (1 bit): Specifies whether the MouseIcon property is stored in the StreamData.MouseIcon of the ScrollBarControl that
        /// contains this ScrollBarPropMask. When this bit is set to 1, a value of 0xFFFF MUST be stored in the DataBlock.MouseIcon of the ScrollBarControl.
        self.fMouseIcon = flags.readBit()
        
        /// UnusedBits2 (15 bits): MUST be set to 0.
        self.unusedBits2 = UInt16(flags.readRemainingBits())
    }
}
