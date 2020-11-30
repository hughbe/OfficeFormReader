//
//  fmScrollBars.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

public enum fmScrollBars: UInt8 {
    /// fmScrollBarsNone 0x00 Displays no scroll bars.
    case none = 0x00
    
    /// fmScrollBarsHorizontal 0x01 Displays a horizontal scroll bar.
    case horizontal = 0x01
    
    /// fmScrollBarsVertical 0x02 Displays a vertical scroll bar.
    case vertical = 0x02
    
    /// fmScrollBarsBoth 0x03 Displays both a horizontal and a vertical scroll bar.
    case both = 0x03
    
    public init(dataStream: inout DataStream) throws {
        guard let value = Self(rawValue: try dataStream.read()) else {
            throw OfficeFormFileError.corrupted
        }
        
        self = value
    }
}
