//
//  ClassInfoPropMask.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.10.10.2 ClassInfoPropMask
/// Specifies the properties of the SiteClassInfo that contains this ClassInfoPropMask that are not set to the file format default. For each bit, a
/// value of zero specifies that the corresponding property is the file format default and is not stored in the file.
public struct ClassInfoPropMask {
    public let fClsID: Bool
    public let fDispEvent: Bool
    public let unused1: Bool
    public let fDefaultProg: Bool
    public let fClassFlags: Bool
    public let fCountOfMethods: Bool
    public let fDispidBind: Bool
    public let fGetBindIndex: Bool
    public let fPutBindIndex: Bool
    public let fBindType: Bool
    public let fGetValueIndex: Bool
    public let fPutValueIndex: Bool
    public let fValueType: Bool
    public let fDispidRowset: Bool
    public let fSetRowset: Bool
    public let unused2: UInt32
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fClsID (1 bit): Specifies whether ExtraDataBlock.ClsID is stored in the SiteClassInfo that contains this ClassInfoPropMask.
        self.fClsID = flags.readBit()

        /// B - fDispEvent (1 bit): Specifies whether ExtraDataBlock.DispEvent is stored in the SiteClassInfo that contains this ClassInfoPropMask.
        self.fDispEvent = flags.readBit()

        /// C - Unused1 (1 bit): MUST be set to zero.
        self.unused1 = flags.readBit()

        /// D - fDefaultProg (1 bit): Specifies whether ExtraDataBlock.DefaultProg is stored in the SiteClassInfo that contains this
        /// ClassInfoPropMask.
        self.fDefaultProg = flags.readBit()

        /// E - fClassFlags (1 bit): Specifies whether DataBlock.ClassTableFlags and DataBlock.VarFlags are stored in the SiteClassInfo that
        /// contains this ClassInfoPropMask.
        self.fClassFlags = flags.readBit()

        /// F - fCountOfMethods (1 bit): Specifies whether DataBlock.CountOfMethods is stored in the SiteClassInfo that contains this
        /// ClassInfoPropMask.
        self.fCountOfMethods = flags.readBit()

        /// G - fDispidBind (1 bit): Specifies whether DataBlock.DispidBind is stored in the SiteClassInfo that contains this ClassInfoPropMask.
        self.fDispidBind = flags.readBit()

        /// H - fGetBindIndex (1 bit): Specifies whether DataBlock.GetBindIndex is stored in the SiteClassInfo that contains this
        /// ClassInfoPropMask.
        self.fGetBindIndex = flags.readBit()

        /// I - fPutBindIndex (1 bit): Specifies whether DataBlock.PutBindIndex is stored in the SiteClassInfo that contains this
        /// ClassInfoPropMask.
        self.fPutBindIndex = flags.readBit()

        /// J - fBindType (1 bit): Specifies whether DataBlock.BindType is stored in the SiteClassInfo that contains this ClassInfoPropMask.
        self.fBindType = flags.readBit()

        /// K - fGetValueIndex (1 bit): Specifies whether DataBlock.GetValueIndex is stored in the SiteClassInfo that contains this
        /// ClassInfoPropMask.
        self.fGetValueIndex = flags.readBit()

        /// L - fPutValueIndex (1 bit): Specifies whether DataBlock.PutValueIndex is stored in the SiteClassInfo that contains this
        /// ClassInfoPropMask.
        self.fPutValueIndex = flags.readBit()

        /// M - fValueType (1 bit): Specifies whether DataBlock.ValueType is stored in the SiteClassInfo that contains this ClassInfoPropMask.
        self.fValueType = flags.readBit()

        /// N - fDispidRowset (1 bit): Specifies whether DataBlock.DispidRowset is stored in the SiteClassInfo that contains this
        /// ClassInfoPropMask.
        self.fDispidRowset = flags.readBit()

        /// O - fSetRowset (1 bit): Specifies whether DataBlock.SetRowset is stored in the SiteClassInfo that contains this ClassInfoPropMask.
        self.fSetRowset = flags.readBit()

        /// Unused2 (17 bits): MUST be set to zero.
        self.unused2 = flags.readRemainingBits()
    }
}
