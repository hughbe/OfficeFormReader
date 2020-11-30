//
//  ColumnCount.swift
//
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.14 ColumnCount
/// A signed integer that specifies the number of columns to display in a ComboBox or ListBox. A value of –1 specifies that all columns are to
/// be displayed. MUST be in the range from –1 through 32767.
/// The file format default is 0x0001.
/// Applies to: ComboBox | ListBox
public struct ColumnCount {
    public let value: Int16
    
    public init(dataStream: inout DataStream) throws {
        self.value = try dataStream.read(endianess: .littleEndian)
        guard self.value >= -1 && self.value <= 32767 else {
            throw OfficeFormFileError.corrupted
        }
    }
}
