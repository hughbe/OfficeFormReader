//
//  UserForm.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import CompoundFileReader
import DataStream
import Foundation
import OleDataTypes

/// [MS-OFORMS] 2.2.10 UserForm Structure
/// Forms are parent controls. They are persisted in binary format as specified in section 2.1.2. This section specifies the format of the Form stream.
public struct UserForm {
    private var storage: CompoundFileStorage
    public let formControl: FormControl
    public let objectData: ObjectData
    public let compObjStream: CompObjStream?
    
    public init(parentStorage: CompoundFileStorage, site: OleSiteConcreteControl) throws {
        var parentStorage = parentStorage
        guard let storage = parentStorage.children[getEmbeddedParentStorageName(site: site)] else {
            throw OfficeFormFileError.corrupted
        }
        
        try self.init(storage: storage)
    }
    
    public init(data: Data) throws {
        let file = try CompoundFile(data: data)
        try self.init(storage: file.rootStorage)
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
