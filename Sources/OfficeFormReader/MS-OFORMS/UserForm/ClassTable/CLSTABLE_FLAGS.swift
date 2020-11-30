//
//  CLSTABLE_FLAGS.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.10.10.4 CLSTABLE_FLAGS
/// A bit field that specifies Boolean properties of a SiteClassInfo.
public struct CLSTABLE_FLAGS {
    public let fExclusiveValue: Bool
    public let fDualInterface: Bool
    public let fNoAggregation: Bool
    public let unused: UInt16
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fExclusiveValue (1 bit): Specifies whether the typeKind member of the TYPEATTR that describes this type information, as
        /// specified in [MS-OAUT] section 2.2.44, is set to TKIND_ALIAS, as specified in [MS-OAUT] section 2.2.17.
        self.fExclusiveValue = flags.readBit()
        
        /// B - fDualInterface (1 bit): Specifies whether this type information implements a dual interface.
        self.fDualInterface = flags.readBit()
        
        /// C - fNoAggregation (1 bit): Specifies whether this type information supports aggregation. A value of 1 specifies that the control
        /// does not support aggregation.
        self.fNoAggregation = flags.readBit()
        
        /// Unused (13 bits): MUST be set to zero.
        self.unused = flags.readRemainingBits()
    }
}
