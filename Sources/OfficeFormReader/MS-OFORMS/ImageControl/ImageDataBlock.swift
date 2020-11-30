//
//  ImageDataBlock.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.3.3 ImageDataBlock
/// Specifies the properties of the control that are 4 bytes or smaller and are not set to the file format defaults. If the corresponding bit in the PropMask
/// of the ImageControl that contains this ImageDataBlock is set to zero, the property value MUST NOT be stored in the file.
public struct ImageDataBlock {
    public let borderColor: OLE_COLOR?
    public let backColor: OLE_COLOR?
    public let borderStyle: fmBorderStyle?
    public let mousePointer: UInt8?
    public let pictureSizeMode: fmPictureSizeMode?
    public let specialEffect: fmSpecialEffect?
    public let picture: UInt16?
    public let pictureAlignment: fmPictureAlignment?
    public let variousPropertyBits: VariousPropertiesBitfield?
    public let mouseIcon: UInt16?
    
    public init(dataStream: inout DataStream, mask: ImagePropMask) throws {
        let startPosition = dataStream.position
        
        /// BorderColor (4 bytes): An OLE_COLOR that specifies the value of the BorderColor property.
        if mask.fBorderColor {
            self.borderColor = try OLE_COLOR(dataStream: &dataStream)
        } else {
            self.borderColor = nil
        }
        
        /// BackColor (4 bytes): An OLE_COLOR that specifies the value of the BackColor property.
        if mask.fBackColor {
            self.backColor = try OLE_COLOR(dataStream: &dataStream)
        } else {
            self.backColor = nil
        }
        
        /// BorderStyle (1 byte): An fmBorderStyle that specifies the value of the BorderStyle property.
        if mask.fBorderStyle {
            self.borderStyle = try fmBorderStyle(dataStream: &dataStream)
        } else {
            self.borderStyle = nil
        }
        
        /// MousePointer (1 byte): An unsigned integer that specifies the value of the MousePointer property.
        if mask.fMousePointer {
            self.mousePointer = try dataStream.read()
        } else {
            self.mousePointer = nil
        }
        
        /// PictureSizeMode (1 byte): An fmPictureSizeMode that specifies the value of the PictureSizeMode property.
        if mask.fPictureSizeMode {
            self.pictureSizeMode = try fmPictureSizeMode(dataStream: &dataStream)
        } else {
            self.pictureSizeMode = nil
        }
        
        /// SpecialEffect (1 byte): An fmSpecialEffect that specifies the value of the SpecialEffect property.
        if mask.fSpecialEffect {
            self.specialEffect = try fmSpecialEffect(dataStream: &dataStream)
        } else {
            self.specialEffect = nil
        }
        
        /// Padding1 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the following
        /// property, as specified by PaddingAndAlignment.
        if mask.fPicture {
            try dataStream.twoByteAlign(startPosition: startPosition)
        }
        
        /// Picture (2 bytes): MUST be set to 0xFFFF when PropMask.fPicture of the ImageControl that contains this ImageDataBlock is set to 1.
        /// Not present when PropMask.fPicture is set to zero.
        if mask.fPicture {
            self.picture = try dataStream.read(endianess: .littleEndian)
            guard self.picture == 0xFFFF else {
                throw OfficeFormFileError.corrupted
            }
        } else {
            self.picture = nil
        }
        
        /// PictureAlignment (1 byte): An fmPictureAlignment that specifies the value of the PictureAlignment property.
        if mask.fPictureAlignment {
            self.pictureAlignment = try fmPictureAlignment(dataStream: &dataStream)
        } else {
            self.pictureAlignment = nil
        }
        
        /// Padding2 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the following
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
        
        /// Padding3 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the following
        /// property, as specified by PaddingAndAlignment.
        if mask.fMouseIcon {
            try dataStream.twoByteAlign(startPosition: startPosition)
        }
        
        /// MouseIcon (2 bytes): MUST be set to 0xFFFF when the PropMask.fMouseIcon of the ImageControl that contains this ImageDataBlock is
        /// set to 1. Not present when PropMask.fMouseIcon is set to zero.
        if mask.fMouseIcon {
            self.mouseIcon = try dataStream.read(endianess: .littleEndian)
            guard self.mouseIcon == 0xFFFF else {
                throw OfficeFormFileError.corrupted
            }
        } else {
            self.mouseIcon = nil
        }
        
        /// Padding4 (variable): MUST be set to zero. The size of this field is the least number of bytes required to make the total size, in bytes, of this
        /// ImageDataBlock divisible by 4.
        try dataStream.fourByteAlign(startPosition: startPosition)
    }
}
