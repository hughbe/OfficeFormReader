//
//  fmPosition.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.4.1 fmPosition
/// Specifies a pair of signed integers that specify a position relative to a reference point.
public struct fmPosition {
    public let top: Int32
    public let left: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// Top (4 bytes): A signed integer that specifies, in HIMETRIC units, a distance below the reference point.
        self.top = try dataStream.read(endianess: .littleEndian)
        
        /// Left (4 bytes): A signed integer that specifies, in HIMETRIC units, a distance to the right of the reference point.
        self.left = try dataStream.read(endianess: .littleEndian)
    }
}
