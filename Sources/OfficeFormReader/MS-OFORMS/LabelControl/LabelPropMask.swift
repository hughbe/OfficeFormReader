//
//  LabelPropMask.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.4.2 LabelPropMask
/// Specifies the properties of the control that are not set to the file format default. For each bit, a value of zero specifies that the corresponding
/// property is the file format default and is not stored in the file.
public struct LabelPropMask {
    public let fForeColor: Bool
    public let fBackColor: Bool
    public let fVariousPropertyBits: Bool
    public let fCaption: Bool
    public let fPicturePosition: Bool
    public let fSize: Bool
    public let fMousePointer: Bool
    public let fBorderColor: Bool
    public let fBorderStyle: Bool
    public let fSpecialEffect: Bool
    public let fPicture: Bool
    public let fAccelerator: Bool
    public let fMouseIcon: Bool
    public let unusedBits: UInt32
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fForeColor (1 bit): Specifies whether the ForeColor property is stored in the DataBlock.ForeColor of the LabelControl that
        /// contains this LabelPropMask.
        self.fForeColor = flags.readBit()
        
        /// B - fBackColor (1 bit): Specifies whether the BackColor property is stored in the DataBlock.BackColor of the LabelControl that
        /// contains this LabelPropMask.
        self.fBackColor = flags.readBit()
        
        /// C - fVariousPropertyBits (1 bit): Specifies whether the VariousPropertyBits property is stored in the DataBlock.VariousPropertyBits
        /// of the LabelControl that contains this LabelPropMask.
        self.fVariousPropertyBits = flags.readBit()
        
        /// D - fCaption (1 bit): Specifies whether the size and compression flag of the Caption property are stored in the DataBlock.Caption
        /// of the LabelControl that contains this LabelPropMask and the Caption string is stored in the ExtraDataBlock.Caption of the
        /// LabelControl.
        self.fCaption = flags.readBit()
        
        /// E - fPicturePosition (1 bit): Specifies whether the PicturePosition property is stored in the DataBlock.PicturePosition of the
        /// LabelControl that contains this LabelPropMask.
        self.fPicturePosition = flags.readBit()
        
        /// F - fSize (1 bit): Specifies whether the Size property is stored in the ExtraDataBlock.Size of the LabelControl that contains this
        /// LabelPropMask. MUST be set to 1.
        self.fSize = flags.readBit()
        
        /// G - fMousePointer (1 bit): Specifies whether the MousePointer property is stored in the DataBlock.MousePointer of the
        /// LabelControl that contains this LabelPropMask.
        self.fMousePointer = flags.readBit()
        
        /// H - fBorderColor (1 bit): Specifies whether the BorderColor property is stored in the DataBlock.BorderColor of the LabelControl
        /// that contains this LabelPropMask.
        self.fBorderColor = flags.readBit()
        
        /// I - fBorderStyle (1 bit): Specifies whether the BorderStyle property is stored in the DataBlock.BorderStyle of the LabelControl
        /// that contains this LabelPropMask.
        self.fBorderStyle = flags.readBit()
        
        /// J - fSpecialEffect (1 bit): Specifies whether the SpecialEffect property is stored in the DataBlock.SpecialEffect of the LabelControl
        /// that contains this LabelPropMask.
        self.fSpecialEffect = flags.readBit()
        
        /// K - fPicture (1 bit): Specifies whether the Picture property is stored in the StreamData.Picture of the LabelControl that contains
        /// this LabelPropMask. When this bit is set to 1, a value of 0xFFFF MUST be stored in the DataBlock.Picture of the LabelControl.
        self.fPicture = flags.readBit()
        
        /// L - fAccelerator (1 bit): Specifies whether the Accelerator property is stored in the DataBlock.Accelerator of the LabelControl that
        /// contains this LabelPropMask.
        self.fAccelerator = flags.readBit()
        
        /// M - fMouseIcon (1 bit): Specifies whether the MouseIcon property is stored in the StreamData.MouseIcon of the LabelControl
        /// that contains this LabelPropMask. When this bit is set to 1, a value of 0xFFFF MUST be stored in the DataBlock.MouseIcon of
        /// the LabelControl.
        self.fMouseIcon = flags.readBit()
        
        /// UnusedBits (19 bits): MUST be set to zero.
        self.unusedBits = flags.readRemainingBits()
    }
}
