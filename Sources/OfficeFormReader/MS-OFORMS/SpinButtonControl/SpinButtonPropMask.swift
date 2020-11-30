//
//  SpinButtonPropMask.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.8.2 SpinButtonPropMask
/// Specifies the properties of the control are not set to the file format default. For each bit, a value of zero specifies that the corresponding property is
/// the file format default and is not stored in the file.
public struct SpinButtonPropMask {
    public let fForeColor: Bool
    public let fBackColor: Bool
    public let fVariousPropertyBits: Bool
    public let fSize: Bool
    public let unusedBits1: Bool
    public let fMin: Bool
    public let fMax: Bool
    public let fPosition: Bool
    public let fPrevEnabled: Bool
    public let fNextEnabled: Bool
    public let fSmallChange: Bool
    public let fOrientation: Bool
    public let fDelay: Bool
    public let fMouseIcon: Bool
    public let fMousePointer: Bool
    public let unusedBits2: UInt32
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fForeColor (1 bit): Specifies whether the ForeColor property is stored in the DataBlock.ForeColor of the SpinButtonControl that contains this SpinButtonPropMask.
        self.fForeColor = flags.readBit()

        /// B - fBackColor (1 bit): Specifies whether the BackColor property is stored in the DataBlock.BackColor of the SpinButtonControl that contains this SpinButtonPropMask.
        self.fBackColor = flags.readBit()

        /// C - fVariousPropertyBits (1 bit): Specifies whether the VariousPropertyBits property is stored in the DataBlock.VariousPropertyBits of the SpinButtonControl that contains this SpinButtonPropMask.
        self.fVariousPropertyBits = flags.readBit()

        /// D - fSize (1 bit): Specifies whether the Size property is stored in the ExtraDataBlock.Size of the SpinButtonControl that contains this SpinButtonPropMask. MUST be set to 1.
        self.fSize = flags.readBit()

        /// E - UnusedBits1 (1 bit): MUST be set to zero.
        self.unusedBits1 = flags.readBit()

        /// F - fMin (1 bit): Specifies whether the Min property is stored in the DataBlock.Min of the SpinButtonControl that contains this SpinButtonPropMask.
        self.fMin = flags.readBit()

        /// G - fMax (1 bit): Specifies whether the Max property is stored in the DataBlock.Max of the SpinButtonControl that contains this SpinButtonPropMask.
        self.fMax = flags.readBit()

        /// H - fPosition (1 bit): Specifies whether the Position property is stored in the DataBlock.Position of the SpinButtonControl that contains this SpinButtonPropMask.
        self.fPosition = flags.readBit()

        /// I - fPrevEnabled (1 bit): When fVariousPropertyBits is set to 1, this MUST be equal to the inverse value of DataBlock.VariousPropertyBits.Enabled of the SpinButtonControl that contains this SpinButtonPropMask. When fVariousPropertyBits is set to zero, this MUST be set to zero.
        self.fPrevEnabled = flags.readBit()

        /// J - fNextEnabled (1 bit): MUST be equal to fPrevEnabled.
        self.fNextEnabled = flags.readBit()

        /// K - fSmallChange (1 bit): Specifies whether the SmallChange property is stored in the DataBlock.SmallChange of the SpinButtonControl that contains this SpinButtonPropMask.
        self.fSmallChange = flags.readBit()

        /// L - fOrientation (1 bit): Specifies whether the Orientation property is stored in the DataBlock.Orientation of the SpinButtonControl that contains this SpinButtonPropMask.
        self.fOrientation = flags.readBit()

        /// M - fDelay (1 bit): Specifies whether the Delay property is stored in the DataBlock.Delay of the SpinButtonControl that contains this SpinButtonPropMask.
        self.fDelay = flags.readBit()

        /// N - fMouseIcon (1 bit): Specifies whether the MouseIcon property is stored in the StreamData.MouseIcon of the SpinButtonControl that contains this SpinButtonPropMask. When this bit is set to 1, a value of 0xFFFF MUST be stored in the DataBlock.MouseIcon of the SpinButtonControl.
        self.fMouseIcon = flags.readBit()

        /// O - fMousePointer (1 bit): Specifies whether the MousePointer property is stored in the DataBlock.MousePointer of the SpinButtonControl that contains this SpinButtonPropMask.
        self.fMousePointer = flags.readBit()

        /// UnusedBits2 (17 bits): MUST be set to zero.
        self.unusedBits2 = flags.readRemainingBits()
    }
}
