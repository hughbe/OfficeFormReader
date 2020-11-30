//
//  PagePropMask.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.6.4.2 PagePropMask
/// Specifies the properties of the control that are not set to the file format default. For each field, a value of zero specifies that the corresponding
/// property is the file format default and is not stored in the file.
public struct PagePropMask {
    public let unused1: Bool
    public let fTransitionEffect: Bool
    public let fTransitionPeriod: Bool
    public let unusedBits: UInt32
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - Unused1 (1 bit): MUST be set to zero.
        self.unused1 = flags.readBit()
        
        /// B - fTransitionEffect (1 bit): Specifies whether the TransitionEffect property is stored in the DataBlock.TransitionEffect of the PageProperties
        /// that contains this PagePropMask.
        self.fTransitionEffect = flags.readBit()
        
        /// C - fTransitionPeriod (1 bit): Specifies whether the TransitionPeriod property is stored in the DataBlock.TransitionPeriod of the
        /// PageProperties that contains this PagePropMask.
        self.fTransitionPeriod = flags.readBit()
        
        /// UnusedBits (29 bits): MUST be set to zero.
        self.unusedBits = flags.readRemainingBits()
    }
}
