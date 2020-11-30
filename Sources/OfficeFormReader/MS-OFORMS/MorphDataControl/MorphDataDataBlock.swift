//
//  MorphDataDataBlock.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.5.3 MorphDataDataBlock
/// Specifies the properties of the control that are 4 bytes or smaller and are not set to the file format defaults. If the corresponding bit in the
/// PropMask of the MorphDataControl that contains this MorphDataDataBlock is set to zero, the property value MUST NOT be stored in the file.
public struct MorphDataDataBlock {
    public let variousPropertyBits: VariousPropertiesBitfield?
    public let backColor: OLE_COLOR?
    public let foreColor: OLE_COLOR?
    public let maxLength: UInt32?
    public let borderStyle: fmBorderStyle?
    public let scrollBars: fmScrollBars?
    public let displayStyle: fmDisplayStyle?
    public let mousePointer: UInt8?
    public let passwordChar: Character?
    public let listWidth: UInt32?
    public let boundColumn: Int16?
    public let textColumn: TextColumn?
    public let columnCount: ColumnCount?
    public let listRows: UInt16?
    public let cColumnInfo: UInt16?
    public let matchEntry: fmMatchEntry?
    public let listStyle: fmListStyle?
    public let showDropButtonWhen: fmShowDropButtonWhen?
    public let dropButtonStyle: fmDropButtonStyle?
    public let multiSelect: fmMultiSelect?
    public let value: CountOfBytesWithCompressionFlag?
    public let caption: CountOfBytesWithCompressionFlag?
    public let picturePosition: fmPicturePosition?
    public let borderColor: OLE_COLOR?
    public let specialEffect: fmSpecialEffect?
    public let mouseIcon: UInt16?
    public let picture: UInt16?
    public let accelerator: Accelerator?
    public let groupName: CountOfBytesWithCompressionFlag?
    
    public init(dataStream: inout DataStream, mask: MorphDataPropMask) throws {
        let startPosition = dataStream.position
        
        /// VariousPropertyBits (4 bytes): A VariousPropertiesBitfield that specifies the value of the VariousPropertyBits properties.
        if mask.fVariousPropertyBits {
            self.variousPropertyBits = try VariousPropertiesBitfield(dataStream: &dataStream)
        } else {
            self.variousPropertyBits = nil
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
        
        /// MaxLength (4 bytes): An unsigned integer that specifies the value of the MaxLength property.
        if mask.fMaxLength {
            self.maxLength = try dataStream.read(endianess: .littleEndian)
        } else {
            self.maxLength = nil
        }
        
        /// BorderStyle (1 byte): An fmBorderStyle that specifies the value of the BorderStyle property.
        if mask.fBorderStyle {
            self.borderStyle = try fmBorderStyle(dataStream: &dataStream)
        } else {
            self.borderStyle = nil
        }
        
        /// ScrollBars (1 byte): An fmScrollBars that specifies the value of the ScrollBars property.
        if mask.fScrollBars {
            self.scrollBars = try fmScrollBars(dataStream: &dataStream)
        } else {
            self.scrollBars = nil
        }
        
        /// DisplayStyle (1 byte): An fmDisplayStyle that specifies the value of the DisplayStyle property.
        if mask.fDisplayStyle {
            self.displayStyle = try fmDisplayStyle(dataStream: &dataStream)
        } else {
            self.displayStyle = nil
        }
        
        /// MousePointer (1 byte): An unsigned integer that specifies the value of the MousePointer property.
        if mask.fMousePointer {
            self.mousePointer = try dataStream.read()
        } else {
            self.mousePointer = nil
        }
        
        /// Padding1 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fPasswordChar {
            try dataStream.twoByteAlign(startPosition: startPosition)
        }
        
        /// PasswordChar (2 bytes): A Unicode character that specifies the value of the PasswordChar property.
        if mask.fPasswordChar {
            guard let scalar = Unicode.Scalar(try dataStream.read(endianess: .littleEndian) as UInt16) else {
                throw OfficeFormFileError.corrupted
            }

            self.passwordChar = Character(scalar)
        } else {
            self.passwordChar = nil
        }
        
        /// Padding2 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fListWidth {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// ListWidth (4 bytes): An unsigned integer that specifies the value of the ListWidth property.
        if mask.fListWidth {
            self.listWidth = try dataStream.read(endianess: .littleEndian)
        } else {
            self.listWidth = nil
        }
        
        /// Padding3 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fBoundColumn {
            try dataStream.twoByteAlign(startPosition: startPosition)
        }
        
        /// BoundColumn (2 bytes): An unsigned integer that specifies the value of the BoundColumn property.
        if mask.fBoundColumn {
            self.boundColumn = try dataStream.read(endianess: .littleEndian)
        } else {
            self.boundColumn = nil
        }
        
