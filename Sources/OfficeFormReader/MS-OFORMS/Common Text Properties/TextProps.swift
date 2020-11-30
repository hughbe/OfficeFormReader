//
//  TextProps.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.3.1 TextProps
/// Specifies the values for text-related properties.
/// Applies to: CheckBox | ComboBox | CommandButton | Label | ListBox | OptionButton | TabStrip | TextBox | ToggleButton
public struct TextProps {
    public let minorVersion: UInt8
    public let majorVersion: UInt8
    public let cbTextProps: UInt16
    public let propMask: TextPropsPropMask
    public let dataBlock: TextPropsDataBlock
    public let extraDataBlock: TextPropsExtraDataBlock
    
    public init(dataStream: inout DataStream) throws {
        /// MinorVersion (1 byte): An unsigned integer that specifies the minor version of the control. MUST be set to 0x00.
        self.minorVersion = try dataStream.read()
        guard self.minorVersion == 0x00 else {
            throw OfficeFormFileError.corrupted
        }
        
        /// MajorVersion (1 byte): An unsigned integer that specifies the major version of the control. MUST be set to 0x02.
        self.majorVersion = try dataStream.read()
        guard self.majorVersion == 0x02 else {
            throw OfficeFormFileError.corrupted
        }
        
        /// cbTextProps (2 bytes): An unsigned integer that specifies the sum of the sizes, in bytes, of PropMask, DataBlock, and ExtraDataBlock.
        self.cbTextProps = try dataStream.read(endianess: .littleEndian)
        guard self.cbTextProps >= 4 else {
            throw OfficeFormFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// PropMask (4 bytes): A TextPropsPropMask that specifies which text properties of the control are not set to the file format defaults.
        self.propMask = try TextPropsPropMask(dataStream: &dataStream)
        
        /// DataBlock (variable): A TextPropsDataBlock that specifies the text properties of the control that are 4 bytes or smaller and are not
        /// set to the file format defaults.
        self.dataBlock = try TextPropsDataBlock(dataStream: &dataStream, mask: self.propMask)
        
        /// ExtraDataBlock (variable): A TextPropsExtraDataBlock that specifies the text properties of the control that are larger than 4 bytes
        /// and are not set to the file format defaults.
        self.extraDataBlock = try TextPropsExtraDataBlock(dataStream: &dataStream, mask: self.propMask, data: self.dataBlock)

        guard dataStream.position - startPosition == self.cbTextProps else {
            throw OfficeFormFileError.corrupted
        }
    }
}
