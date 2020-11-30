//
//  PageProperties.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.6.4.1 PageProperties
/// Specifies the structure of the control as persisted to a stream.
public struct PageProperties {
    public let minorVersion: UInt8
    public let majorVersion: UInt8
    public let cbPage: UInt16
    public let propMask: PagePropMask
    public let dataBlock: PageDataBlock
    
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
        
        /// cbPage (2 bytes): An unsigned integer that specifies the sum of the sizes, in bytes, of PropMask and DataBlock.
        self.cbPage = try dataStream.read(endianess: .littleEndian)
        guard self.cbPage >= 4 else {
            throw OfficeFormFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// PropMask (4 bytes): A PagePropMask that specifies which properties of the control are not set to the file format default.
        self.propMask = try PagePropMask(dataStream: &dataStream)
        
        /// DataBlock (variable): A PageDataBlock that specifies the properties of the control that are 4 bytes or smaller and are not set to the file
        /// format defaults.
        self.dataBlock = try PageDataBlock(dataStream: &dataStream, mask: self.propMask)
        
        guard dataStream.position - startPosition == self.cbPage else {
            throw OfficeFormFileError.corrupted
        }
    }
}
