//
//  fmTabOrientation.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.85.1 fmTabOrientation
/// The following table specifies the values of this enumeration and their meanings.
public enum fmTabOrientation: UInt32 {
    /// fmTabOrientationTop 0x00000000 The tabs are above the control.
    case top = 0x00000000
    
    /// fmTabOrientationBottom 0x00000001 The tabs are below the control.
    case bottom = 0x00000001
    
    /// fmTabOrientationLeft 0x00000002 The tabs are to the left of the control.
    case left = 0x00000002
    
    /// fmTabOrientationRight 0x00000003 The tabs are to the right of the control.
    case right = 0x00000003
    
    public init(dataStream: inout DataStream) throws {
        guard let value = Self(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFormFileError.corrupted
        }
        
        self = value
    }
}
