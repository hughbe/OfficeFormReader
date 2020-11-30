//
//  fmPictureAlignment.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.63.1 fmPictureAlignment
/// The following table specifies the values of this enumeration and their meanings.
public enum fmPictureAlignment: UInt8 {
    /// fmPictureAlignmentTopLeft 0x00 The top-left corner.
    case topLeft = 0x00
    
    /// fmPictureAlignmentTopRight 0x01 The top-right corner.
    case topRight = 0x01
    
    /// fmPictureAlignmentCenter 0x02 The center.
    case center = 0x02
    
    /// fmPictureAlignmentBottomLeft 0x03 The bottom-left corner.
    case bottomLeft = 0x03
    
    /// fmPictureAlignmentBottomRight 0x04 The bottom-right corner.
    case bottomRight = 0x04
    
    public init(dataStream: inout DataStream) throws {
        guard let value = Self(rawValue: try dataStream.read()) else {
            throw OfficeFormFileError.corrupted
        }
        
        self = value
    }
}
