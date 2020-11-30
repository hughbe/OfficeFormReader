//
//  ObjectData.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import CompoundFileReader
import DataStream

/// [MS-OFORMS] 2.1.2.2.1 Object Stream
/// Embedded controls that cannot themselves contain other embedded controls are persisted sequentially as FormEmbeddedActiveXControls to
/// a stream contained in the same storage as the parent control. The name of this stream MUST be "o". The order in which they are persisted is
/// specified by the order of SiteData.Sites in the FormControl of the parent, as specified in section 2.2.10.6. If a parent control contains no
/// embedded controls or only embedded controls that are also parent controls, this stream MUST still exist and MUST be empty.
public struct ObjectData {
    public let embeddedControls: [FormEmbeddedActiveXControls]
    
    public init(dataStream: inout DataStream, storage: CompoundFileStorage, siteData: FormSiteData, count: Int) throws {
        let startPosition = dataStream.position
        
        var embeddedControls: [FormEmbeddedActiveXControls] = []
        for site in siteData.sites {
            embeddedControls.append(try FormEmbeddedActiveXControls(dataStream: &dataStream, storage: storage, site: site, classTable: siteData.classTable))
        }
        
        self.embeddedControls = embeddedControls
        
        guard dataStream.position - startPosition == count else {
            throw OfficeFormFileError.corrupted
        }
    }
}
