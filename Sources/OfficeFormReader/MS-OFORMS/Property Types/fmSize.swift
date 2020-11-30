//
//  fmSize.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.4.2 fmSize
/// Specifies a pair of signed integers that specify the size of a control.
public struct fmSize {
    public let width: Int32
    public let height: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// Width (4 bytes): A signed integer that specifies the width, in HIMETRIC units, of the control.
        self.width = try dataStream.read(endianess: .littleEndian)
        
        /// Height (4 bytes): A signed integer that specifies the height, in HIMETRIC units, of the control.
        self.height = try dataStream.read(endianess: .littleEndian)
    }
}
