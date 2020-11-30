//
//  FontWeight.swift
//
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.30 FontWeight
/// An unsigned integer that specifies the font weight of the text displayed by the control that contains the TextProps to which this property
/// applies. The value MUST be in the range from zero through 1000. A value of zero specifies that the weight is determined by the application.
/// A value from 1 through 1000 specifies a weight, where 1 specifies the lightest type and 1000 specifies the darkest type.
/// The file format default is 400.
/// Applies to: TextProps
public struct FontWeight {
    public let value: UInt32
    
    public init(dataStream: inout DataStream) throws {
        self.value = try dataStream.read(endianess: .littleEndian)
        guard self.value >= 0 && self.value <= 1000 else {
            throw OfficeFormFileError.corrupted
        }
    }
}
