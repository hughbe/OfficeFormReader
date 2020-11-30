//
//  FormScrollBarFlags.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.73.1 FormScrollBarFlags
/// A bit field that specifies the location of the scroll bars of a form.
public struct FormScrollBarFlags {
    public let fScrollBarsHorizontal: Bool
    public let fScrollBarsVertical: Bool
    public let fScrollBarsKeepHorizontal: Bool
    public let fScrollBarsKeepVertical: Bool
    public let fScrollBarsKeepLeft: Bool
    public let unused: UInt8
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fScrollBarsHorizontal (1 bit): Specifies whether the horizontal scroll bar is displayed.
        self.fScrollBarsHorizontal = flags.readBit()
        
        /// B - fScrollBarsVertical (1 bit): Specifies whether the vertical scroll bar is displayed.
        self.fScrollBarsVertical = flags.readBit()
        
        /// C - fScrollBarsKeepHorizontal (1 bit): Specifies whether to display the horizontal scroll bar at all times, even when all controls are
        /// visible without scrolling.
        self.fScrollBarsKeepHorizontal = flags.readBit()
        
        /// D - fScrollBarsKeepVertical (1 bit): Specifies whether to display the vertical scroll bar at all times, even when all controls are visible
        /// without scrolling.
        self.fScrollBarsKeepVertical = flags.readBit()
        
        /// E - fScrollBarsKeepLeft (1 bit): Specifies whether to display the vertical scroll bar on the left side of the form.
        self.fScrollBarsKeepLeft = flags.readBit()
        
        /// F - Unused (3 bits): MUST be set to zero.
        self.unused = flags.readRemainingBits()
    }
}
