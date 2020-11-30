//
//  FormEmbeddedActiveXControls.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import CompoundFileReader
import DataStream

/// [MS-OFORMS] 2.4.4 FormEmbeddedActiveXControl
/// Specifies a control based on the value of a DataBlock.ClsidCacheIndex of an OleSiteConcreteControl that is referenced by a FormControl.
public struct FormEmbeddedActiveXControls {
    public let controlCached: FormEmbeddedActiveXControlCached?
    public let controlNonCached: SiteClassInfo?
    
    public init(dataStream: inout DataStream, storage: CompoundFileStorage, site: OleSiteConcreteControl, classTable: [SiteClassInfo]?) throws {
        let clsidCacheIndex = site.dataBlock.clsidCacheIndex ?? 0x7FFF
        
        /// ControlCached (variable): A FormEmbeddedActiveXControlCached that is specified by the ClsidCacheIndex property. If the
        /// value of the ClsidCacheIndex property is greater than or equal to 0x7FFF, this field MUST NOT be stored.
        if clsidCacheIndex < 0x7FFF {
            self.controlCached = try FormEmbeddedActiveXControlCached(dataStream: &dataStream, storage: storage, site: site)
        } else {
            self.controlCached = nil
        }
        
        /// ControlNonCached (variable): A control that is specified by an index into the FormSiteData.ClassTable of the FormControl that
        /// references this FormEmbeddedActiveXControl. This control MUST be able to interact through OLE Automation, as specified in
        /// [MS-OAUT]. If the value of the ClsidCacheIndex property is less than 0x8000, this field MUST NOT be stored.
        if clsidCacheIndex >= 0x8000 {
            guard let classTable = classTable, clsidCacheIndex - 0x8000 < classTable.count else {
                throw OfficeFormFileError.corrupted
            }

            self.controlNonCached = classTable[Int(clsidCacheIndex - 0x8000)]
        } else {
            self.controlNonCached = nil
        }
    }
}
