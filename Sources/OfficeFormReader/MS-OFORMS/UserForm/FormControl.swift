//
//  FormControl.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.10.1 FormControl
/// Specifies the structure of the control as persisted to a stream.
public struct FormControl {
    public let minorVersion: UInt8
    public let majorVersion: UInt8
    public let cbForm: UInt16
    public let propMask: FormPropMask
    public let dataBlock: FormDataBlock
    public let extraDataBlock: FormExtraDataBlock
    public let streamData: FormStreamData
    public let siteData: FormSiteData
    public let designExData: FormDesignExData
    
    public init(dataStream: inout DataStream) throws {
        /// MinorVersion (1 byte): An unsigned integer that specifies the minor version of the control. MUST be set to 0x00.
        self.minorVersion = try dataStream.read()
        guard self.minorVersion == 0x00 else {
            throw OfficeFormFileError.corrupted
        }
        
        /// MajorVersion (1 byte): An unsigned integer that specifies the major version of the control. MUST be set to 0x04.
        self.majorVersion = try dataStream.read()
        guard self.majorVersion == 0x04 else {
            throw OfficeFormFileError.corrupted
        }
        
        /// cbForm (2 bytes): An unsigned integer that specifies the sum of the sizes, in bytes, of PropMask, DataBlock and ExtraDataBlock.
        self.cbForm = try dataStream.read(endianess: .littleEndian)
        guard self.cbForm >= 4 else {
            throw OfficeFormFileError.corrupted
        }
        
        let startPosition1  = dataStream.position
        
        /// PropMask (4 bytes): A FormPropMask that specifies which properties of the control are not set to the file format default.
        self.propMask = try FormPropMask(dataStream: &dataStream)
        
        /// DataBlock (variable): A FormDataBlock that specifies the properties of the control that are 4 bytes or smaller and are not set to the
        /// file format defaults.
        self.dataBlock = try FormDataBlock(dataStream: &dataStream, mask: self.propMask)
        
        /// ExtraDataBlock (variable): A FormExtraDataBlock that specifies the properties of the control that are larger than 4 bytes and are not
        /// set to the file format defaults.
        self.extraDataBlock = try FormExtraDataBlock(dataStream: &dataStream, mask: self.propMask, data: self.dataBlock)
        
        guard dataStream.position - startPosition1 == self.cbForm else {
            throw OfficeFormFileError.corrupted
        }
        
        /// StreamData (variable): A FormStreamData that specifies font and picture properties of the control that are not set to the file format
        /// defaults.
        self.streamData = try FormStreamData(dataStream: &dataStream, mask: self.propMask)
        
        /// SiteData (variable): A FormSiteData that specifies properties of the embedded controls of a form.
        self.siteData = try FormSiteData(dataStream: &dataStream, data: self.dataBlock)
        
        /// DesignExData (variable): A FormDesignExData that specifies properties of the design surface of the form.
        self.designExData = try FormDesignExData(dataStream: &dataStream, data: self.dataBlock)
    }
}
