//
//  SiteDataBlock.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.10.12.3 SiteDataBlock
/// Specifies the properties of the control that are 4 bytes or smaller and are not set to the file format defaults. If the corresponding bit in
/// the PropMask of the OleSiteConcrete that contains this SiteDataBlock is set to zero, the property value MUST NOT be stored in the file.
public struct SiteDataBlock {
    public let nameData: CountOfBytesWithCompressionFlag?
    public let tagData: CountOfBytesWithCompressionFlag?
    public let id: Int32?
    public let helpContextID: Int32?
    public let bitFlags: SITE_FLAG?
    public let objectStreamSize: UInt32?
    public let tabIndex: Int16?
    public let clsidCacheIndex: UInt16?
    public let groupID: UInt16?
    public let controlTipTextData: CountOfBytesWithCompressionFlag?
    public let runtimeLicKeyData: CountOfBytesWithCompressionFlag?
    public let controlSourceData: CountOfBytesWithCompressionFlag?
    public let rowSourceData: CountOfBytesWithCompressionFlag?
    
    public init(dataStream: inout DataStream, mask: SitePropMask) throws {
        let startPosition = dataStream.position
        
        /// NameData (4 bytes): A CountOfBytesWithCompressionFlag that specifies the size and compression of the Name property.
        if mask.fName {
            self.nameData = try CountOfBytesWithCompressionFlag(dataStream: &dataStream)
        } else {
            self.nameData = nil
        }
        
        /// TagData (4 bytes): A CountOfBytesWithCompressionFlag that specifies the size and compression of the Tag property.
        if mask.fTag {
            self.tagData = try CountOfBytesWithCompressionFlag(dataStream: &dataStream)
        } else {
            self.tagData = nil
        }
        
        /// ID (4 bytes): A signed integer that specifies the value of the ID property.
        if mask.fID {
            self.id = try dataStream.read(endianess: .littleEndian)
        } else {
            self.id = nil
        }
        
        /// HelpContextID (4 bytes): A signed integer that specifies the value of the HelpContextID property.
        if mask.fHelpContextID {
            self.helpContextID = try dataStream.read(endianess: .littleEndian)
        } else {
            self.helpContextID = nil
        }
        
        /// BitFlags (4 bytes): A SITE_FLAG that specifies the value of the BitFlags property.
        if mask.fBitFlags {
            self.bitFlags = try SITE_FLAG(dataStream: &dataStream)
        } else {
            self.bitFlags = nil
        }
        
        /// ObjectStreamSize (4 bytes): An unsigned integer that specifies the value of the ObjectStreamSize property.
        if mask.fObjectStreamSize {
            self.objectStreamSize = try dataStream.read(endianess: .littleEndian)
        } else {
            self.objectStreamSize = nil
        }
        
        /// TabIndex (2 bytes): A signed integer that specifies the value of the TabIndex property.
        if mask.fTabIndex {
            self.tabIndex = try dataStream.read(endianess: .littleEndian)
        } else {
            self.tabIndex = nil
        }
        
        /// ClsidCacheIndex (2 bytes): A signed integer that specifies the value of the ClsidCacheIndex property.
        if mask.fClsidCacheIndex {
            self.clsidCacheIndex = try dataStream.read(endianess: .littleEndian)
        } else {
            self.clsidCacheIndex = nil
        }
        
        /// GroupID (2 bytes): An unsigned integer that specifies the value of the GroupID property.
        if mask.fGroupID {
            self.groupID = try dataStream.read(endianess: .littleEndian)
        } else {
            self.groupID = nil
        }
        
        /// Padding1 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fControlTipText {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// ControlTipTextData (4 bytes): A CountOfBytesWithCompressionFlag that specifies the size and compression of the Tooltip property.
        if mask.fControlTipText {
            self.controlTipTextData = try CountOfBytesWithCompressionFlag(dataStream: &dataStream)
        } else {
            self.controlTipTextData = nil
        }
        
        /// Padding2 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fRuntimeLicKey {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// RuntimeLicKeyData (4 bytes): A CountOfBytesWithCompressionFlag that specifies the size and compression of the
        /// RuntimeLicKey property.
        if mask.fRuntimeLicKey {
            self.runtimeLicKeyData = try CountOfBytesWithCompressionFlag(dataStream: &dataStream)
        } else {
            self.runtimeLicKeyData = nil
        }
        
        /// Padding3 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fControlSource {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// ControlSourceData (4 bytes): A CountOfBytesWithCompressionFlag that specifies the size and compression of the
        /// ControlSource property.
        if mask.fControlSource {
            self.controlSourceData = try CountOfBytesWithCompressionFlag(dataStream: &dataStream)
        } else {
            self.controlSourceData = nil
        }
        
        /// Padding4 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes required to align the
        /// following property, as specified by PaddingAndAlignment.
        if mask.fRowSource {
            try dataStream.fourByteAlign(startPosition: startPosition)
        }
        
        /// RowSourceData (4 bytes): A CountOfBytesWithCompressionFlag that specifies the size and compression of the RowSource property.
        if mask.fRowSource {
            self.rowSourceData = try CountOfBytesWithCompressionFlag(dataStream: &dataStream)
        } else {
            self.rowSourceData = nil
        }
        
        /// Padding5 (variable): MUST be set to zero. The size of this field is the least number of bytes required to make the total size, in
        /// bytes, of this SiteDataBlock divisible by 4.
        try dataStream.fourByteAlign(startPosition: startPosition)
    }
}
