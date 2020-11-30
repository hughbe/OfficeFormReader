//
//  FormDataBlock.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.10.3 FormDataBlock
/// Specifies the properties of the Form that are 4 bytes or smaller and are not set to the file format defaults. If the corresponding bit in the
/// PropMask of the FormControl that contains this FormDataBlock is set to zero, the property value MUST NOT be stored in the file.
public struct FormDataBlock {
    public let backColor: OLE_COLOR?
    public let foreColor: OLE_COLOR?
    public let nextAvailableID: UInt32?
    public let booleanProperties: FormFlags?
    public let borderStyle: fmBorderStyle?
    public let mousePointer: UInt8?
    public let scrollBars: FormScrollBarFlags?
    public let groupCnt: UInt32?
    public let mouseIcon: UInt16?
    public let cycle: fmCycle?
    public let specialEffect: fmSpecialEffect?
    public let borderColor: OLE_COLOR?
    public let lengthAndCompression: CountOfBytesWithCompressionFlag?
    public let font: UInt16?
    public let picture: UInt16?
    public let zoom: Zoom?
    public let pictureAlignment: fmPictureAlignment?
    public let pictureSizeMode: fmPictureSizeMode?
    public let shapeCookie: UInt32?
    public let drawBuffer: UInt32?
    
    public init(dataStream: inout DataStream, mask: FormPropMask) throws {
        let startPosition = dataStream.position
        
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
        
        /// NextAvailableID (4 bytes): An unsigned integer that specifies the value of the NextAvailableID property.
        if mask.fNextAvailableID {
            self.nextAvailableID = try dataStream.read(endianess: .littleEndian)
        } else {
            self.nextAvailableID = nil
        }
        
        /// BooleanProperties (4 bytes): An unsigned integer that specifies the value of the BooleanProperties property.
        if mask.fBooleanProperties {
            self.booleanProperties = try FormFlags(dataStream: &dataStream)
        } else {
            self.booleanProperties = nil
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
        
        /// ScrollBars (1 byte): A FormScrollBarFlags that specifies the value of the ScrollBars property.
        if mask.fScrollBars {
            self.scrollBars = try FormScrollBarFlags(dataStream: &dataStream)
        } else {
            self.scrollBars = nil
        }
        
        /// Padding1 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the following
        /// property, as specified by PaddingAndAlignment.
        if mask.fGroupCnt {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// GroupCnt (4 bytes): A signed integer that specifies the value of the GroupCount property.
        if mask.fGroupCnt {
            self.groupCnt = try dataStream.read(endianess: .littleEndian)
        } else {
            self.groupCnt = nil
        }
        
        /// Padding2 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the following
        /// property, as specified by PaddingAndAlignment.
        if mask.fMouseIcon {
            try dataStream.twoByteAlign(startPosition: startPosition)
        }
        
        /// MouseIcon (2 bytes): MUST be set to 0xFFFF when the PropMask.fMouseIcon of the FormControl that contains this FormDataBlock
        /// is set to 1. Not present when PropMask.fMouseIcon is set to zero.
        if mask.fMouseIcon {
            self.mouseIcon = try dataStream.read(endianess: .littleEndian)
            guard self.mouseIcon == 0xFFFF else {
                throw OfficeFormFileError.corrupted
            }
        } else {
            self.mouseIcon = nil
        }
        
        /// Cycle (1 byte): An fmCycle that specifies the value of the Cycle property.
        if mask.fCycle {
            self.cycle = try fmCycle(dataStream: &dataStream)
        } else {
            self.cycle = nil
        }
        
        /// SpecialEffect (1 byte): An fmSpecialEffect that specifies the value of the SpecialEffect property.
        if mask.fSpecialEffect {
            self.specialEffect = try fmSpecialEffect(dataStream: &dataStream)
        } else {
            self.specialEffect = nil
        }
        
        /// Padding3 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the following
        /// property, as specified by PaddingAndAlignment.
        if mask.fBorderColor {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// BorderColor (4 bytes): An OLE_COLOR that specifies the value of the BorderColor property.
        if mask.fBorderColor {
            self.borderColor = try OLE_COLOR(dataStream: &dataStream)
        } else {
            self.borderColor = nil
        }
        
        /// Padding4 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the following
        /// property, as specified by PaddingAndAlignment.
        if mask.fCaption {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// LengthAndCompression (4 bytes): A CountOfBytesWithCompressionFlag that specifies the size and compression of the Caption
        /// property.
        if mask.fCaption {
            self.lengthAndCompression = try CountOfBytesWithCompressionFlag(dataStream: &dataStream)
        } else {
            self.lengthAndCompression = nil
        }
        
        /// Padding5 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the following
        /// property, as specified by PaddingAndAlignment.
        if mask.fFont {
            try dataStream.twoByteAlign(startPosition: startPosition)
        }
        
        /// Font (2 bytes): MUST be set to 0xFFFF when the PropMask.fFont of the FormControl that contains this FormDataBlock is set to 1.
        /// Not present when PropMask.fFont is set to zero.
        if mask.fFont {
            self.font = try dataStream.read(endianess: .littleEndian)
            guard self.font == 0xFFFF else {
                throw OfficeFormFileError.corrupted
            }
        } else {
            self.font = nil
        }
        
        /// Padding6 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the following
        /// property, as specified by PaddingAndAlignment.
        if mask.fPicture {
            try dataStream.twoByteAlign(startPosition: startPosition)
        }
        
        /// Picture (2 bytes): MUST be set to 0xFFFF when the PropMask.fPicture of the FormControl that contains this FormDataBlock is set to
        /// 1. Not present when PropMask.fPicture is set to zero.
        if mask.fPicture {
            self.picture = try dataStream.read(endianess: .littleEndian)
            guard self.picture == 0xFFFF else {
                throw OfficeFormFileError.corrupted
            }
        } else {
            self.picture = nil
        }
        
        /// Padding7 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fZoom {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// Zoom (4 bytes): An unsigned integer that specifies the value of the Zoom property.
        if mask.fZoom {
            self.zoom = try Zoom(dataStream: &dataStream)
        } else {
            self.zoom = nil
        }
        
        /// PictureAlignment (1 byte): An unsigned integer that specifies the value of the PictureAlignment property.
        if mask.fPictureAlignment {
            self.pictureAlignment = try fmPictureAlignment(dataStream: &dataStream)
        } else {
            self.pictureAlignment = nil
        }
        
        /// PictureSizeMode (1 byte): An unsigned integer that specifies the value of the PictureSizeMode property.
        if mask.fPictureSizeMode {
            self.pictureSizeMode = try fmPictureSizeMode(dataStream: &dataStream)
        } else {
            self.pictureSizeMode = nil
        }
        
        /// Padding8 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fShapeCookie {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// ShapeCookie (4 bytes): An unsigned integer that specifies the value of the ShapeCookie property.
        if mask.fShapeCookie {
            self.shapeCookie = try dataStream.read(endianess: .littleEndian)
        } else {
            self.shapeCookie = nil
        }
        
        /// Padding9 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fDrawBuffer {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// DrawBuffer (4 bytes): An unsigned integer that specifies the value of the DrawBuffer property.
        if mask.fDrawBuffer {
            self.drawBuffer = try dataStream.read(endianess: .littleEndian)
        } else {
            self.drawBuffer = nil
        }
        
        /// Padding10 (variable): MUST be set to zero. The size of this field is the least number of bytes required to make the total size, in
        /// bytes, of this FormDataBlock divisible by 4.
        try dataStream.fourByteAlign(startPosition: startPosition)
    }
}
