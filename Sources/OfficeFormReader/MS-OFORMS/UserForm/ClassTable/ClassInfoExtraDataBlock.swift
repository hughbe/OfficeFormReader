//
//  ClassInfoExtraDataBlock.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream
import WindowsDataTypes

/// [MS-OFORMS] 2.2.10.10.5 ClassInfoExtraDataBlock
/// Specifies the properties of the class that are larger than 4 bytes and are not set to the file format defaults. If the corresponding bit in the
/// PropMask of the SiteClassInfo that contains this ClassInfoDataBlock is set to zero, the field MUST NOT be stored in the file.
public struct ClassInfoExtraDataBlock {
    public let clsid: GUID?
    public let dispEvent: GUID?
    public let defaultProg: GUID?
    
    public init(dataStream: inout DataStream, mask: ClassInfoPropMask, data: ClassInfoDataBlock) throws {
        /// ClsID (16 bytes): A GUID, as specified in [MS-DTYP], that specifies the CLSID of a control.
        /// The file format default is {00000000-0000-0000-0000-000000000000}.
        if mask.fClsID {
            self.clsid = try GUID(dataStream: &dataStream)
        } else {
            self.clsid = nil
        }
        
        /// DispEvent (16 bytes): A GUID, as specified in [MS-DTYP], that specifies the source interface, as specified in [MS-OAUT]
        /// section 2.2.49.8, in this type information.
        /// The file format default is {00020400-0000-0000-C000-000000000046}.
        if mask.fDispEvent {
            self.dispEvent = try GUID(dataStream: &dataStream)
        } else {
            self.dispEvent = nil
        }
        
        /// DefaultProg (16 bytes): A GUID, as specified in [MS-DTYP], that specifies the default interface, as specified in [MS-OAUT]
        /// section 2.2.49.8, in this type information.
        /// The file format default is {00020400-0000-0000-C000-000000000046}.
        if mask.fDefaultProg {
            self.defaultProg = try GUID(dataStream: &dataStream)
        } else {
            self.defaultProg = nil
        }
    }
}
