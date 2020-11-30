//
//  SpinButtonDataBlock.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.8.3 SpinButtonDataBlock
/// Specifies the properties of the control that are 4 bytes or smaller and are not set to the file format defaults. If the corresponding bit in the PropMask
/// of the SpinButtonControl that contains this SpinButtonDataBlock is set to zero, the property value MUST NOT be stored in the file.
public struct SpinButtonDataBlock {
    public let foreColor: OLE_COLOR?
    public let backColor: OLE_COLOR?
    public let variousPropertyBits: VariousPropertiesBitfield?
    public let min: Int32?
    public let max: Int32?
    public let position: Int32?
    public let prevEnabled: Int32?
    public let nextEnabled: Int32?
    public let smallChange: Int32?
    public let orientation: fmOrientation?
    public let delay: Int32?
    public let mouseIcon: UInt16?
    public let mousePointer: UInt8?
    
    public init(dataStream: inout DataStream, mask: SpinButtonPropMask) throws {
        let startPosition = dataStream.position
        
        /// ForeColor (4 bytes): An OLE_COLOR that specifies the value of the ForeColor property.
        if mask.fForeColor {
            self.foreColor = try OLE_COLOR(dataStream: &dataStream)
        } else {
            self.foreColor = nil
        }
        
        /// BackColor (4 bytes): An OLE_COLOR that specifies the value of the BackColor property.
        if mask.fBackColor {
            self.backColor = try OLE_COLOR(dataStream: &dataStream)
        } else {
            self.backColor = nil
        }
        
        /// VariousPropertyBits (4 bytes): A VariousPropertiesBitfield that specifies the value of the VariousPropertyBits properties.
        if mask.fVariousPropertyBits {
            self.variousPropertyBits = try VariousPropertiesBitfield(dataStream: &dataStream)
        } else {
            self.variousPropertyBits = nil
        }
        
        /// Min (4 bytes): A signed integer that specifies the value of the Min property.
        if mask.fMin {
            self.min = try dataStream.read(endianess: .littleEndian)
        } else {
            self.min = nil
        }
        
        /// Max (4 bytes): A signed integer that specifies the value of the Max property.
        if mask.fMax {
            self.max = try dataStream.read(endianess: .littleEndian)
        } else {
            self.max = nil
        }
        
        /// Position (4 bytes): A signed integer that specifies the value of the Position property.
        if mask.fPosition {
            self.position = try dataStream.read(endianess: .littleEndian)
        } else {
            self.position = nil
        }
        
        /// PrevEnabled (4 bytes): A signed integer that specifies the value of the PrevEnabled property.
        if mask.fPrevEnabled {
            self.prevEnabled = try dataStream.read(endianess: .littleEndian)
        } else {
            self.prevEnabled = nil
        }
        
        /// NextEnabled (4 bytes): A signed integer that specifies the value of the NextEnabled property.
        if mask.fNextEnabled {
            self.nextEnabled = try dataStream.read(endianess: .littleEndian)
        } else {
            self.nextEnabled = nil
        }
        
        /// SmallChange (4 bytes): A signed integer that specifies the value of the SmallChange property.
        if mask.fSmallChange {
            self.smallChange = try dataStream.read(endianess: .littleEndian)
        } else {
            self.smallChange = nil
        }
        
        /// Orientation (4 bytes): An fmOrientation that specifies the value of the Orientation property.
        if mask.fOrientation {
            self.orientation = try fmOrientation(dataStream: &dataStream)
        } else {
            self.orientation = nil
        }
        
        /// Delay (4 bytes): An unsigned integer that specifies the value of the Delay property.
        if mask.fDelay {
            self.delay = try dataStream.read(endianess: .littleEndian)
        } else {
            self.delay = nil
        }
        
        /// MouseIcon (2 bytes): MUST be set to 0xFFFF when the PropMask.fMouseIcon of the SpinButtonControl that contains this
        /// SpinButtonDataBlock is set to 1. Not present when PropMask.fMouseIcon is set to zero.
        if mask.fMouseIcon {
            self.mouseIcon = try dataStream.read(endianess: .littleEndian)
            guard self.mouseIcon == 0xFFFF else {
                throw OfficeFormFileError.corrupted
            }
        } else {
            self.mouseIcon = nil
        }
        
        /// MousePointer (1 byte): An unsigned integer that specifies the value of the MousePointer property.
        if mask.fMousePointer {
            self.mousePointer = try dataStream.read()
        } else {
            self.mousePointer = nil
        }
        
        /// Padding (variable): MUST be set to zero. The size of this field is the least number of bytes required to make the total size, in bytes, of this
        /// SpinButtonDataBlock divisible by 4.
        try dataStream.fourByteAlign(startPosition: startPosition)
    }
}
