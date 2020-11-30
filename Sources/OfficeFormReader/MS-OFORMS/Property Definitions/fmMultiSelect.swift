//
//  fmDropButtonStyle.swift
//
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.22.1 fmDropButtonStyle
/// The following table specifies the values of this enumeration and their meanings.
public enum fmDropButtonStyle: UInt8 {
    /// fmDropButtonStylePlain 0x00 Displays a button with no symbol.
    case plain = 0x00
    
    /// fmDropButtonStyleArrow 0x01 Displays a button with a down arrow.
    case arrow = 0x01
    
    /// fmDropButtonStyleEllipsis 0x02 Displays a button with an ellipsis (...).
    case ellipsis = 0x02
    
    /// fmDropButtonStyleReduce 0x03 Displays a button with a horizontal line like an underscore character
    case reduce = 0x03
    
    public init(dataStream: inout DataStream) throws {
        guard let value = Self(rawValue: try dataStream.read()) else {
            throw OfficeFormFileError.corrupted
        }
        
        self = value
    }
}
