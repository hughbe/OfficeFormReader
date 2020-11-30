//
//  PaddingAndAlignment.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.1.1.2.4 Padding and Alignment
/// Property values stored in the DataBlock portion of a control MUST be stored on alignment boundaries equal to the size of the property value,
/// relative to the beginning of the control in the stream. All 4- byte property values MUST be stored beginning at an offset into the stream, from
/// the beginning of the version number, that is divisible by 4. All 2-byte property values MUST be stored at an offset into the stream, from the
/// beginning of the version number, that is divisible by 2. Extra bytes MUST be added to the stream before any property value that would otherwise
/// be stored starting at an unaligned offset. The value of each of these bytes is undefined, and the bytes MUST be ignored. Padding MUST
/// NOT be added before a property value that is not stored.
/// After all property values that are less than or equal to 4 bytes in size have been persisted to the stream, extra bytes MUST be added so that
/// the total size, in bytes, of all persisted property values and padding is divisible by 4. The value of these extra bytes at the end of the DataBlock
/// MUST be set to zero, and the bytes MUST be ignored.
extension DataStream {
    public mutating func fourByteAlign(startPosition: Int) throws {
        try align(to: 4, startPosition: startPosition)
    }
    
    public mutating func twoByteAlign(startPosition: Int) throws {
        try align(to: 2, startPosition: startPosition)
    }
    
    public mutating func align(to alignment: Int, startPosition: Int) throws {
        let excessBytes = (position - startPosition) % alignment
        guard excessBytes != 0 else {
            return
        }
        
        let bytesNeeded = alignment - excessBytes
        guard position + bytesNeeded <= count else {
            throw DataStreamError.noSpace(position: position, count: bytesNeeded)
        }
        
        position += bytesNeeded
    }
}
