//
//  TabStripControl.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.9.1 TabStripControl
/// Specifies the structure of the control as persisted to a stream.
public struct TabStripControl {
    public let minorVersion: UInt8
    public let majorVersion: UInt8
    public let cbTabStrip: UInt16
    public let propMask: TabStripPropMask
    public let dataBlock: TabStripDataBlock
    public let extraDataBlock: TabStripExtraDataBlock
    public let streamData: TabStripStreamData
    public let textProps: TextProps
    public let tabStripTabFlags: TabStripTabFlagData
    
    public init(dataStream: inout DataStream) throws {
        /// MinorVersion (1 byte): An unsigned integer that specifies the minor version of the control. MUST be set to 0x00.
        self.minorVersion = try dataStream.read()
        guard self.minorVersion == 0x00 else {
            throw OfficeFormFileError.corrupted
        }
        
        /// MajorVersion (1 byte): An unsigned integer that specifies the major version of the control. MUST be set to 0x02.
        self.majorVersion = try dataStream.read()
        guard self.majorVersion == 0x02 else {
            throw OfficeFormFileError.corrupted
        }
        
        /// cbTabStrip (2 bytes): An unsigned integer that specifies the sum of the sizes, in bytes, of PropMask, DataBlock and ExtraDataBlock.
        self.cbTabStrip = try dataStream.read()
        guard self.cbTabStrip >= 4 else {
            throw OfficeFormFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// PropMask (4 bytes): A TabStripPropMask that specifies which properties of the control are not set to the file format default.
        self.propMask = try TabStripPropMask(dataStream: &dataStream)
        
        /// DataBlock (variable): A TabStripDataBlock that specifies the properties of the control that are 4 bytes or smaller and are not set to the
        /// file format defaults.
        self.dataBlock = try TabStripDataBlock(dataStream: &dataStream, mask: self.propMask)
        
        /// ExtraDataBlock (variable): A TabStripExtraDataBlock that specifies the properties of the control that are larger than 4 bytes and are not
        /// set to the file format defaults.
        self.extraDataBlock = try TabStripExtraDataBlock(dataStream: &dataStream, mask: self.propMask, data: self.dataBlock)
        
        guard dataStream.position - startPosition == self.cbTabStrip else {
            throw OfficeFormFileError.corrupted
        }
        
        /// StreamData (variable): A TabStripStreamData that specifies picture properties of the control that are not set to the file format defaults.
        self.streamData = try TabStripStreamData(dataStream: &dataStream, mask: self.propMask)
        
        /// TextProps (variable): A TextProps that specifies text-related properties of the control.
        self.textProps = try TextProps(dataStream: &dataStream)
        
        /// TabStripTabFlags (variable): A TabStripTabFlagData that specifies properties that apply to a single tab in the TabStrip.
        self.tabStripTabFlags = try TabStripTabFlagData(dataStream: &dataStream, mask: self.propMask, data: self.dataBlock)
    }
}
