//
//  SitePropMask.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.10.12.2 SitePropMask
/// Specifies the properties of the control are not set to the file format default. For each bit, a value of zero specifies that the corresponding
/// property is the file format default and is not stored in the file.
public struct SitePropMask {
    public let fName: Bool
    public let fTag: Bool
    public let fID: Bool
    public let fHelpContextID: Bool
    public let fBitFlags: Bool
    public let fObjectStreamSize: Bool
    public let fTabIndex: Bool
    public let fClsidCacheIndex: Bool
    public let fPosition: Bool
    public let fGroupID: Bool
    public let unused1: Bool
    public let fControlTipText: Bool
    public let fRuntimeLicKey: Bool
    public let fControlSource: Bool
    public let fRowSource: Bool
    public let unused2: UInt32
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fName (1 bit): Specifies whether the size and compression flag of the Name property are stored in the DataBlock.NameData
        /// of the OleSiteConcreteControl that contains this SitePropMask and the Name string is stored in the ExtraDataBlock.Name of
        /// the OleSiteConcreteControl.
        self.fName = flags.readBit()
        
        /// B - fTag (1 bit): Specifies whether the size and compression flag of the Tag property are stored in the DataBlock.TagData of the
        /// OleSiteConcreteControl that contains this SitePropMask and the Tag string is stored in the ExtraDataBlock.Tag of the
        /// OleSiteConcreteControl.
        self.fTag = flags.readBit()
        
        /// C - fID (1 bit): Specifies whether the ID property is stored in the DataBlock.ID of the OleSiteConcreteControl that contains this
        /// SitePropMask.
        self.fID = flags.readBit()
        
        /// D - fHelpContextID (1 bit): Specifies whether the HelpContextID property is stored in the DataBlock.HelpContextID of the
        /// OleSiteConcreteControl that contains this SitePropMask.
        self.fHelpContextID = flags.readBit()
        
        /// E - fBitFlags (1 bit): Specifies whether the BitFlags property is stored in the DataBlock.BitFlags of the OleSiteConcreteControl
        /// that contains this SitePropMask.
        self.fBitFlags = flags.readBit()
        
        /// F - fObjectStreamSize (1 bit): Specifies whether the ObjectStreamSize property is stored in the DataBlock.ObjectStreamSize of
        /// the OleSiteConcreteControl that contains this SitePropMask.
        self.fObjectStreamSize = flags.readBit()
        
        /// G - fTabIndex (1 bit): Specifies whether the TabIndex property is stored in the DataBlock.TabIndex of the OleSiteConcreteControl
        /// that contains this SitePropMask.
        self.fTabIndex = flags.readBit()
        
        /// H - fClsidCacheIndex (1 bit): Specifies whether the ClsidCacheIndex property is stored in the DataBlock.ClsidCacheIndex of the
        /// OleSiteConcreteControl that contains this SitePropMask.
        self.fClsidCacheIndex = flags.readBit()
        
        /// I - fPosition (1 bit): Specifies whether the Position property is stored in the ExtraDataBlock.Position of the OleSiteConcreteControl
        /// that contains this SitePropMask.
        self.fPosition = flags.readBit()
        
        /// J - fGroupID (1 bit): Specifies whether the GroupID property is stored in the DataBlock.GroupID of the OleSiteConcreteControl that
        /// contains this SitePropMask.
        self.fGroupID = flags.readBit()
        
        /// K - Unused1 (1 bit): MUST be set to zero.
        self.unused1 = flags.readBit()
        
        /// L - fControlTipText (1 bit): Specifies whether the size and compression flag of the Tooltip property are stored in the
        /// DataBlock.ControlTipTextData of the OleSiteConcreteControl that contains this SitePropMask and the Tooltip string is stored in the
        /// ExtraDataBlock.ControlTipText of the OleSiteConcreteControl.
        self.fControlTipText = flags.readBit()
        
        /// M - fRuntimeLicKey (1 bit): Specifies whether the size and compression flag of the RuntimeLicKey property are stored in the
        /// DataBlock.RuntimeLicKeyData of the OleSiteConcreteControl that contains this SitePropMask and the RuntimeLicKey string is
        /// stored in the ExtraDataBlock.RuntimeLicKeyData of the OleSiteConcreteControl.
        self.fRuntimeLicKey = flags.readBit()
        
        /// N - fControlSource (1 bit): Specifies whether the size and compression flag of the ControlSource property are stored in the
        /// DataBlock.ControlSourceData of the OleSiteConcreteControl that contains this SitePropMask and the ControlSource string is
        /// stored in the ExtraDataBlock.ControlSource of the OleSiteConcreteControl.
        self.fControlSource = flags.readBit()
        
        /// O - fRowSource (1 bit): Specifies whether the size and compression flag of the RowSource property are stored in the
        /// DataBlock.RowSourceData of the OleSiteConcreteControl that contains this SitePropMask and the RowSource string is stored
        /// in the ExtraDataBlock.RowSource of the OleSiteConcreteControl.
        self.fRowSource = flags.readBit()
        
        /// Unused2 (17 bits): MUST be set to zero.
        self.unused2 = flags.readRemainingBits()
    }
}
