//
//  LabelStreamData.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.4.5 LabelStreamData
/// Specifies picture properties of the control that are not set to the file format defaults. If the corresponding bit in the PropMask of the
/// LabelControl that contains this LabelStreamData is set to zero, the property value MUST NOT be stored in the file.
public struct LabelStreamData {
    public let picture: GuidAndPicture?
    public let mouseIcon: GuidAndPicture?
    
    public init(dataStream: inout DataStream, mask: LabelPropMask) throws {
        /// Picture (variable): A GuidAndPicture that specifies the Picture property.
        if mask.fPicture {
            self.picture = try GuidAndPicture(dataStream: &dataStream)
        } else {
            self.picture = nil
        }
        
        /// MouseIcon (variable): A GuidAndPicture that specifies the MouseIcon property.
        if mask.fMouseIcon {
            self.mouseIcon = try GuidAndPicture(dataStream: &dataStream)
        } else {
            self.mouseIcon = nil
        }
    }
}
