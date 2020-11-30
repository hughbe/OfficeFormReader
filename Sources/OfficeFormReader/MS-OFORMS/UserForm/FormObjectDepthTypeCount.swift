//
//  FormObjectDepthTypeCount.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.10.7 FormObjectDepthTypeCount
/// Specifies the depth and SITE_TYPE of an embedded control. Optionally specifies a count of consecutive controls that have the same depth
/// and SITE_TYPE.
public struct FormObjectDepthTypeCount {
    public let depth: UInt8
    public let typeOrCount: UInt8
    public let fCount: Bool
    public let optionalType: SITE_TYPE?
    
    public init(dataStream: inout DataStream) throws {
        /// Depth (1 byte): An unsigned integer that specifies the depth of an embedded control, that is, how many controls exist in the
        /// hierarchy between the embedded control and the parent control.
        self.depth = try dataStream.read()
        
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// TypeOrCount (7 bits): An unsigned integer. If fCount is set to zero, this field specifies the SITE_TYPE of an embedded control.
        /// If fCount is set to 1, this field specifies the number of consecutive embedded controls of the same depth and SITE_TYPE.
        self.typeOrCount = flags.readBits(count: 7)
        
        /// A - fCount (1 bit): Specifies whether TypeOrCount is a count of consecutive embedded controls.
        self.fCount = flags.readBit()
        
        /// OptionalType (1 byte): Specifies the SITE_TYPE of TypeOrCount consecutive embedded controls when fCount is set to 1. If
        /// fCount is set to zero, this field MUST NOT be stored.
        if self.fCount {
            self.optionalType = try SITE_TYPE(dataStream: &dataStream)
        } else {
            self.optionalType = nil
        }
    }
}
