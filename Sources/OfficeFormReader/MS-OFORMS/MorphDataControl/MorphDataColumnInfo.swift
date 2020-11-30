//
//  MorphDataColumnInfo.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.5.6 MorphDataColumnInfo
/// Specifies the width of a column in a ComboBox or ListBox control.
public struct MorphDataColumnInfo {
    public let minorVersion: UInt8
    public let majorVersion: UInt8
    public let cbColumnInfo: UInt16
    public let propMask: MorphDataColumnInfoPropMask
    public let dataBlock: MorphDataColumnInfoDataBlock
    
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
        
        /// cbColumnInfo (2 bytes): An unsigned integer that specifies the sum of the sizes, in bytes, of PropMask and DataBlock.
        self.cbColumnInfo = try dataStream.read()
        guard self.cbColumnInfo >= 4 else {
            throw OfficeFormFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// PropMask (4 bytes): A MorphDataColumnInfoPropMask that specifies whether the Width property of the column is not set to the
        /// file format default.
        self.propMask = try MorphDataColumnInfoPropMask(dataStream: &dataStream)
        
        /// DataBlock (variable): A MorphDataColumnInfoDataBlock that specifies the value of the Width property of the column when it is not
        /// set to the file format default.
        self.dataBlock = try MorphDataColumnInfoDataBlock(dataStream: &dataStream, mask: self.propMask)
        
        guard dataStream.position - startPosition == self.cbColumnInfo else {
            throw OfficeFormFileError.corrupted
        }
    }
}
