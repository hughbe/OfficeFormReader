//
//  fmPictureSizeMode.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.65.1 fmPictureSizeMode
/// The following table specifies the values of this enumeration and their meanings.
public enum fmPictureSizeMode: UInt8 {
    /// fmPictureSizeModeClip 0x00 Crops any part of the picture that is larger than the control boundaries.
    case clip = 0x00
    
    /// fmPictureSizeModeStretch 0x01 Stretches the picture to fill the control area. This setting distorts the picture in either the horizontal or
    /// vertical direction.
    case stretch = 0x01
    
    /// fmPictureSizeModeZoom 0x03 Enlarges the picture, but does not distort the picture in either the horizontal or vertical direction.
    case zoom = 0x03
    
    public init(dataStream: inout DataStream) throws {
        guard let value = Self(rawValue: try dataStream.read()) else {
            throw OfficeFormFileError.corrupted
        }
        
        self = value
    }
}
