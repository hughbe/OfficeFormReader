//
//  MorphDataColumnInfoDataBlock.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.5.8 MorphDataColumnInfoDataBlock
/// Specifies the Width property of this column if it is not set to the file format default. If the value of PropMask.fColumnWidth of the
/// MorphDataColumnInfo that contains this MorphDataColumnInfoDataBlock is set to zero, the property value MUST NOT be stored in the file.
public struct MorphDataColumnInfoDataBlock {
    public let columnWidth: Int32
    
    public init(dataStream: inout DataStream, mask: MorphDataColumnInfoPropMask) throws {
        /// ColumnWidth (4 bytes): A signed integer that specifies the value of the Width property.
        self.columnWidth = try dataStream.read(endianess: .littleEndian)
    }
}
