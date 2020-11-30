//
//  OleSiteConcreteControl.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.10.12.1 OleSiteConcreteControl
/// Specifies properties of embedded controls in a FormControl as persisted to a stream.
public struct OleSiteConcreteControl {
    public let version: UInt16
    public let cbSite: UInt16
    public let propMask: SitePropMask
    public let dataBlock: SiteDataBlock
    public let extraDataBlock: SiteExtraDataBlock
    
    public init(dataStream: inout DataStream) throws {
        /// Version (2 bytes): An unsigned integer that specifies the version of the control. MUST be set to 0x0000.
        self.version = try dataStream.read(endianess: .littleEndian)
        guard self.version == 0x0000 else {
            throw OfficeFormFileError.corrupted
        }
        
        /// cbSite (2 bytes): An unsigned integer that specifies the sum of the sizes, in bytes, of PropMask, DataBlock and ExtraDataBlock.
        self.cbSite = try dataStream.read(endianess: .littleEndian)
        guard self.cbSite >= 4 else {
            throw OfficeFormFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// PropMask (4 bytes): A SitePropMask that specifies which properties of the control are not set to the file format default.
        self.propMask = try SitePropMask(dataStream: &dataStream)
        
        /// DataBlock (variable): A SiteDataBlock that specifies the properties of the control that are 4 bytes or smaller and are not set to the
        /// file format defaults.
        self.dataBlock = try SiteDataBlock(dataStream: &dataStream, mask: self.propMask)
        
        /// ExtraDataBlock (variable): A SiteExtraDataBlock that specifies the properties of the control that are larger than 4 bytes and are not
        /// set to the file format defaults.
        self.extraDataBlock = try SiteExtraDataBlock(dataStream: &dataStream, mask: self.propMask, data: self.dataBlock)
        
        guard dataStream.position - startPosition == self.cbSite else {
            throw OfficeFormFileError.corrupted
        }
    }
}
