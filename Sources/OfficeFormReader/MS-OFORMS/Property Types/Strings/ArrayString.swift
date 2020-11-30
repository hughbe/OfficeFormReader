//
//  ArrayString.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.4.14.1 ArrayString
/// Specifies the size, format, and contents of a string that is persisted to a stream as part of an array. The CountOfCharsWithCompressionFlag
/// is stored directly preceding the fmString.
public struct ArrayString {
    public let countAndCompression: CountOfCharsWithCompressionFlag
    public let uncompressedString: fmString?
    public let compressedString: fmString?
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// CountAndCompression (4 bytes): A CountOfCharsWithCompressionFlag that specifies the size and format of the string that follows.
        let countAndCompression = try CountOfCharsWithCompressionFlag(dataStream: &dataStream)
        self.countAndCompression = countAndCompression
        
        /// UncompressedString (variable): An fmString that is not compressed. If the CountAndCompression.fCompressed of this
        /// ArrayString is set to 1 or the CountAndCompression.cch of this ArrayString is set to zero, this fmString MUST NOT be stored.
        if !countAndCompression.fCompressed && countAndCompression.cch > 0 {
            self.uncompressedString = try fmString(dataStream: &dataStream, count: self.countAndCompression)
        } else {
            self.uncompressedString = nil
        }
        
        /// CompressedString (variable): An fmString that is compressed. If the CountAndCompression.fCompressed of this ArrayString is
        /// set to zero or the CountAndCompression.cch of this ArrayString is set to zero, this fmString MUST NOT be stored.
        if countAndCompression.fCompressed && countAndCompression.cch > 0 {
            self.compressedString = try fmString(dataStream: &dataStream, count: self.countAndCompression)
        } else {
            self.compressedString = nil
        }
        
        /// Padding (variable): Undefined and MUST be ignored. The size of this array is the least number of bytes required to make the total
        /// size, in bytes, of this ArrayString divisible by 4.
        try dataStream.fourByteAlign(startPosition: startPosition)
    }
}
