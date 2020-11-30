//
//  FormFlags.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.6.1 FormFlags
/// A bit field that specifies Boolean properties of a form.
public struct FormFlags {
    public let unused1: UInt8
    public let enabled: Bool
    public let unused2: UInt16
    public let desinkPersisted: Bool
    public let dontSaveClassTable: Bool
    public let unused3: UInt16
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - Unused1 (2 bits): MUST be set to zero.
        self.unused1 = UInt8(flags.readBits(count: 2))
        
        /// B - FORM_FLAG_ENABLED (1 bit): Specifies whether the form is enabled.
        self.enabled = flags.readBit()
        
        /// Unused2 (11 bits): MUST be set to zero.
        self.unused2 = UInt16(flags.readBits(count: 11))
        
        /// C - FORM_FLAG_DESINKPERSISTED (1 bit): Specifies whether Design Extender properties are persisted with this form.
        self.desinkPersisted = flags.readBit()
        
        /// D - FORM_FLAG_DONTSAVECLASSTABLE (1 bit): Specifies whether the Class Table of a form is not persisted. A value of zero
        /// specifies that the Class Table is persisted if it is not empty.
        self.dontSaveClassTable = flags.readBit()
        
        /// Unused3 (16 bits): MUST be set to zero.
        self.unused3 = UInt16(flags.readRemainingBits())
    }
}
