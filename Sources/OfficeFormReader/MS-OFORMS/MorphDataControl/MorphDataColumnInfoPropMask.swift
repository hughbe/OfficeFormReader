//
//  MorphDataColumnInfoPropMask.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.5.7 MorphDataColumnInfoPropMask
/// Specifies whether the width of this column is not set to the file format default. A value of zero in fColumnWidth specifies that the Width
/// property is the file format default and is not stored in the file.
public struct MorphDataColumnInfoPropMask {
    public let fColumnWidth: Bool
    public let unusedBits: UInt32
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fColumnWidth (1 bit): Specifies whether the Width property is stored in the DataBlock.ColumnWidth of the MorphDataColumnInfo
        /// that contains this MorphDataColumnInfoPropMask.
        self.fColumnWidth = flags.readBit()
        
        /// UnusedBits (31 bits): MUST be set to zero.
        self.unusedBits = flags.readRemainingBits()
    }
}
