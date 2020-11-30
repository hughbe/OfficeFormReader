//
//  ImageExtraDataBlock.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.3.4 ImageExtraDataBlock
/// Specifies the properties of the control that are larger than 4 bytes and are not set to the file format defaults. If the corresponding bit in the
/// PropMask of the ImageControl that contains this ImageExtraDataBlock is set to zero, the property value MUST NOT be stored in the file.
public struct ImageExtraDataBlock {
    public let size: fmSize?
    
    public init(dataStream: inout DataStream, mask: ImagePropMask, data: ImageDataBlock) throws {
        /// Size (8 bytes): An fmSize that specifies the Size property.
        if mask.fSize {
            self.size = try fmSize(dataStream: &dataStream)
        } else {
            self.size = nil
        }
    }
}
