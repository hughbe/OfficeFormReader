//
//  SpinButtonControl.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.8.1 SpinButtonControl
/// Specifies the structure of the control as persisted to a stream.
public struct SpinButtonControl {
    public let minorVersion: UInt8
    public let majorVersion: UInt8
    public let cbSpinButton: UInt16
    public let propMask: SpinButtonPropMask
    public let dataBlock: SpinButtonDataBlock
    public let extraDataBlock: SpinButtonExtraDataBlock
    public let streamData: SpinButtonStreamData
    
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
        
        /// cbSpinButton (2 bytes): An unsigned integer that specifies the sum of the sizes, in bytes, of PropMask, DataBlock, and ExtraDataBlock.
        self.cbSpinButton = try dataStream.read(endianess: .littleEndian)
        guard self.cbSpinButton >= 4 else {
            throw OfficeFormFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// PropMask (4 bytes): A SpinButtonPropMask that specifies which properties of the control are not set to the file format default.
        self.propMask = try SpinButtonPropMask(dataStream: &dataStream)
        
        /// DataBlock (variable): A SpinButtonDataBlock that specifies the properties of the control that are 4 bytes or smaller and are not set to the
        /// file format defaults.
        self.dataBlock = try SpinButtonDataBlock(dataStream: &dataStream, mask: self.propMask)
        
        /// ExtraDataBlock (variable): A SpinButtonExtraDataBlock that specifies the properties of the control that are larger than 4 bytes and are not
        /// set to the file format defaults.
        self.extraDataBlock = try SpinButtonExtraDataBlock(dataStream: &dataStream, mask: self.propMask, data: self.dataBlock)
        
        guard dataStream.position - startPosition == self.cbSpinButton else {
            throw OfficeFormFileError.corrupted
        }
        
        /// StreamData (variable): A SpinButtonStreamData that specifies picture properties of the control that are not set to the file format defaults.
        self.streamData = try SpinButtonStreamData(dataStream: &dataStream, mask: self.propMask)
    }
}
