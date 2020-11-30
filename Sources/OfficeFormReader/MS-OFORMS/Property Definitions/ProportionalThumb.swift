//
//  ProportionalThumb.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.70 ProportionalThumb
/// A signed integer that specifies the size of the scroll box. MUST be set to either 0xFFFF or 0x0000. A value of 0xFFFF specifies that the scroll box is
/// proportional in size to the scrolling region. A value of 0x0000 specifies that the size of the scroll box is fixed.
/// The file format default is 0xFFFF, scroll box proportionally sized.
/// Applies to: ScrollBar
public enum ProportionalThumb: UInt16 {
    case proportionalInSizeToScrollingRegion = 0xFFFF
    case fixedSize = 0x0000
    
    public init(dataStream: inout DataStream) throws {
        guard let value = Self(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFormFileError.corrupted
        }
        
        self = value
    }
}
