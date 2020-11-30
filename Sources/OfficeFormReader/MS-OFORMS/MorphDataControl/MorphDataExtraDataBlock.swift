//
//  MorphDataExtraDataBlock.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

public struct MorphDataExtraDataBlock {
    public let size: fmSize?
    public let value: fmString?
    public let caption: fmString?
    public let groupName: fmString?
    
    public init(dataStream: inout DataStream, mask: MorphDataPropMask, data: MorphDataDataBlock) throws {
        /// Size (8 bytes): An fmSize that specifies the Size property.
        if mask.fSize {
            self.size = try fmSize(dataStream: &dataStream)
        } else {
            self.size = nil
        }
        
        /// Value (variable): An fmString that specifies the Value property. The size and compression of the string is specified by the
        /// DataBlock.Value of the MorphDataControl that contains this MorphDataExtraDataBlock.
        if mask.fValue {
            self.value = try fmString(dataStream: &dataStream, count: data.value!)
        } else {
            self.value = nil
        }
        
        /// Caption (variable): An fmString that specifies the Caption property. The size and compression of the string is specified by the
        /// DataBlock.Caption of the MorphDataControl that contains this MorphDataExtraDataBlock.
        if mask.fCaption {
            self.caption = try fmString(dataStream: &dataStream, count: data.caption!)
        } else {
            self.caption = nil
        }
        
        /// GroupName (variable): An fmString that specifies the GroupName property. The size and compression of the string is specified by
        /// the DataBlock.GroupName of the MorphDataControl that contains this MorphDataExtraDataBlock.
        if mask.fGroupName {
            self.groupName = try fmString(dataStream: &dataStream, count: data.groupName!)
        } else {
            self.groupName = nil
        }
    }
}
