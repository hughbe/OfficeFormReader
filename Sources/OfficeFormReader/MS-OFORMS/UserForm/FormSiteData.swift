//
//  FormSiteData.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.10.6 FormSiteData
/// The depth, specified in section 2.2.10.7, SITE_TYPE and properties of each embedded control in the FormControl that contains this
/// FormSiteData.
public struct FormSiteData {
    public let countOfSiteClassInfo: UInt16?
    public let classTable: [SiteClassInfo]?
    public let countOfSites: UInt32
    public let countOfBytes: UInt32
    public let siteDepthsAndTypes: [FormObjectDepthTypeCount]
    public let sites: [OleSiteConcreteControl]
    
    public init(dataStream: inout DataStream, data: FormDataBlock) throws {
        /// CountOfSiteClassInfo (2 bytes): An unsigned integer that specifies the number of elements in ClassTable. This field MUST NOT be
        /// stored if the value of DataBlock.BooleanProperties.FORM_FLAG_DONTSAVECLASSTABLE in the FormControl that contains this
        /// FormSiteData is set to 1.
        if let booleanProperties = data.booleanProperties, booleanProperties.dontSaveClassTable {
            self.countOfSiteClassInfo = nil
        } else {
            self.countOfSiteClassInfo = try dataStream.read(endianess: .littleEndian)
        }
        
        /// ClassTable (variable): An array of SiteClassInfo structures. Specifies class information of controls that are not one of the types
        /// specified by FormEmbeddedActiveXControlCached. If CountOfSiteClassInfo is set to zero or not stored, this field MUST NOT
        /// be stored.
        if let countOfSiteClassInfo = self.countOfSiteClassInfo {
            var classTable: [SiteClassInfo] = []
            classTable.reserveCapacity(Int(countOfSiteClassInfo))
            for _ in 0..<countOfSiteClassInfo {
                classTable.append(try SiteClassInfo(dataStream: &dataStream))
            }

            self.classTable = classTable
        } else {
            self.classTable = nil
        }
        
        /// CountOfSites (4 bytes): An unsigned integer that specifies the number of elements in Sites.
        self.countOfSites = try dataStream.read(endianess: .littleEndian)
        
        /// CountOfBytes (4 bytes): An unsigned integer that specifies the sum of the sizes, in bytes, of SiteDepthsAndTypes, ArrayPadding,
        /// and Sites.
        self.countOfBytes = try dataStream.read(endianess: .littleEndian)
        
        let startPosition = dataStream.position
        
        /// SiteDepthsAndTypes (variable): An array of FormObjectDepthTypeCount. Specifies the depth as specified in section 2.2.10.7
        /// and SITE_TYPE of each control in Sites. The order of this array MUST be the same as the order of Sites, but one element in this
        /// array can specify more than one consecutive element in Sites. If the fCount of an element in this array is set to 1, TypeOrCount
        /// specifies the number of consecutive elements in Sites represented by that element in this array. The sum of the number of
        /// elements in this array in which fCount is set to zero and the TypeOrCount of each element in this array in which fCount is set to
        /// 1 MUST equal CountOfSites.
        var siteDepthsAndTypes: [FormObjectDepthTypeCount] = []
        var count = 0
        while count < self.countOfSites {
            let siteDepthAndType = try FormObjectDepthTypeCount(dataStream: &dataStream)
            if siteDepthAndType.fCount {
                count += Int(siteDepthAndType.typeOrCount)
            } else {
                count += 1
            }
            siteDepthsAndTypes.append(siteDepthAndType)
        }
        
        self.siteDepthsAndTypes = siteDepthsAndTypes
        
        /// ArrayPadding (variable): Undefined and MUST be ignored. The size of this field is the least number of bytes that, when added to
        /// the size, in bytes, of SiteDepthsAndTypes, produces a sum divisible by 4.
        try dataStream.fourByteAlign(startPosition: startPosition)
        
        /// Sites (variable): An array of OleSiteConcreteControl. Specifies properties of each embedded control in the FormControl that
        /// contains this FormSiteData.
        var sites: [OleSiteConcreteControl] = []
        sites.reserveCapacity(Int(self.countOfSites))
        for _ in 0..<self.countOfSites {
            sites.append(try OleSiteConcreteControl(dataStream: &dataStream))
        }
        
        self.sites = sites
        
        guard dataStream.position - startPosition == self.countOfBytes else {
            throw OfficeFormFileError.corrupted
        }
    }
}
