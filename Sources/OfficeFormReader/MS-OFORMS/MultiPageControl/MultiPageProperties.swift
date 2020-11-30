//
//  MultiPageProperties.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.6.1 MultiPageProperties
/// Specifies the structure of the control as persisted to a stream.
public struct MultiPageProperties {
    public let minorVersion: UInt8
    public let majorVersion: UInt8
    public let cbMultiPageControlProperties: UInt16
    public let propMask: MultiPagePropertiesPropMask
    public let dataBlock: MultiPagePropertiesDataBlock
    public let pageIDs: [Int32]
    
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
        
        /// cbMultiPageControlProperties (2 bytes): An unsigned integer that specifies the sum of the sizes, in bytes, of PropMask and DataBlock.
        self.cbMultiPageControlProperties = try dataStream.read(endianess: .littleEndian)
        guard self.cbMultiPageControlProperties >= 4 else {
            throw OfficeFormFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// PropMask (4 bytes): A MultiPagePropertiesPropMask that specifies which properties of the control are not set to the file format default.
        self.propMask = try MultiPagePropertiesPropMask(dataStream: &dataStream)
        
        /// DataBlock (variable): A MultiPagePropertiesDataBlock that specifies the properties of the control that are 4 bytes or smaller and are not
        /// set to the file format default.
        self.dataBlock = try MultiPagePropertiesDataBlock(dataStream: &dataStream, mask: self.propMask)
        
        guard dataStream.position - startPosition == self.cbMultiPageControlProperties else {
            throw OfficeFormFileError.corrupted
        }
        
        /// PageIDs (variable): An array of ID. Specifies the value of the ID property for each Page of the MultiPage control, where the first entry in the
        /// array specifies the ID of the first Page, and so on.
        if let pageCount = self.dataBlock.pageCount {
            var pageIDs: [Int32] = []
            pageIDs.reserveCapacity(Int(pageCount))
            for _ in 0..<pageCount {
                pageIDs.append(try dataStream.read(endianess: .littleEndian))
            }
            
            self.pageIDs = pageIDs
        } else {
            self.pageIDs = []
        }
    }
}
