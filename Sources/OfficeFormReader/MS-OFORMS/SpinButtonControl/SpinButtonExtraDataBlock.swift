//
//  SpinButtonExtraDataBlock.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.8.4 SpinButtonExtraDataBlock
/// Specifies the properties of the control that are larger than 4 bytes and are not set to the file format defaults. If the corresponding bit in the
/// PropMask of the SpinButtonControl that contains this SpinButtonExtraDataBlock is set to zero, the property value MUST NOT be stored in the file.
public struct SpinButtonExtraDataBlock {
    public let size: fmSize?
    
    public init(dataStream: inout DataStream, mask: SpinButtonPropMask, data: SpinButtonDataBlock) throws {
        /// Size (8 bytes): An fmSize that specifies the Size property.
        if mask.fSize {
            self.size = try fmSize(dataStream: &dataStream)
        } else {
            self.size = nil
        }
    }
}
