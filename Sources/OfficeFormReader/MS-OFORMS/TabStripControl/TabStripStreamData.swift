//
//  TabStripStreamData.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.9.5 TabStripStreamData
/// Specifies picture properties of the control that are not set to their file format defaults. If the corresponding bit in the PropMask of the TabStripControl
/// that contains this TabStripStreamData is set to zero, the property value MUST NOT be stored in the file.
public struct TabStripStreamData {
    public let mouseIcon: GuidAndPicture?
    
    public init(dataStream: inout DataStream, mask: TabStripPropMask) throws {
        /// MouseIcon (variable): A GuidAndPicture that specifies the MouseIcon property.
        if mask.fMouseIcon {
            self.mouseIcon = try GuidAndPicture(dataStream: &dataStream)
        } else {
            self.mouseIcon = nil
        }
    }
}
