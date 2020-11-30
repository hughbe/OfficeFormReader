//
//  fmOrientation.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.58.1 fmOrientation
/// The following table specifies the values of this enumeration and their meanings.
public enum fmOrientation: UInt32 {
    /// fmOrientationAuto 0xFFFFFFFF Control is rendered horizontally when the width of the control is greater than its height. The control is rendered
    /// vertically otherwise.
    case auto = 0xFFFFFFFF
    
    /// fmOrientationVertical 0x00000000 Control is rendered vertically.
    case vertical = 0x00000000
    
    /// fmOrientationHorizontal 0x00000001 Control is rendered horizontally.
    case horizontal = 0x00000001
    
    public init(dataStream: inout DataStream) throws {
        guard let value = Self(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFormFileError.corrupted
        }
        
        self = value
    }
}
