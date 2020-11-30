//
//  DesignExtender.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS_FORMS] 2.2.10.11.1 DesignExtender
/// Specifies design-time properties of a FormControl as persisted to a stream.
public struct DesignExtender {
    public let minorVersion: UInt8
    public let majorVersion: UInt8
    public let cbDesignExtender: UInt16
    public let propMask: DesignExtenderPropMask
    public let dataBlock: DesignExtenderDataBlock
    
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
        
        /// cbDesignExtender (2 bytes): An unsigned integer that specifies the sum of the sizes, in bytes, of PropMask and DataBlock.
        self.cbDesignExtender = try dataStream.read(endianess: .littleEndian)
        guard self.cbDesignExtender >= 4 else {
            throw OfficeFormFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// PropMask (4 bytes): A DesignExtenderPropMask that specifies which properties of the control are not set to the file format default.
        self.propMask = try DesignExtenderPropMask(dataStream: &dataStream)
        
        /// DataBlock (variable): A DesignExtenderDataBlock that specifies the properties of the control that are 4 bytes or smaller and are
        /// not set to the file format defaults.
        self.dataBlock = try DesignExtenderDataBlock(dataStream: &dataStream, mask: self.propMask)
        
        guard dataStream.position - startPosition == self.cbDesignExtender else {
            throw OfficeFormFileError.corrupted
        }
    }
}
