//
//  TabStripExtraDataBlock.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.9.4 TabStripExtraDataBlock
/// Specifies the properties of the control that are larger than 4 bytes and are not set to the file format defaults. If the corresponding bit in the PropMask
/// of the TabStripControl that contains this TabStripExtraDataBlock is set to zero, the property value MUST NOT be stored in the file.
/// Properties that can have a different value for each tab MUST be stored if at least one tab has a nondefault value for the property. The property values
/// are persisted as arrays, as specified in section 2.1.1.2.5.
/// The order of elements in Items specifies the order of the tabs in this control. The other property arrays MUST use the same order if they are stored.
public struct TabStripExtraDataBlock {
    public let size: fmSize?
    public let items: [ArrayString]?
    public let tipStrings: [ArrayString]?
    public let tabNames: [ArrayString]?
    public let tags: [ArrayString]?
    public let accelerators: [ArrayString]?
    
    public init(dataStream: inout DataStream, mask: TabStripPropMask, data: TabStripDataBlock) throws {
        /// Size (8 bytes): An fmSize that specifies the value of the Size property.
        if mask.fSize {
            self.size = try fmSize(dataStream: &dataStream)
        } else {
            self.size = nil
        }
        
        func readStrings(size: UInt32) throws -> [ArrayString] {
            let startPosition = dataStream.position
            var result: [ArrayString] = []
            while dataStream.position - startPosition < size {
                result.append(try ArrayString(dataStream: &dataStream))
            }
            
            if dataStream.position - startPosition != size {
                throw OfficeFormFileError.corrupted
            }
            
            return result
        }
        
        /// Items (variable): An array of ArrayString. Specifies the value of the Caption property for each tab in the TabStripControl that contains this
        /// TabStripExtraDataBlock. The first element in the array corresponds to the first tab, and so on. The size, in bytes, of this array MUST be
        /// equal to the value of the DataBlock.ItemsSize in the TabStripControl that contains this TabStripExtraDataBlock.
        if mask.fItems {
            self.items = try readStrings(size: data.itemsSize!)
        } else {
            self.items = nil
        }
        
        /// TipStrings (variable): An array of ArrayString. Specifies the value of the Tooltip property for each tab in the TabStripControl that contains
        /// this TabStripExtraDataBlock. The first element in the array corresponds to the first tab, and so on. The size, in bytes, of this array MUST
        /// be equal to the value of the DataBlock.TipStringsSize in the TabStripControl that contains this TabStripExtraDataBlock.
        if mask.fTipStrings {
            self.tipStrings = try readStrings(size: data.tipStringsSize!)
        } else {
            self.tipStrings = nil
        }
        
        /// TabNames (variable): An array of ArrayString. Specifies the value of the Name property for each tab in the TabStripControl that contains
        /// this TabStripExtraDataBlock. The first element in the array corresponds to the first tab, and so on. The size, in bytes, of this array MUST
        /// be equal to the value of the DataBlock.NamesSize in the TabStripControl that contains this TabStripExtraDataBlock.
        if mask.fNames {
            self.tabNames = try readStrings(size: data.namesSize!)
        } else {
            self.tabNames = nil
        }
        
        /// Tags (variable): An array of ArrayString. Specifies the value of the Tag property for each tab in the TabStripControl that contains this
        /// TabStripExtraDataBlock. The first element in the array corresponds to the first tab, and so on. The size, in bytes, of this array MUST be
        /// equal to the value of the DataBlock.TagsSize in the TabStripControl that contains this TabStripExtraDataBlock.
        if mask.fTags {
            self.tags = try readStrings(size: data.tagsSize!)
        } else {
            self.tags = nil
        }
        
        /// Accelerators (variable): An array of ArrayString. Specifies the value of the Accelerator property for each tab in the TabStripControl that
        /// contains this TabStripExtraDataBlock. The first element in the array corresponds to the first tab, and so on. The size, in bytes, of this
        /// array MUST be equal to the value of the DataBlock.AcceleratorsSize in the TabStripControl that contains this TabStripExtraDataBlock.
        if mask.fAccelerator {
            self.accelerators = try readStrings(size: data.acceleratorsSize!)
        } else {
            self.accelerators = nil
        }
    }
}
