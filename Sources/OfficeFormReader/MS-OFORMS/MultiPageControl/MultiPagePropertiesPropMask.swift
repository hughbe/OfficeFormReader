//
//  MultiPagePropertiesPropMask.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.6.2 MultiPagePropertiesPropMask
/// Specifies the properties of the control that are not set to the file format default. For each field, a value of zero specifies that the corresponding
/// property is the file format default and is not stored in the file.
public struct MultiPagePropertiesPropMask {
    public let unused1: Bool
    public let fPageCount: Bool
    public let fID: Bool
    public let fFlags: Bool
    public let unusedBits: UInt32
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - Unused1 (1 bit): MUST be set to zero.
        self.unused1 = flags.readBit()
        
        /// B - fPageCount (1 bit): Specifies whether the PageCount property is stored in the DataBlock.PageCount of the MultiPageProperties
        /// that contains this MultiPagePropertiesPropMask.
        self.fPageCount = flags.readBit()
        
        /// C - fID (1 bit): Specifies whether the ID property is stored in the DataBlock.ID of the MultiPageProperties that contains this
        /// MultiPagePropertiesPropMask.
        self.fID = flags.readBit()
        
        /// D - fFlags (1 bit): Specifies whether the value of the Flags property is not the file format default.
        self.fFlags = flags.readBit()
        
        /// UnusedBits (28 bits): MUST be set to zero.
        self.unusedBits = flags.readRemainingBits()
    }
}
