//
//  FrameControl.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import CompoundFileReader
import DataStream
import OleDataTypes

/// [MS-OFORMS] 2.2.2 Frame Control
/// A Frame control is a parent control that is persisted in binary format as specified in section 2.1.2.1.1. In other words, it consists of a FormControl
/// stored in a Form stream, with any child controls stored in an Object stream, as specified in section 2.1.2.2. If the Frame control is the child of another
/// control, it is persisted to a storage as specified in section 2.1.2.2.2, with its child objects persisted to the Object stream within the parent storage.
public struct FrameControl {
    public let formControl: FormControl
    public let objectData: ObjectData
    public let compObjStream: CompObjStream?
    public let storage: CompoundFileStorage
    
    public init(parentStorage: CompoundFileStorage, site: OleSiteConcreteControl) throws {
        var parentStorage = parentStorage
        guard let storage = parentStorage.children[getEmbeddedParentStorageName(site: site)] else {
            throw OfficeFormFileError.corrupted
        }
        
        try self.init(storage: storage)
    }
    
    public init(storage: CompoundFileStorage) throws {
        var storage = storage
        
        guard let formStorage = storage.children["f"] else {
            throw OfficeFormFileError.corrupted
        }
        
        var formDataStream = formStorage.dataStream
        self.formControl = try FormControl(dataStream: &formDataStream)
        
        guard let objectStorage = storage.children["o"] else {
            throw OfficeFormFileError.corrupted
        }
        
        var objectDataStream = objectStorage.dataStream
        self.objectData = try ObjectData(dataStream: &objectDataStream,
                                         storage: storage,
                                         siteData: self.formControl.siteData,
                                         count: objectDataStream.count)
        
        if let compObjStorage = storage.children["\u{0001}CompObj"] {
            var compObjDataStream = compObjStorage.dataStream
            self.compObjStream = try CompObjStream(dataStream: &compObjDataStream, count: compObjDataStream.count)
        } else {
            self.compObjStream = nil
        }

        self.storage = storage
    }
}