        /// Padding4 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fTextColumn {
            try dataStream.twoByteAlign(startPosition: startPosition)
        }
        
        /// TextColumn (2 bytes): A signed integer that specifies the value of the TextColumn property.
        if mask.fTextColumn {
            self.textColumn = try TextColumn(dataStream: &dataStream)
        } else {
            self.textColumn = nil
        }
        
        /// Padding5 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fColumnCount {
            try dataStream.twoByteAlign(startPosition: startPosition)
        }
        
        /// ColumnCount (2 bytes): A signed integer that specifies the value of the ColumnCount property.
        if mask.fColumnCount {
            self.columnCount = try ColumnCount(dataStream: &dataStream)
        } else {
            self.columnCount = nil
        }

        /// Padding6 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes needed to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fListRows {
            try dataStream.twoByteAlign(startPosition: startPosition)
        }
        
        /// ListRows (2 bytes): An unsigned integer that specifies the value of the ListRows property.
        if mask.fListRows {
            self.listRows = try dataStream.read(endianess: .littleEndian)
        } else {
            self.listRows = nil
        }
        
        /// Padding7 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes needed to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fcColumnInfo {
            try dataStream.twoByteAlign(startPosition: startPosition)
        }
        
        /// cColumnInfo (2 bytes): An unsigned integer that specifies the value of the cColumnInfo property.
        if mask.fcColumnInfo {
            self.cColumnInfo = try dataStream.read(endianess: .littleEndian)
        } else {
            self.cColumnInfo = nil
        }
        
        /// MatchEntry (1 byte): An fmMatchEntry that specifies the value of the MatchEntry property.
        if mask.fMatchEntry {
            self.matchEntry = try fmMatchEntry(dataStream: &dataStream)
        } else {
            self.matchEntry = nil
        }
        
        /// ListStyle (1 byte): An fmListStyle that specifies the value of the ListStyle property.
        if mask.fListStyle {
            self.listStyle = try fmListStyle(dataStream: &dataStream)
        } else {
            self.listStyle = nil
        }
        
        /// ShowDropButtonWhen (1 byte): An fmShowDropButtonWhen that specifies the value of the ShowDropButtonWhen property.
        if mask.fShowDropButtonWhen {
            self.showDropButtonWhen = try fmShowDropButtonWhen(dataStream: &dataStream)
        } else {
            self.showDropButtonWhen = nil
        }
        
        /// DropButtonStyle (1 byte): An fmDropButtonStyle that specifies the value of the DropButtonStyle property.
        if mask.fDropButtonStyle {
            self.dropButtonStyle = try fmDropButtonStyle(dataStream: &dataStream)
        } else {
            self.dropButtonStyle = nil
        }
        
        /// MultiSelect (1 byte): An fmMultiSelect that specifies the value of the MultiSelect property.
        if mask.fMultiSelect {
            self.multiSelect = try fmMultiSelect(dataStream: &dataStream)
        } else {
            self.multiSelect = nil
        }
        
        /// Padding8 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fValue {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// Value (4 bytes): A CountOfBytesWithCompressionFlag that specifies the size and compression of the Value property.
        if mask.fValue {
            self.value = try CountOfBytesWithCompressionFlag(dataStream: &dataStream)
        } else {
            self.value = nil
        }
        
        /// Padding9 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fCaption {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
    
        /// Caption (4 bytes): A CountOfBytesWithCompressionFlag that specifies the size and compression of the Caption property.
        if mask.fCaption {
            self.caption = try CountOfBytesWithCompressionFlag(dataStream: &dataStream)
        } else {
            self.caption = nil
        }
        
        /// Padding10 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fPicturePosition {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// PicturePosition (4 bytes): An fmPicturePosition that specifies the value of the PicturePosition property.
        if mask.fPicturePosition {
            self.picturePosition = try fmPicturePosition(dataStream: &dataStream)
        } else {
            self.picturePosition = nil
        }
        
        /// Padding11 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
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
    
        /// Padding12 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fSpecialEffect {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// SpecialEffect (4 bytes): An fmSpecialEffect that specifies the value of the SpecialEffect property.
        if mask.fSpecialEffect {
            self.specialEffect = try fmSpecialEffect(dataStream: &dataStream)
        } else {
            self.specialEffect = nil
        }

        /// Padding13 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fMouseIcon {
            try dataStream.twoByteAlign(startPosition: startPosition)
        }
        
        /// MouseIcon (2 bytes): MUST be set to 0xFFFF when the PropMask.fMouseIcon of the MorphDataControl that contains this
        /// MorphDataDataBlock is set to 1. Not present when PropMask.fMouseIcon is set to zero.
        if mask.fMouseIcon {
            self.mouseIcon = try dataStream.read(endianess: .littleEndian)
            guard self.mouseIcon == 0xFFFF else {
                throw OfficeFormFileError.corrupted
            }
        } else {
            self.mouseIcon = nil
        }
        
        /// Padding14 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fPicture {
            try dataStream.twoByteAlign(startPosition: startPosition)
        }
        
        /// Picture (2 bytes): MUST be set to 0xFFFF when the PropMask.fPicture of the MorphDataControl that contains this
        /// MorphDataDataBlock is set to 1. Not present when PropMask.fPicture is set to zero.
        if mask.fPicture {
            self.picture = try dataStream.read(endianess: .littleEndian)
            guard self.picture == 0xFFFF else {
                throw OfficeFormFileError.corrupted
            }
        } else {
            self.picture = nil
        }
        
        /// Padding15 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
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
    
        /// Padding16 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fGroupName {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// GroupName (4 bytes): A CountOfBytesWithCompressionFlag that specifies the size and compression of the GroupName property.
        if mask.fGroupName {
            self.groupName = try CountOfBytesWithCompressionFlag(dataStream: &dataStream)
        } else {
            self.groupName = nil
        }
        
        /// Padding17 (variable): MUST be set to zero. The size of this field is the least number of bytes required to make the total size, in bytes,
        /// of this MorphDataDataBlock divisible by 4.
        try dataStream.fourByteAlign(startPosition: startPosition)
    }
}
