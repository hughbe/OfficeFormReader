//
//  fmString.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.4.14.4 fmString
/// An array of characters that specifies the value of a Unicode string. The size of the string is specified by the cb of the
/// CountOfBytesWithCompressionFlag or the cch of the CountOfCharsWithCompressionFlag associated with this string. Whether the characters
/// are those of a compressed string is specified by the fCompressed of the CountOfBytesWithCompressionFlag or
/// CountOfCharsWithCompressionFlag associated with this fmString.
public struct fmString {
    public let value: String
    
    public init(dataStream: inout DataStream, count: CountOfBytesWithCompressionFlag) throws {
        let startPosition = dataStream.position
        
        if count.fCompressed {
            self.value = try dataStream.readString(count: Int(count.cb), encoding: .ascii)!
        } else {
            self.value = try dataStream.readString(count: Int(count.cb), encoding: .utf16LittleEndian)!
        }
        
        /// Property values that are strings are padded to a length that is divisible by 4, as specified in section 2.4.14. Strings that are stored
        /// as part of a property of another type are not padded.
        try dataStream.fourByteAlign(startPosition: startPosition)
    }
    
    public init(dataStream: inout DataStream, count: CountOfCharsWithCompressionFlag) throws {
        let startPosition = dataStream.position
        
        if count.fCompressed {
            self.value = try dataStream.readString(count: Int(count.cch), encoding: .ascii)!
        } else {
            self.value = try dataStream.readString(count: Int(count.cch) * 2, encoding: .utf16LittleEndian)!
        }
        
        /// Property values that are strings are padded to a length that is divisible by 4, as specified in section 2.4.14. Strings that are stored
        /// as part of a property of another type are not padded.
        try dataStream.fourByteAlign(startPosition: startPosition)
    }
}
