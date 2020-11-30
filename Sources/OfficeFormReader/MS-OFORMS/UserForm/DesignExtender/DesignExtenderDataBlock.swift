//
//  DesignExtenderDataBlock.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.10.11.3 DesignExtenderDataBlock
/// Specifies the properties of the control that are 4 bytes or smaller and are not set to the file format defaults. If the corresponding bit in the
/// PropMask of the DesignExtender that contains this DesignExtenderDataBlock is set to zero, the property value MUST NOT be stored in the file.
public struct DesignExtenderDataBlock {
    public let bitFlags: DX_MODE?
    public let gridX: Int32?
    public let gridY: Int32?
    public let clickControlMode: fmClickControlMode?
    public let dblClickControlMode: fmDblClickControlMode?
    
    public init(dataStream: inout DataStream, mask: DesignExtenderPropMask) throws {
        let startPosition = dataStream.position
        
        /// BitFlags (4 bytes): A DX_MODE that specifies the BitFlags property.
        if mask.fBitFlags {
            self.bitFlags = try DX_MODE(dataStream: &dataStream)
        } else {
            self.bitFlags = nil
        }
        
        /// GridX (4 bytes): A signed integer that specifies the value of the GridX property.
        if mask.fGridX {
            self.gridX = try dataStream.read(endianess: .littleEndian)
        } else {
            self.gridX = nil
        }
        
        /// GridY (4 bytes): A signed integer that specifies the value of the GridY property.
        if mask.fGridY {
            self.gridY = try dataStream.read(endianess: .littleEndian)
        } else {
            self.gridY = nil
        }
        
        /// ClickControlMode (1 byte): An fmClickControlMode that specifies the value of the ClickControlMode property.
        if mask.fClickControlMode {
            self.clickControlMode = try fmClickControlMode(dataStream: &dataStream)
        } else {
            self.clickControlMode = nil
        }
        
        /// DblClickControlMode (1 byte): An fmDblClickControlMode that specifies the value of the DblClickControlMode property.
        if mask.fDblClickControlMode {
            self.dblClickControlMode = try fmDblClickControlMode(dataStream: &dataStream)
        } else {
            self.dblClickControlMode = nil
        }

        /// Padding (variable): MUST be set to zero. The size of this field is the least number of bytes required to make the total size, in bytes,
        /// of this DesignExtenderDataBlock divisible by 4.
        try dataStream.fourByteAlign(startPosition: startPosition)
    }
}
