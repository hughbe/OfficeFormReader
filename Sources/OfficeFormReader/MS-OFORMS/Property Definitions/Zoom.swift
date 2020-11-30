//
//  Zoom.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.98 Zoom
/// A signed integer that specifies the magnification of embedded controls, in percentage points of the size of the parent control. MUST be
/// greater than or equal to 10 (10 percent of actual size) and less than or equal to 400 (four times or 400 percent of actual size).
/// The file format default is 100, or actual size.
/// Applies to: Form
public struct Zoom {
    public let value: Int32
    
    public init(dataStream: inout DataStream) throws {
        self.value = try dataStream.read(endianess: .littleEndian)
        guard self.value >= 10 && self.value <= 400 else {
            throw OfficeFormFileError.corrupted
        }
    }
}
