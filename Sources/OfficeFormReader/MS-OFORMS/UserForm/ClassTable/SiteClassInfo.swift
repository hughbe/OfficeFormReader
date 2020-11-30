//
//  SiteClassInfo.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.10.10.1 SiteClassInfo
/// Specifies the structure, as persisted to a stream, of the type information of an embedded ActiveX control.
public struct SiteClassInfo {
    public let version: UInt16
    public let cbClassTable: UInt16
    public let propMask: ClassInfoPropMask
    public let dataBlock: ClassInfoDataBlock
    public let extraDataBlock: ClassInfoExtraDataBlock
    
    public init(dataStream: inout DataStream) throws {
        /// Version (2 bytes): An unsigned integer that specifies the version of this SiteClassInfo. MUST be set to 0x0000.
        self.version = try dataStream.read(endianess: .littleEndian)
        guard self.version == 0x0000 else {
            throw OfficeFormFileError.corrupted
        }
        
        /// cbClassTable (2 bytes): An unsigned integer that specifies the sum of the sizes, in bytes, of PropMask, DataBlock, and
        /// ExtraDataBlock.
        self.cbClassTable = try dataStream.read(endianess: .littleEndian)
        guard self.cbClassTable >= 4 else {
            throw OfficeFormFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// PropMask (4 bytes): A ClassInfoPropMask that specifies which properties of this SiteClassInfo are not set to the file format default.
        self.propMask = try ClassInfoPropMask(dataStream: &dataStream)
        
        /// DataBlock (variable): A ClassInfoDataBlock that specifies the properties of this SiteClassInfo that are 4 bytes or smaller and are not
        /// set to the file format defaults.
        self.dataBlock = try ClassInfoDataBlock(dataStream: &dataStream, mask: self.propMask)
        
        /// ExtraDataBlock (variable): A ClassInfoExtraDataBlock that specifies the properties of this SiteClassInfo that are larger than 4 bytes
        /// and are not set to the file format defaults.
        self.extraDataBlock = try ClassInfoExtraDataBlock(dataStream: &dataStream, mask: self.propMask, data: self.dataBlock)
        
        guard dataStream.position - startPosition == self.cbClassTable else {
            throw OfficeFormFileError.corrupted
        }
    }
}
