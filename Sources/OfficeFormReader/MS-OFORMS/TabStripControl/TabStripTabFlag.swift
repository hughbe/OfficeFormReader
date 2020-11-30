//
//  TabStripTabFlag.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.9.7 TabStripTabFlag
/// Specifies whether a tab is visible and whether it is enabled.
public struct TabStripTabFlag {
    public let fTabVisible: Bool
    public let fTabEnabled: Bool
    public let unused: UInt32
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fTabVisible (1 bit): Specifies whether the tab is visible.
        self.fTabVisible = flags.readBit()
        
        /// B - fTabEnabled (1 bit): Specifies whether the tab is enabled.
        self.fTabEnabled = flags.readBit()
        
        /// Unused (30 bits): MUST be set to zero.
        self.unused = flags.readRemainingBits()
    }
}
