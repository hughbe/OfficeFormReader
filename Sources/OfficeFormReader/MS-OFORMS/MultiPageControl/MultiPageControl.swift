//
//  MultiPageControl.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import CompoundFileReader
import DataStream
import OleDataTypes

/// [MS-OFORMS] 2.2.6 MultiPage Properties
/// MultiPage controls are parent controls. They are persisted in binary format as specified in section 2.1.2. This section specifies the format of the
/// MultiPage control as persisted in the "x" stream.
public struct MultiPageControl {
    public let formControl: FormControl
    public let objectData: ObjectData
    public let properties: MultiPageProperties
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
        /// [MS-OFORMS] 2.1.2.3 MultiPage Control Structure
        /// A MultiPage control that is persisted in a binary format uses the storage and streams specified in section 2.1.2.1 and section 2.1.2.2.
        /// It consists of a FormControl, which is stored in the Form stream, a TabStripControl, which is stored in the Object stream, and multiple
        /// Page controls, which are stored as specified in section 2.1.2.2.2.
        /// The storage of a MultiPage control also contains an additional stream, which MUST be named "x".
        /// This stream contains an array of PageProperties immediately followed by a MultiPageProperties. The number of elements in the array of
        /// PageProperties MUST be set to 1 plus the value of DataBlock.PageCount of the MultiPageProperties. The first PageProperties in the array
        /// MUST be ignored. The remaining elements specify one PageProperties for each Page in the control. The order of the Pages is specified
        /// by the value of the ExtraDataBlock.Items of the TabStripControl specified in the previous paragraph.
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
        
        guard let propertiesStorage = storage.children["x"] else {
            throw OfficeFormFileError.corrupted
        }
        
        var propertiesDataStream = propertiesStorage.dataStream
        self.properties = try MultiPageProperties(dataStream: &propertiesDataStream)
        
        if let compObjStorage = storage.children["\u{0001}CompObj"] {
            var compObjDataStream = compObjStorage.dataStream
            self.compObjStream = try CompObjStream(dataStream: &compObjDataStream, count: compObjDataStream.count)
        } else {
            self.compObjStream = nil
        }

        self.storage = storage
    }
}
