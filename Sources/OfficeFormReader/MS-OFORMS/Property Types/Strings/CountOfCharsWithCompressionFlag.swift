//
//  CountOfCharsWithCompressionFlag.swift
//
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.4.14.3 CountOfCharsWithCompressionFlag
/// Specifies the size of an fmString in an array and whether or not the string is compressed.
public struct CountOfCharsWithCompressionFlag {
    public let cch: UInt32
    public let fCompressed: Bool
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// cch (31 bits): An unsigned integer that specifies the number of characters in the string.
        self.cch = flags.readBits(count: 31)
        
        /// A - fCompressed (1 bit): Specifies whether the string is compressed.
        self.fCompressed = flags.readBit()
    }
}
