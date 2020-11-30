//
//  FormExtraDataBlock.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.10.4 FormExtraDataBlock
/// Specifies the properties of the control that are larger than 4 bytes and are not set to the file format defaults. If the corresponding bit in the
/// PropMask of the FormControl that contains this FormExtraDataBlock is set to zero, the property value MUST NOT be stored in the file.
public struct FormExtraDataBlock {
    public let displayedSize: fmSize?
    public let logicalSize: fmSize?
    public let scrollPosition: fmPosition?
    public let captionString: fmString?
    
    public init(dataStream: inout DataStream, mask: FormPropMask, data: FormDataBlock) throws {
        /// DisplayedSize (8 bytes): An fmSize that specifies the value of the DisplayedSize property.
        if mask.fDisplayedSize {
            self.displayedSize = try fmSize(dataStream: &dataStream)
        } else {
            self.displayedSize = nil
        }
        
        /// LogicalSize (8 bytes): An fmSize that specifies the value of the LogicalSize property.
        if mask.fLogicalSize {
            self.logicalSize = try fmSize(dataStream: &dataStream)
        } else {
            self.logicalSize = nil
        }
        
        /// ScrollPosition (8 bytes): An fmPosition that specifies the value of the ScrollPosition property.
        if mask.fScrollPosition {
            self.scrollPosition = try fmPosition(dataStream: &dataStream)
        } else {
            self.scrollPosition = nil
        }
        
        /// CaptionString (variable): An fmString that specifies the Caption property. The size and compression of the string is specified by the
        /// DataBlock.LengthAndCompression of the FormControl that contains this FormExtraDataBlock.
        if mask.fCaption {
            self.captionString = try fmString(dataStream: &dataStream, count: data.lengthAndCompression!)
        } else {
            self.captionString = nil
        }
    }
}
