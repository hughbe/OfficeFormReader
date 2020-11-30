//
//  LabelDataBlock.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.4.3 LabelDataBlock
/// Specifies the properties of the control that are 4 bytes or smaller and are not set to the file format defaults. If the corresponding bit in
/// the PropMask of the LabelControl that contains this LabelDataBlock is set to zero, the property value MUST NOT be stored in the file.
public struct LabelDataBlock {
    public let foreColor: OLE_COLOR?
    public let backColor: OLE_COLOR?
    public let variousPropertyBits: VariousPropertiesBitfield?
    public let caption: CountOfBytesWithCompressionFlag?
    public let picturePosition: fmPicturePosition?
    public let mousePointer: UInt8?
    public let borderColor: OLE_COLOR?
    public let borderStyle: fmBorderStyle?
    public let specialEffect: fmSpecialEffect?
    public let picture: UInt16?
    public let accelerator: Accelerator?
    public let mouseIcon: UInt16?
    
    public init(dataStream: inout DataStream, mask: LabelPropMask) throws {
        let startPosition = dataStream.position
        
        /// ForeColor (4 bytes): An OLE_COLOR that specifies the value of the ForeColor property.
        if mask.fForeColor {
            self.foreColor = try OLE_COLOR(dataStream: &dataStream)
        } else {
            self.foreColor = nil
        }
        
        /// BackColor (4 bytes): An OLE_COLOR that specifies the value of the BackColor property.
        if mask.fBackColor {
            self.backColor = try OLE_COLOR(dataStream: &dataStream)
        } else {
            self.backColor = nil
        }
        
        /// VariousPropertyBits (4 bytes): A VariousPropertiesBitfield that specifies the value of the VariousPropertyBits properties.
        if mask.fVariousPropertyBits {
            self.variousPropertyBits = try VariousPropertiesBitfield(dataStream: &dataStream)
        } else {
            self.variousPropertyBits = nil
        }
        
        /// Caption (4 bytes): A CountOfBytesWithCompressionFlag that specifies the size and compression of the Caption property.
        if mask.fCaption {
            self.caption = try CountOfBytesWithCompressionFlag(dataStream: &dataStream)
        } else {
            self.caption = nil
        }
        
        /// PicturePosition (4 bytes): An fmPicturePosition that specifies the value of the PicturePosition property.
        if mask.fPicturePosition {
            self.picturePosition = try fmPicturePosition(dataStream: &dataStream)
        } else {
            self.picturePosition = nil
        }
        
        /// MousePointer (1 byte): An unsigned integer that specifies the value of the MousePointer property.
        if mask.fMousePointer {
            self.mousePointer = try dataStream.read()
        } else {
            self.mousePointer = nil
        }
        
        /// Padding1 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fBorderColor {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// BorderColor (4 bytes): An OLE_COLOR that specifies the value of the BorderColor property.
        if mask.fBorderColor {
            self.borderColor = try OLE_COLOR(dataStream: &dataStream)
        } else {
            self.borderColor = nil
        }
        
        /// Padding2 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fBorderStyle {
            try dataStream.twoByteAlign(startPosition: startPosition)
        }
        
        /// BorderStyle (2 bytes): An fmBorderStyle that specifies the value of the BorderStyle property.
        if mask.fBorderStyle {
            self.borderStyle = try fmBorderStyle(dataStream: &dataStream)
        } else {
            self.borderStyle = nil
        }
        
        /// Padding3 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fSpecialEffect {
            try dataStream.twoByteAlign(startPosition: startPosition)
        }
        
        /// SpecialEffect (2 bytes): An fmSpecialEffect that specifies the value of the SpecialEffect property.
        if mask.fSpecialEffect {
            self.specialEffect = try fmSpecialEffect(dataStream: &dataStream)
        } else {
            self.specialEffect = nil
        }
    
        /// Padding4 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fPicture {
            try dataStream.twoByteAlign(startPosition: startPosition)
        }
        
        /// Picture (2 bytes): MUST be set to 0xFFFF when the PropMask.fPicture of the LabelControl that contains this LabelDataBlock is
        /// set to 1. Not present when PropMask.fPicture is set to zero.
        if mask.fPicture {
            self.picture = try dataStream.read(endianess: .littleEndian)
            guard picture == 0xFFFF else {
                throw OfficeFormFileError.corrupted
            }
        } else {
            self.picture = nil
        }
        
        /// Padding5 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fAccelerator {
            try dataStream.twoByteAlign(startPosition: startPosition)
        }
        
        /// Accelerator (2 bytes): A Unicode character that specifies the value of the Accelerator property.
        if mask.fAccelerator {
            self.accelerator = try Accelerator(dataStream: &dataStream)
        } else {
            self.accelerator = nil
        }

        /// Padding6 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fMouseIcon {
            try dataStream.twoByteAlign(startPosition: startPosition)
        }
        
        /// MouseIcon (2 bytes): MUST be set to 0xFFFF when the PropMask.fMouseIcon of the LabelControl that contains this LabelDataBlock
        /// is set to 1. Not present when PropMask.fMouseIcon is set to zero.
        if mask.fMouseIcon {
            self.mouseIcon = try dataStream.read(endianess: .littleEndian)
            guard mouseIcon == 0xFFFF else {
                throw OfficeFormFileError.corrupted
            }
        } else {
            self.mouseIcon = nil
        }
        
        /// Padding7 (variable): MUST be set to zero. The size of this field is the least number of bytes required to make the total size, in
        /// bytes, of this LabelDataBlock divisible by 4.
        try dataStream.fourByteAlign(startPosition: startPosition)
    }
}
