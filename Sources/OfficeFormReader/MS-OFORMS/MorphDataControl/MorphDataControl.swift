//
//  MorphDataControl.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.5.1 MorphDataControl
/// Specifies the structure of the control as persisted to a stream.
public struct MorphDataControl {
    public let minorVersion: UInt8
    public let majorVersion: UInt8
    public let cbMorphData: UInt16
    public let propMask: MorphDataPropMask
    public let dataBlock: MorphDataDataBlock
    public let extraDataBlock: MorphDataExtraDataBlock
    public let streamData: MorphDataStreamData
    public let textProps: TextProps
    public let rgColumnInfo: [MorphDataColumnInfo]
    
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
        
        /// cbMorphData (2 bytes): An unsigned integer that specifies the sum of the sizes, in bytes, of PropMask, DataBlock, and ExtraDataBlock.
        self.cbMorphData = try dataStream.read(endianess: .littleEndian)
        guard self.cbMorphData >= 8 else {
            throw OfficeFormFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// PropMask (8 bytes): A MorphDataPropMask that specifies which properties of the control are not set to the file format default.
        self.propMask = try MorphDataPropMask(dataStream: &dataStream)
        
        /// DataBlock (variable): A MorphDataDataBlock that specifies the properties of the control that are 4 bytes or smaller and are not set
        /// to the file format defaults.
        self.dataBlock = try MorphDataDataBlock(dataStream: &dataStream, mask: self.propMask)
        
        /// ExtraDataBlock (variable): A MorphDataExtraDataBlock that specifies the properties of the control that are larger than 4 bytes and
        /// are not set to the file format defaults.
        self.extraDataBlock = try MorphDataExtraDataBlock(dataStream: &dataStream, mask: self.propMask, data: self.dataBlock)
        
        guard dataStream.position - startPosition == self.cbMorphData else {
            throw OfficeFormFileError.corrupted
        }
        
        /// StreamData (variable): A MorphDataStreamData that specifies picture properties of the control that are not set to the file format
        /// defaults.
        self.streamData = try MorphDataStreamData(dataStream: &dataStream, mask: self.propMask)
        
        /// TextProps (variable): A TextProps that specifies text-related properties of the control.
        self.textProps = try TextProps(dataStream: &dataStream)
        
        /// rgColumnInfo (variable): An array of MorphDataColumnInfo. Specifies the width of columns in ComboBox and ListBox controls.
        /// MUST NOT exist for other types of controls. The number of elements in this array MUST be equal to the value of the cColumnInfo
        /// property.
        if let cColumnInfo = self.dataBlock.cColumnInfo {
            var rgColumnInfo: [MorphDataColumnInfo] = []
            rgColumnInfo.reserveCapacity(Int(cColumnInfo))
            for _ in 0..<cColumnInfo {
                rgColumnInfo.append(try MorphDataColumnInfo(dataStream: &dataStream))
            }
            
            self.rgColumnInfo = rgColumnInfo
        } else {
            self.rgColumnInfo = []
        }
    }
}
