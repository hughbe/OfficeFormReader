//
//  SpinButtonStreamData.swift
//  
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.8.5 SpinButtonStreamData
/// Specifies picture properties of the control that are not set to the file format defaults. If the corresponding bit in the PropMask of the SpinButtonControl
/// that contains this SpinButtonStreamData is set to zero, the property value MUST NOT be stored in the file.
public struct SpinButtonStreamData {
    public let mouseIcon: GuidAndPicture?
    
    public init(dataStream: inout DataStream, mask: SpinButtonPropMask) throws {
        /// MouseIcon (variable): A GuidAndPicture that specifies the MouseIcon property.
        if mask.fMouseIcon {
            self.mouseIcon = try GuidAndPicture(dataStream: &dataStream)
        } else {
            self.mouseIcon = nil
        }
    }
}
