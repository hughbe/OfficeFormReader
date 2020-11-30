//
//  TabFixedHeight.swift
//
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.82 TabFixedHeight
/// An unsigned integer that specifies the height, in HIMETRIC units, of each tab in a TabStrip. The value applies to all tabs and MUST be less than or
/// equal to 254000.<11>
/// The file format default is 0x00000000, which specifies that the client application determines the height.
/// Applies to: TabStrip
public struct TabFixedHeight {
    public let value: UInt32
    
    public init(dataStream: inout DataStream) throws {
        self.value = try dataStream.read(endianess: .littleEndian)
        guard self.value <= 254000 else {
            throw OfficeFormFileError.corrupted
        }
    }
}
