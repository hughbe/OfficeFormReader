//
//  FontHeight.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.27 FontHeight
/// An unsigned integer that specifies the height, in twips, of the text displayed by the control that contains the TextProps to which this property
/// applies. MUST be less than or equal to 4294967.
/// The file format default is 160, an 8-point font.
/// Applies to: TextProps
public struct FontHeight {
    public let value: UInt32
    
    public init(dataStream: inout DataStream) throws {
        self.value = try dataStream.read(endianess: .littleEndian)
        guard self.value <= 4294967 else {
            throw OfficeFormFileError.corrupted
        }
    }
}
