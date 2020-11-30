//
//  ScrollBarStreamData.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.7.5 ScrollBarStreamData
/// Specifies picture properties of the control that are not set to the file format defaults. If the corresponding bit in the PropMask of the ScrollBarControl
/// that contains this ScrollBarStreamData is set to zero, the property value MUST NOT be stored in the file.
public struct ScrollBarStreamData {
    public let mouseIcon: GuidAndPicture?
    
    public init(dataStream: inout DataStream, mask: ScrollBarPropMask) throws {
        /// MouseIcon (variable): A GuidAndPicture that specifies the MouseIcon property.
        if mask.fMouseIcon {
            self.mouseIcon = try GuidAndPicture(dataStream: &dataStream)
        } else {
            self.mouseIcon = nil
        }
    }
}
