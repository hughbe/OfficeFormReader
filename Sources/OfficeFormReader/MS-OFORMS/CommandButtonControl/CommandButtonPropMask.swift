//
//  CommandButtonPropMask.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.1.2 CommandButtonPropMask
/// Specifies the properties of the control that are not set to the file format default. For each bit, a value of zero specifies that the corresponding
/// property is the file format default and is not stored in the file.
public struct CommandButtonPropMask {
    public let fForeColor: Bool
    public let fBackColor: Bool
    public let fVariousPropertyBits: Bool
    public let fCaption: Bool
    public let fPicturePosition: Bool
    public let fSize: Bool
    public let fMousePointer: Bool
    public let fPicture: Bool
    public let fAccelerator: Bool
    public let fTakeFocusOnClick: Bool
    public let fMouseIcon: Bool
    public let unusedBits: UInt32
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fForeColor (1 bit): Specifies whether the ForeColor property is stored in the DataBlock.ForeColor of the CommandButtonControl
        /// that contains this CommandButtonPropMask.
        self.fForeColor = flags.readBit()
        
        /// B - fBackColor (1 bit): Specifies whether the BackColor property is stored in the DataBlock.BackColor of the CommandButtonControl
        /// that contains this CommandButtonPropMask.
        self.fBackColor = flags.readBit()
        
        /// C - fVariousPropertyBits (1 bit): Specifies whether the VariousPropertyBits property is stored in the DataBlock.VariousPropertyBits
        /// of the CommandButtonControl that contains this CommandButtonPropMask.
        self.fVariousPropertyBits = flags.readBit()
        
        /// D - fCaption (1 bit): Specifies whether the size and compression flag of the Caption property are stored in the DataBlock.Caption
        /// of the CommandButtonControl that contains this CommandButtonPropMask and the Caption string is stored in the
        /// ExtraDataBlock.Caption of the CommandButtonControl.
        self.fCaption = flags.readBit()
        
        /// E - fPicturePosition (1 bit): Specifies whether the PicturePosition property is stored in the DataBlock.PicturePosition of the
        /// CommandButtonControl that contains this CommandButtonPropMask.
        self.fPicturePosition = flags.readBit()
        
        /// F - fSize (1 bit): Specifies whether the Size property is stored in the ExtraDataBlock.Size of the CommandButtonControl that
        /// contains this CommandButtonPropMask. MUST be set to 1.
        self.fSize = flags.readBit()
        
        /// G - fMousePointer (1 bit): Specifies whether the MousePointer property is stored in the DataBlock.MousePointer of the
        /// CommandButtonControl that contains this CommandButtonPropMask.
        self.fMousePointer = flags.readBit()
        
        /// H - fPicture (1 bit): Specifies whether the Picture property is stored in the StreamData.Picture of the CommandButtonControl that
        /// contains this CommandButtonPropMask. When this bit is set to 1, a value of 0xFFFF MUST be stored in the DataBlock.Picture of
        /// the CommandButtonControl.
        self.fPicture = flags.readBit()
        
        /// I - fAccelerator (1 bit): Specifies whether the Accelerator property is stored in the DataBlock.Accelerator of the
        /// CommandButtonControl that contains this CommandButtonPropMask.
        self.fAccelerator = flags.readBit()
        
        /// J - fTakeFocusOnClick (1 bit): Specifies whether the value of the TakeFocusOnClick property is not the file format default.
        self.fTakeFocusOnClick = flags.readBit()
        
        /// K - fMouseIcon (1 bit): Specifies whether the MouseIcon property is stored in the StreamData.MouseIcon of the
        /// CommandButtonControl that contains this CommandButtonPropMask. When this bit is set to 1, a value of 0xFFFF MUST be
        /// stored in the DataBlock.MouseIcon of the CommandButtonControl.
        self.fMouseIcon = flags.readBit()
        
        /// UnusedBits (21 bits): MUST be set to zero.
        self.unusedBits = flags.readRemainingBits()
    }
}
