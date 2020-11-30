//
//  TextColumn.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.90 TextColumn
/// A signed integer that specifies the column in a ComboBox or ListBox to display to the user. The possible values for this property are specified
/// as follows:
/// TextColumn Meaning
/// -1 Specifies that the first column that has a Width greater than zero is displayed.
/// 0 Specifies that row numbers are displayed.
/// 1 or greater Specifies the number of the column whose data is displayed.
/// The file format default is 0xFFFF, show first column with width greater than zero.
/// Applies to: ComboBox | ListBox
public struct TextColumn {
    public let value: Int16
    
    public init(dataStream: inout DataStream) throws {
        self.value = try dataStream.read(endianess: .littleEndian)
        guard self.value >= -1 else {
            throw OfficeFormFileError.corrupted
        }
    }
}
