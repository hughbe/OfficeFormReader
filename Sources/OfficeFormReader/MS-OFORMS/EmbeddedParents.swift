//
//  EmbeddedParents.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

/// [MS-OFORMS] 2.1.2.2.2 Embedded Parents
/// Embedded controls that can contain other embedded controls are each persisted to a separate storage within the same storage as the
/// parent control. The name of this storage MUST be "in", where n is the value of the ID property of the control. The value of ID is specified
/// by the parent control. The value of n is the decimal representation of ID. Values of ID less than 10 MUST be preceded by a leading zero
/// when used as part of the storage name. Values of ID greater than 10 MUST NOT be preceded by a leading zero.
internal func getEmbeddedParentStorageName(site: OleSiteConcreteControl) -> String {
    let id = site.dataBlock.id ?? 0x00000000
    if id < 10 {
        return "i0\(id)"
    } else {
        return "i\(id)"
    }
}
