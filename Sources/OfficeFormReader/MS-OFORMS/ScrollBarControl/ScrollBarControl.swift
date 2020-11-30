//
//  ScrollBarControl.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.7.1 ScrollBarControl
/// Specifies the structure of the control as persisted to a stream.
public struct ScrollBarControl {
    public let minorVersion: UInt8
    public let majorVersion: UInt8
    public let cbScrollBar: UInt16
    public let propMask: ScrollBarPropMask
    public let dataBlock: ScrollBarDataBlock
    public let extraDataBlock: ScrollBarExtraDataBlock
    public let streamData: ScrollBarStreamData
    
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
        
        /// cbScrollBar (2 bytes): An unsigned integer that specifies the sum of the sizes, in bytes, of PropMask, DataBlock, and ExtraDataBlock.
        self.cbScrollBar = try dataStream.read(endianess: .littleEndian)
        guard self.cbScrollBar >= 4 else {
            throw OfficeFormFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// PropMask (4 bytes): A ScrollBarPropMask that specifies which properties of the control are not set to the file format default.
        self.propMask = try ScrollBarPropMask(dataStream: &dataStream)
        
        /// DataBlock (variable): A ScrollBarDataBlock that specifies the properties of the control that are 4 bytes or smaller and are not set to the
        /// file format defaults.
        self.dataBlock = try ScrollBarDataBlock(dataStream: &dataStream, mask: self.propMask)
        
        /// ExtraDataBlock (variable): A ScrollBarExtraDataBlock that specifies the properties of the control that are larger than 4 bytes and are not
        /// set to the file format defaults.
        self.extraDataBlock = try ScrollBarExtraDataBlock(dataStream: &dataStream, mask: self.propMask, data: self.dataBlock)
        
        guard dataStream.position - startPosition == self.cbScrollBar else {
            throw OfficeFormFileError.corrupted
        }
        
        /// StreamData (variable): A ScrollBarStreamData that specifies picture properties of the control that are not set to the file format defaults.
        self.streamData = try ScrollBarStreamData(dataStream: &dataStream, mask: self.propMask)
    }
}
