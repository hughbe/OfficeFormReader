//
//  ImageControl.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

public struct ImageControl {
    public let minorVersion: UInt8
    public let majorVersion: UInt8
    public let cbImage: UInt16
    public let propMask: ImagePropMask
    public let dataBlock: ImageDataBlock
    public let extraDataBlock: ImageExtraDataBlock
    public let streamData: ImageStreamData
    
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
        
        /// cbImage (2 bytes): An unsigned integer that specifies the sum of the sizes, in bytes, of PropMask, DataBlock, and ExtraDataBlock.
        self.cbImage = try dataStream.read(endianess: .littleEndian)
        guard self.cbImage >= 4 else {
            throw OfficeFormFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// PropMask (4 bytes): An ImagePropMask that specifies which properties of the control are not set to the file format default.
        self.propMask = try ImagePropMask(dataStream: &dataStream)
        
        /// DataBlock (variable): An ImageDataBlock that specifies the properties of the control that are 4 bytes or smaller and are not set to the file
        /// format defaults.
        self.dataBlock = try ImageDataBlock(dataStream: &dataStream, mask: self.propMask)
        
        /// ExtraDataBlock (variable): An ImageExtraDataBlock that specifies the properties of the control that are larger than 4 bytes and are not set
        /// to the file format defaults.
        self.extraDataBlock = try ImageExtraDataBlock(dataStream: &dataStream, mask: self.propMask, data: self.dataBlock)
        
        guard dataStream.position - startPosition == self.cbImage else {
            throw OfficeFormFileError.corrupted
        }
        
        /// StreamData (variable): An ImageStreamData that specifies picture properties of the control that are not set to the file format defaults.
        self.streamData = try ImageStreamData(dataStream: &dataStream, mask: self.propMask)
    }
}
