//
//  DesignExtenderPropMask.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.10.11.2 DesignExtenderPropMask
/// Specifies the properties of the control are not set to the file format default. For each bit, a value of zero specifies that the corresponding
/// property is the file format default and is not stored in the file.
public struct DesignExtenderPropMask {
    public let fBitFlags: Bool
    public let fGridX: Bool
    public let fGridY: Bool
    public let fClickControlMode: Bool
    public let fDblClickControlMode: Bool
    public let unused: UInt32
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fBitFlags (1 bit): Specifies whether the BitFlags property is stored in the DataBlock.BitFlags of the DesignExtender that contains
        /// this DesignExtenderPropMask.
        self.fBitFlags = flags.readBit()
        
        /// B - fGridX (1 bit): Specifies whether the GridX property is stored in the DataBlock.GridX of the DesignExtender that contains this
        /// DesignExtenderPropMask.
        self.fGridX = flags.readBit()
        
        /// C - fGridY (1 bit): Specifies whether the GridY property is stored in the DataBlock.GridY of the DesignExtender that contains this
        /// DesignExtenderPropMask.
        self.fGridY = flags.readBit()
        
        /// D - fClickControlMode (1 bit): Specifies whether the ClickControlMode property is stored in the DataBlock.ClickControlMode of
        /// the DesignExtender that contains this DesignExtenderPropMask.
        self.fClickControlMode = flags.readBit()
        
        /// E - fDblClickControlMode (1 bit): Specifies whether the DblClickControlMode property is stored in the DataBlock.DblClickControlMode
        /// of the DesignExtender that contains this DesignExtenderPropMask.
        self.fDblClickControlMode = flags.readBit()
        
        /// Unused (27 bits): MUST be set to zero.
        self.unused = flags.readRemainingBits()
    }
}
