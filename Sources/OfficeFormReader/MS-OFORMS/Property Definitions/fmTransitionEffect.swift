//
//  fmTransitionEffect.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.93.1 fmTransitionEffect
/// The following table specifies the values of this enumeration and their meanings.
public enum fmTransitionEffect: UInt32 {
    /// fmTransitionEffectNone 0x00000000 No transition effect.
    case none = 0x00000000
    
    /// fmTransitionEffectCoverUp 0x00000001 Cover up transition effect.
    case coverUp = 0x00000001
    
    /// fmTransitionEffectCoverRightUp 0x00000002 Cover right-up transition effect.
    case coverRightUp = 0x00000002
    
    /// fmTransitionEffectCoverRight 0x00000003 Cover right transition effect.
    case coverRight = 0x00000003
    
    /// fmTransitionEffectCoverRightDown 0x00000004 Cover right-down transition effect.
    case coverRightDown = 0x00000004
    
    /// fmTransitionEffectCoverDown 0x00000005 Cover down transition effect.
    case coverDown = 0x00000005
    
    /// fmTransitionEffectCoverLeftDown 0x00000006 Cover left-down transition effect.
    case coverLeftDown = 0x00000006
    
    /// fmTransitionEffectCoverLeft 0x00000007 Cover left transition effect.
    case coverLeft = 0x00000007
    
    /// fmTransitionEffectCoverLeftUp 0x00000008 Cover left-up transition effect.
    case coverLeftUp = 0x00000008
    
    /// fmTransitionEffectPushUp 0x00000009 Push up transition effect.
    case pushUp = 0x00000009
    
    /// fmTransitionEffectPushRight 0x0000000A Push right transition effect.
    case pushRight = 0x0000000A
    
    /// fmTransitionEffectPushDown 0x0000000B Push down transition effect.
    case pushDown = 0x0000000B
    
    /// fmTransitionEffectPushLeft 0x0000000C Push left transition effect.
    case pushLeft = 0x0000000C
    
    public init(dataStream: inout DataStream) throws {
        guard let value = Self(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFormFileError.corrupted
        }
        
        self = value
    }
}
