//
//  MultiPagePropertiesDataBlock.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.6.3 MultiPagePropertiesDataBlock
/// Specifies the properties of the control that are not set to the file format defaults. If the corresponding field in the PropMask of the MultiPageProperties
/// that contains this MultiPagePropertiesDataBlock is set to zero, the property value MUST NOT be stored in the file.
public struct MultiPagePropertiesDataBlock {
    public let pageCount: Int32?
    public let id: Int32?
    
    public init(dataStream: inout DataStream, mask: MultiPagePropertiesPropMask) throws {
        /// PageCount (4 bytes): A signed integer that specifies the value of the PageCount property.
        if mask.fPageCount {
            self.pageCount = try dataStream.read(endianess: .littleEndian)
        } else {
            self.pageCount = nil
        }
        
        /// ID (4 bytes): A signed integer that specifies the value of the ID property.
        if mask.fID {
            self.id = try dataStream.read(endianess: .littleEndian)
        } else {
            self.id = nil
        }
    }
}
