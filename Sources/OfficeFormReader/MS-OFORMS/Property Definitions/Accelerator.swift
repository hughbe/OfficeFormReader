//
//  Accelerator.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.1 Accelerator
/// A Unicode character that specifies the accelerator key for the control.
/// The file format default is 0x0000, no accelerator.
/// Applies to: CheckBox | CommandButton | Label | OptionButton | TabStrip | ToggleButton
public struct Accelerator {
    public let value: Character
    
    public init(dataStream: inout DataStream) throws {
    
        guard let scalar = Unicode.Scalar(try dataStream.read(endianess: .littleEndian) as UInt16) else {
            throw OfficeFormFileError.corrupted
        }

        self.value = Character(scalar)
    }
}
