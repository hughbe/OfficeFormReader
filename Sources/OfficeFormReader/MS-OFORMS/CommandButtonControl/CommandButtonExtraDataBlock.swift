//
//  CommandButtonExtraDataBlock.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.1.4 CommandButtonExtraDataBlock
/// Specifies the properties of the control that are larger than 4 bytes and are not set to the file format defaults. If the corresponding bit in the
/// PropMask of the CommandButtonControl that contains this CommandButtonExtraDataBlock is set to zero, the property value MUST NOT
/// be stored in the file.
public struct CommandButtonExtraDataBlock {
    public let caption: fmString?
    public let size: fmSize?
    
    public init(dataStream: inout DataStream, mask: CommandButtonPropMask, data: CommandButtonDataBlock) throws {
        /// Caption (variable): An fmString that specifies the Caption property. The size and compression of the string is specified by the
        /// DataBlock.Caption of the CommandButtonControl that contains this CommandButtonExtraDataBlock.
        if mask.fCaption {
            self.caption = try fmString(dataStream: &dataStream, count: data.caption!)
        } else {
            self.caption = nil
        }
        
        /// Size (8 bytes): An fmSize that specifies the Size property.
        if mask.fSize {
            self.size = try fmSize(dataStream: &dataStream)
        } else {
            self.size = nil
        }
    }
}
