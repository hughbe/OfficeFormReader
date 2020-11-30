//
//  CountOfBytesWithCompressionFlag.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.4.14.2 CountOfBytesWithCompressionFlag
/// Specifies the size of an fmString and whether the string is compressed
public struct CountOfBytesWithCompressionFlag {
    public let cb: UInt32
    public let fCompressed: Bool
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// cb (31 bits): An unsigned integer that specifies the size of the string in bytes. The size of a compressed string is the size after
        /// compression.
        self.cb = flags.readBits(count: 31)
        
        /// A - fCompressed (1 bit): Specifies whether the string is compressed.
        self.fCompressed = flags.readBit()
    }
}
