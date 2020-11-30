//
//  ClassInfoDataBlock.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream
import OleAutomationDataTypes

/// [MS-OFORMS] 2.2.10.10.3 ClassInfoDataBlock
/// Specifies the properties of the type information of the embedded control that are 4 bytes or smaller and are not set to the file format defaults.
/// If the corresponding bit in the PropMask of the SiteClassInfo that contains this ClassInfoDataBlock is set to zero, the field MUST NOT be
/// stored in the file.
public struct ClassInfoDataBlock {
    public let classTableFlags: CLSTABLE_FLAGS?
    public let varFlags: VARFLAGS?
    public let countOfMethods: UInt32?
    public let dispidBind: UInt32?
    public let getBindIndex: UInt16?
    public let putBindIndex: UInt16?
    public let bindType: UInt16?
    public let getValueIndex: UInt16?
    public let putValueIndex: UInt16?
    public let valueType: UInt16?
    public let dispidRowset: UInt32?
    public let setRowset: UInt16?
    
    public init(dataStream: inout DataStream, mask: ClassInfoPropMask) throws {
        let startPosition = dataStream.position
        
        /// ClassTableFlags (2 bytes): A CLSTABLE_FLAGS that specifies Boolean properties of the type information.
        /// The file format default is 0x0000.
        if mask.fClassFlags {
            self.classTableFlags = try CLSTABLE_FLAGS(dataStream: &dataStream)
        } else {
            self.classTableFlags = nil
        }
        
        /// VarFlags (2 bytes): A VARFLAGS, as specified in [MS-OAUT] section 2.2.18, that specifies Boolean properties of the type information.
        /// The file format default is 0x0000.
        if mask.fClassFlags {
            self.varFlags = VARFLAGS(rawValue: try dataStream.read(endianess: .littleEndian))
        } else {
            self.varFlags = nil
        }
        
        /// CountOfMethods (4 bytes): An unsigned integer that specifies the number of methods on the default dual interface of the type
        /// information.
        /// The file format default is 0x00000000.
        if mask.fCountOfMethods {
            self.countOfMethods = try dataStream.read(endianess: .littleEndian)
        } else {
            self.countOfMethods = nil
        }
        
        /// DispidBind (4 bytes): An unsigned integer that specifies the IDispatch identifier (DispID) of the default bindable property, as
        /// specified in [MS-OAUT] section 2.2.49.5.2, in this type information.
        /// The value of this field is the memid field of the VARDESC of the function, as specified in [MSOAUT] section 2.2.43. The
        /// VARDESC.wVarFlags field MUST be set to 0x00000014, or FUNCFLAG_FBINDABLE and FUNCFLAG_FDISPLAYBIND, as
        /// specified in [MS-OAUT] section 2.2.11.
        /// The file format default is 0xFFFFFFFF, DISPID_UNKNOWN.
        if mask.fDispidBind {
            self.dispidBind = try dataStream.read(endianess: .littleEndian)
        } else {
            self.dispidBind = nil
        }
        
        /// GetBindIndex (2 bytes): An unsigned integer that specifies the index of the "get" function of the default bindable property, as
        /// specified in [MS-OAUT] section 2.2.49.5.2, into the dynamic virtual table of a type information that implements a dual interface.
        /// The value of this field is the oVft field of the FUNCDESC that specifies the function, as specified in [MS-OAUT] section 2.2.42.
        /// The memid field of this FUNCDESC MUST NOT be set to DISPID_VALUE, as specified in [MS-OAUT] section 2.2.32.1. The invkind
        /// field of this FUNCDESC MUST be set to INVOKE_PROPERTYGET, as specified in [MS-OAUT] section 2.2.14.
        /// The file format default is 0x0000.
        if mask.fGetBindIndex {
            self.getBindIndex = try dataStream.read(endianess: .littleEndian)
        } else {
            self.getBindIndex = nil
        }
        
        /// PutBindIndex (2 bytes): An unsigned integer that specifies the index of the "put" function of the default bindable property, as
        /// specified in [MS-OAUT] section 2.2.49.5.2, into the dynamic virtual table of a type information that implements a dual interface.
        /// The value of this field is the oVft field of the FUNCDESC that specifies the function, as specified in [MS-OAUT] section 2.2.42.
        /// The memid field of this FUNCDESC MUST NOT be set to DISPID_VALUE, as specified in [MS-OAUT] section 2.2.32.1. The invkind
        /// field of this FUNCDESC MUST be set to INVOKE_PROPERTYPUT, as specified in [MS-OAUT] section 2.2.14.
        /// The file format default is 0x0000.
        if mask.fPutBindIndex {
            self.putBindIndex = try dataStream.read(endianess: .littleEndian)
        } else {
            self.putBindIndex = nil
        }
        
        /// BindType (2 bytes): A variant type that specifies the type of the default bindable property, as specified in [MS-OAUT] section
        /// 2.2.49.5.2. The value of this field is the vt field of the TYPEDESC, as specified in [MS-OAUT] section 2.2.37, of the
        /// FUNCDESC.elemdescFunc, as specified in [MSOAUT] section 2.2.42, of the function referenced by GetBindIndex or
        /// PutBindIndex in this ClassInfoDataBlock.
        /// The file format default is 0x0000, VT_EMPTY.
        if mask.fBindType {
            self.bindType = try dataStream.read(endianess: .littleEndian)
        } else {
            self.bindType = nil
        }
        
        /// GetValueIndex (2 bytes): An unsigned integer that specifies the index of the function that retrieves the value of the control into the
        /// dynamic virtual table of the class. The value of this field is the oVft field of the FUNCDESC that specifies the function, as specified
        /// in [MS-OAUT] section 2.2.42. The memid of the FUNCDESC MUST be set to DISPID_VALUE, as specified in [MS-OAUT] section
        /// 2.2.32.1. The invkind field of the FUNCDESC MUST be set to INVOKE_PROPERTYGET, as specified in [MS-OAUT] section 2.2.14.
        /// The file format default is 0x0000.
        if mask.fGetValueIndex {
            self.getValueIndex = try dataStream.read(endianess: .littleEndian)
        } else {
            self.getValueIndex = nil
        }
        
        /// PutValueIndex (2 bytes): An unsigned integer that specifies the index of the function that sets the value of the control into the
        /// dynamic virtual table of the class. The value of this field is the oVft field of the FUNCDESC that specifies the function, as specified
        /// in [MS-OAUT] section 2.2.42. The memid of the FUNCDESC MUST be set to DISPID_VALUE, as specified in [MS-OAUT] section
        /// 2.2.32.1. The invkind field of the FUNCDESC MUST be set to INVOKE_PROPERTYPUT, as specified in [MS-OAUT] section 2.2.14.
        /// The file format default is 0x0000.
        if mask.fPutValueIndex {
            self.putValueIndex = try dataStream.read(endianess: .littleEndian)
        } else {
            self.putValueIndex = nil
        }
        
        /// ValueType (2 bytes): A variant type that specifies the type of the value that is returned in response to DISPID_VALUE. The value of
        /// this field is the vt field of the TYPEDESC, as specified in [MSOAUT] section 2.2.37, of the FUNCDESC.elemdescFunc, as specified
        /// in [MS-OAUT] section 2.2.42, of the function referenced by GetValueIndex or PutValueIndex in this ClassInfoDataBlock.
        /// The file format default is 0x0000, VT_EMPTY.
        if mask.fValueType {
            self.valueType = try dataStream.read(endianess: .littleEndian)
        } else {
            self.valueType = nil
        }
        
        /// Padding1 (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes needed to align the following
        /// property, as specified by PaddingAndAlignment.
        if mask.fDispidRowset {
            try dataStream.fourByteAlign(startPosition: startPosition)
        } else if mask.fSetRowset {
            try dataStream.twoByteAlign(startPosition: startPosition)
        }
        
        /// DispidRowset (4 bytes): An unsigned integer that specifies the DispID of a property that supports a method for fetching rows
        /// sequentially, getting the data from those rows, and managing rows. The value of this field is the memid field of the FUNCDESC that
        /// specifies the property "set" method, as specified in [MS-OAUT] section 2.2.42, or of the VARDESC that specifies the property, as
        /// specified in [MS-OAUT] section 2.2.43. The value of memid can be determined by the algorithm specified in section 2.6.1.1.
        /// The file format default is 0xFFFFFFFF, DISPID_UNKNOWN.
        if mask.fDispidRowset {
            self.dispidRowset = try dataStream.read(endianess: .littleEndian)
        } else {
            self.dispidRowset = nil
        }
        
        /// SetRowset (2 bytes): An unsigned integer that specifies the index of the "set" function into the dynamic virtual table of the class,
        /// for a property that supports a method for fetching rows sequentially, getting the data from those rows, and managing rows. The
        /// value of this field is the oVft field of the FUNCDESC that specifies the property "set" method, as specified in [MS-OAUT]
        /// section 2.2.42. The value of oVft can be determined by the algorithm specified in section 2.6.1.2.
        /// The file format default is 0x0000.
        if mask.fSetRowset {
            self.setRowset = try dataStream.read(endianess: .littleEndian)
        } else {
            self.setRowset = nil
        }
        
        /// Padding2 (variable): MUST be set to zero. The size of this field is the least number of bytes required to make the total size, in bytes,
        /// of this ClassInfoDataBlock divisible by 4.
        try dataStream.fourByteAlign(startPosition: startPosition)
    }
}
