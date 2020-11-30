//
//  ImagePropMask.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.3.2 ImagePropMask
/// Specifies the properties of the control that are not set to the file format default. For each bit, a value of zero specifies that the corresponding property
/// is the file format default and is not stored in the file.
public struct ImagePropMask {
    public let unusedBits1: UInt8
    public let fAutoSize: Bool
    public let fBorderColor: Bool
    public let fBackColor: Bool
    public let fBorderStyle: Bool
    public let fMousePointer: Bool
    public let fPictureSizeMode: Bool
    public let fSpecialEffect: Bool
    public let fSize: Bool
    public let fPicture: Bool
    public let fPictureAlignment: Bool
    public let fPictureTiling: Bool
    public let fVariousPropertyBits: Bool
    public let fMouseIcon: Bool
    public let unusedBits2: UInt32
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - UnusedBits1 (2 bits): MUST be set to zero.
        self.unusedBits1 = UInt8(flags.readBits(count: 2))

        /// B - fAutoSize (1 bit): Specifies whether the value of the AutoSize property is not the file format default.
        self.fAutoSize = flags.readBit()

        /// C - fBorderColor (1 bit): Specifies whether the BorderColor property is stored in the DataBlock.BorderColor of the ImageControl that contains this ImagePropMask.
        self.fBorderColor = flags.readBit()

        /// D - fBackColor (1 bit): Specifies whether the BackColor property is stored in the DataBlock.BackColor of the ImageControl that contains this ImagePropMask.
        self.fBackColor = flags.readBit()

        /// E - fBorderStyle (1 bit): Specifies whether the BorderStyle property is stored in the DataBlock.BorderStyle of the ImageControl that contains this ImagePropMask.
        self.fBorderStyle = flags.readBit()

        /// F - fMousePointer (1 bit): Specifies whether the MousePointer property is stored in the DataBlock.MousePointer of the ImageControl that contains this ImagePropMask.
        self.fMousePointer = flags.readBit()

        /// G - fPictureSizeMode (1 bit): Specifies whether the PictureSizeMode property is stored in the DataBlock.PictureSizeMode of the ImageControl that contains this ImagePropMask.
        self.fPictureSizeMode = flags.readBit()

        /// H - fSpecialEffect (1 bit): Specifies whether the SpecialEffect property is stored in the DataBlock.PictureSizeMode of the ImageControl that contains this ImagePropMask.
        self.fSpecialEffect = flags.readBit()

        /// I - fSize (1 bit): Specifies whether the Size property is stored in the ExtraDataBlock.Size of the ImageControl that contains this ImagePropMask. MUST be set to 1.
        self.fSize = flags.readBit()

        /// J - fPicture (1 bit): Specifies whether the Picture property is stored in the StreamData.Picture of the ImageControl that contains this ImagePropMask. When this bit is set to 1, a value of 0xFFFF MUST be stored in the DataBlock.Picture of the ImageControl.
        self.fPicture = flags.readBit()

        /// K - fPictureAlignment (1 bit): Specifies whether the PictureAlignment property is stored in the DataBlock.PictureAlignment of the ImageControl that contains this ImagePropMask.
        self.fPictureAlignment = flags.readBit()

        /// L - fPictureTiling (1 bit): Specifies whether the value of the PictureTiling property is the file format default.
        self.fPictureTiling = flags.readBit()

        /// M - fVariousPropertyBits (1 bit): Specifies whether the VariousPropertyBits property is stored in the DataBlock.VariousPropertyBits of the ImageControl that contains this ImagePropMask.
        self.fVariousPropertyBits = flags.readBit()

        /// N - fMouseIcon (1 bit): Specifies whether the MouseIcon property is stored in the StreamData.MouseIcon of the ImageControl that contains this ImagePropMask. When this bit is set to 1, a value of 0xFFFF MUST be stored in the DataBlock.MouseIcon of the ImageControl.
        self.fMouseIcon = flags.readBit()


        
        /// UnusedBits2 (17 bits): MUST be set to zero.
        self.unusedBits2 = flags.readRemainingBits()
    }
}
