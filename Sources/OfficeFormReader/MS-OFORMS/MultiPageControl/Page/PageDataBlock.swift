//
//  PageDataBlock.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.6.4.3 PageDataBlock
/// Specifies the properties of the Page that are not set to the file format defaults. If the corresponding field in the PropMask of the PageProperties
/// that contains this PageDataBlock is set to zero, the property value MUST NOT be stored in the file.
public struct PageDataBlock {
    public let transitionEffect: fmTransitionEffect?
    public let transitionPeriod: UInt32?
    
    public init(dataStream: inout DataStream, mask: PagePropMask) throws {
        /// TransitionEffect (4 bytes): An fmTransitionEffect that specifies the value of the TransitionEffect property.
        if mask.fTransitionEffect {
            self.transitionEffect = try fmTransitionEffect(dataStream: &dataStream)
        } else {
            self.transitionEffect = nil
        }
        
        /// TransitionPeriod (4 bytes): An unsigned integer that specifies the value of the TransitionPeriod property.
        if mask.fTransitionPeriod {
            self.transitionPeriod = try dataStream.read(endianess: .littleEndian)
        } else {
            self.transitionPeriod = nil
        }
    }
}
