//
//  CommandButtonControl.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.1.1 CommandButtonControl
/// Specifies the structure of the control as persisted to a stream.
public struct CommandButtonControl {
    public let minorVersion: UInt8
    public let majorVersion: UInt8
    public let cbCommandButton: UInt16
    public let propMask: CommandButtonPropMask
    public let dataBlock: CommandButtonDataBlock
    public let extraDataBlock: CommandButtonExtraDataBlock
    public let streamData: CommandButtonStreamData
    public let textProps: TextProps
    
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
        
        /// cbCommandButton (2 bytes): An unsigned integer that specifies the sum of the sizes, in bytes, of PropMask, DataBlock,
        /// and ExtraDataBlock.
        self.cbCommandButton = try dataStream.read(endianess: .littleEndian)
        guard self.cbCommandButton >= 4 else {
            throw OfficeFormFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// PropMask (4 bytes): A CommandButtonPropMask that specifies which properties of the control are not set to the file format default.
        self.propMask = try CommandButtonPropMask(dataStream: &dataStream)
        
        /// DataBlock (variable): A CommandButtonDataBlock that specifies the properties of the control that are 4 bytes or smaller and are
        /// not set to the file format defaults.
        self.dataBlock = try CommandButtonDataBlock(dataStream: &dataStream, mask: self.propMask)
        
        /// ExtraDataBlock (variable): A CommandButtonExtraDataBlock that specifies the properties of the control that are larger than 4 bytes
        /// and are not set to the file format defaults.
        self.extraDataBlock = try CommandButtonExtraDataBlock(dataStream: &dataStream, mask: self.propMask, data: self.dataBlock)
        
        guard dataStream.position - startPosition == self.cbCommandButton else {
            throw OfficeFormFileError.corrupted
        }
        
        /// StreamData (variable): A CommandButtonStreamData that specifies picture properties of the control that are not set to the file
        /// format defaults.
        self.streamData = try CommandButtonStreamData(dataStream: &dataStream, mask: self.propMask)
        
        /// TextProps (variable): A TextProps that specifies text-related properties of the control.
        self.textProps = try TextProps(dataStream: &dataStream)
    }
}
