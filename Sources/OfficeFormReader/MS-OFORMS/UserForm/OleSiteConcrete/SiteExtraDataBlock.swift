//
//  SiteExtraDataBlock.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.10.12.4 SiteExtraDataBlock
/// Specifies the properties of the control that are larger than 4 bytes and are not set to the file format defaults. If the corresponding bit in
/// the PropMask of the OleSiteConcrete that contains this SiteDataBlock is set to zero, the property value MUST NOT be stored in the file.
public struct SiteExtraDataBlock {
    public let name: fmString?
    public let tag: fmString?
    public let sitePosition: fmPosition?
    public let controlTipText: fmString?
    public let runtimeLicKey: fmString?
    public let controlSource: fmString?
    public let rowSource: fmString?
    
    public init(dataStream: inout DataStream, mask: SitePropMask, data: SiteDataBlock) throws {
        /// Name (variable): An fmString that specifies the value of the Name property.
        if mask.fName {
            self.name = try fmString(dataStream: &dataStream, count: data.nameData!)
        } else {
            self.name = nil
        }
        
        /// Tag (variable): An fmString that specifies the value of the Tag property.
        if mask.fTag {
            self.tag = try fmString(dataStream: &dataStream, count: data.tagData!)
        } else {
            self.tag = nil
        }
        
        /// SitePosition (8 bytes): An fmPosition that specifies the value of the Position property.
        if mask.fPosition {
            self.sitePosition = try fmPosition(dataStream: &dataStream)
        } else {
            self.sitePosition = nil
        }
        
        /// ControlTipText (variable): An fmString that specifies the value of the Tooltip property.
        if mask.fControlTipText {
            self.controlTipText = try fmString(dataStream: &dataStream, count: data.controlTipTextData!)
        } else {
            self.controlTipText = nil
        }
        
        /// RuntimeLicKey (variable): An fmString that specifies the value of the RuntimeLicKey property.
        if mask.fRuntimeLicKey {
            self.runtimeLicKey = try fmString(dataStream: &dataStream, count: data.runtimeLicKeyData!)
        } else {
            self.runtimeLicKey = nil
        }
        
        /// ControlSource (variable): An fmString that specifies the value of the ControlSource property.
        if mask.fControlSource {
            self.controlSource = try fmString(dataStream: &dataStream, count: data.controlSourceData!)
        } else {
            self.controlSource = nil
        }
        
        /// RowSource (variable): An fmString that specifies the value of the RowSource property
        if mask.fRowSource {
            self.rowSource = try fmString(dataStream: &dataStream, count: data.rowSourceData!)
        } else {
            self.rowSource = nil
        }
    }
}
