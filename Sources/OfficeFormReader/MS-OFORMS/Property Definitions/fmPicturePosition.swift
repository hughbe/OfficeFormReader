//
//  fmPicturePosition.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.64.1 fmPicturePosition
/// The following table specifies the values of this enumeration and their meanings.
public enum fmPicturePosition: UInt32 {
    /// fmPicturePositionLeftTop 0x00020000 The picture appears to the left of the caption. The caption is aligned with the top of the picture.
    case leftTop = 0x00020000
    
    /// fmPicturePositionLeftCenter 0x00050003 The picture appears to the left of the caption. The caption is centered relative to the picture.
    case leftCenter = 0x00050003
    
    /// fmPicturePositionLeftBottom 0x00080006 The picture appears to the left of the caption. The caption is aligned with the bottom of the picture.
    case leftbottom = 0x00080006
    
    /// fmPicturePositionRightTop 0x00000002 The picture appears to the right of the caption. The caption is aligned with the top of the picture.
    case rightTop = 0x00000002
    
    /// fmPicturePositionRightCenter 0x00030005 The picture appears to the right of the caption. The caption is centered relative to the picture.
    case rightCenter = 0x00030005
    
    /// fmPicturePositionRightBottom 0x00060008 The picture appears to the right of the caption. The caption is aligned with the bottom of
    /// the picture.
    case rightBottom = 0x00060008
    
    /// fmPicturePositionAboveLeft 0x00060000 The picture appears above the caption. The caption is aligned with the left edge of the picture.
    case aboveLeft = 0x00060000
    
    /// fmPicturePositionAboveCenter 0x00070001 The picture appears above the caption. The caption is centered below the picture.
    case aboveCenter = 0x00070001
    
    /// fmPicturePositionAboveRight 0x00080002 The picture appears above the caption. The caption is aligned with the right edge of the picture.
    case aboveRight = 0x00080002
    
    /// fmPicturePositionBelowLeft 0x00000006 The picture appears below the caption. The caption is aligned with the left edge of the picture.c
    case belowLeft = 0x00000006
    
    /// fmPicturePositionBelowCenter 0x00010007 The picture appears below the caption. The caption is centered above the picture.
    case belowCenter = 0x00010007
    
    /// fmPicturePositionBelowRight 0x00020008 The picture appears below the caption. The caption is aligned with the right edge of the picture.
    case belowRight = 0x00020008
    
    /// fmPicturePositionCenter 0x00040004 The picture appears in the center of the control. The caption is centered horizontally and vertically
    /// above the picture.
    case center = 0x00040004
    
    public init(dataStream: inout DataStream) throws {
        guard let value = Self(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFormFileError.corrupted
        }
        
        self = value
    }
}
