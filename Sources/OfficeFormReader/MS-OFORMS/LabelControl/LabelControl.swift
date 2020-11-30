//
//  LabelControl.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.4.1 LabelControl
/// Specifies the structure of the control as persisted to a stream.
public struct LabelControl {
    public let minorVersion: UInt8
    public let majorVersion: UInt8
    public let cbLabel: UInt16
    public let propMask: LabelPropMask
    public let dataBlock: LabelDataBlock
    public let extraDataBlock: LabelExtraDataBlock
    public let streamData: LabelStreamData
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
        
        /// cbLabel (2 bytes): An unsigned integer that specifies the sum of the sizes, in bytes, of PropMask, DataBlock, and ExtraDataBlock.
        self.cbLabel = try dataStream.read()
        guard self.cbLabel >= 4 else {
            throw OfficeFormFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// PropMask (4 bytes): A LabelPropMask that specifies which properties of the control are not set to the file format default.
        self.propMask = try LabelPropMask(dataStream: &dataStream)
        
        /// DataBlock (variable): A LabelDataBlock that specifies the properties of the control that are 4 bytes or smaller and are not set to the
        /// file format defaults.
        self.dataBlock = try LabelDataBlock(dataStream: &dataStream, mask: self.propMask)
        
        /// ExtraDataBlock (variable): A LabelExtraDataBlock that specifies the properties of the control that are larger than 4 bytes and
        /// are not set to the file format defaults.
        self.extraDataBlock = try LabelExtraDataBlock(dataStream: &dataStream, mask: self.propMask, data: self.dataBlock)
        
        guard dataStream.position - startPosition == self.cbLabel else {
            throw OfficeFormFileError.corrupted
        }
        
        /// StreamData (variable): A LabelStreamData that specifies picture properties of the control that are not set to the file format defaults.
        self.streamData = try LabelStreamData(dataStream: &dataStream, mask: self.propMask)
        
        /// TextProps (variable): A TextProps that specifies text-related properties of the control.
        self.textProps = try TextProps(dataStream: &dataStream)
    }
}
