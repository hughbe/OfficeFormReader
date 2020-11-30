//
//  LabelExtraDataBlock.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.4.4 LabelExtraDataBlock
/// Specifies the properties of the control that are larger than 4 bytes and are not set to the file format defaults. If the corresponding bit in the
/// PropMask of the LabelControl that contains this LabelExtraDataBlock is set to zero, the property value MUST NOT be stored in the file.
public struct LabelExtraDataBlock {
    public let caption: fmString?
    public let size: fmSize?
    
    public init(dataStream: inout DataStream, mask: LabelPropMask, data: LabelDataBlock) throws {
        /// Caption (variable): An fmString that specifies the Caption property. The size and compression of the string are specified by the
        /// DataBlock.Caption of the LabelControl that contains this LabelExtraDataBlock.
        if mask.fCaption {
            self.caption = try fmString(dataStream: &dataStream, count: data.caption!)
        } else {
            self.caption = nil
        }
        
        /// Size (8 bytes): An fmSize that specifies the Size property
        if mask.fSize {
            self.size = try fmSize(dataStream: &dataStream)
        } else {
            self.size = nil
        }
    }
}
