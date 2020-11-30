//
//  MorphDataStreamData.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.5.5 MorphDataStreamData
/// Specifies picture properties of the control that are not set to the file format defaults. If the corresponding bit in the PropMask of the
/// MorphDataControl that contains this MorphDataStreamData is set to zero, the property value MUST NOT be stored in the file.
public struct MorphDataStreamData {
    public let mouseIcon: GuidAndPicture?
    public let picture: GuidAndPicture?
    
    public init(dataStream: inout DataStream, mask: MorphDataPropMask) throws {
        /// MouseIcon (variable): A GuidAndPicture that specifies the MouseIcon property.
        if mask.fMouseIcon {
            self.mouseIcon = try GuidAndPicture(dataStream: &dataStream)
        } else {
            self.mouseIcon = nil
        }
        
        /// Picture (variable): A GuidAndPicture that specifies the Picture property.
        if mask.fPicture {
            self.picture = try GuidAndPicture(dataStream: &dataStream)
        } else {
            self.picture = nil
        }
    }
}
