//
//  FormStreamData.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.10.5 FormStreamData
/// Specifies font and picture properties of the control that are not set to the file format defaults. If the corresponding bit in the PropMask of the
/// FormControl that contains this FormStreamData is set to zero, the property value MUST NOT be stored in the file.
public struct FormStreamData {
    public let mouseIcon: GuidAndPicture?
    public let guidAndFont: GuidAndFont?
    public let picture: GuidAndPicture?
    
    public init(dataStream: inout DataStream, mask: FormPropMask) throws {
        /// MouseIcon (variable): A GuidAndPicture that specifies the MouseIcon property.
        if mask.fMouseIcon {
            self.mouseIcon = try GuidAndPicture(dataStream: &dataStream)
        } else {
            self.mouseIcon = nil
        }
        
        /// GuidAndFont (variable): A GuidAndFont that specifies the Font property.
        if mask.fFont {
            self.guidAndFont = try GuidAndFont(dataStream: &dataStream)
        } else {
            self.guidAndFont = nil
        }
        
        /// Picture (variable): A GuidAndPicture that specifies the Picture property.
        if mask.fPicture {
            self.picture = try GuidAndPicture(dataStream: &dataStream)
        } else {
            self.picture = nil
        }
    }
}
