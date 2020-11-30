//
//  FormDesignExData.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.10.9 FormDesignExData
/// Specifies design-time properties of a form.
public struct FormDesignExData {
    public let designEx: DesignExtender?
    
    public init(dataStream: inout DataStream, data: FormDataBlock) throws {
        /// DesignEx (variable): A DesignExtender that specifies the properties of the design surface of this form. If the value of
        /// DataBlock.BooleanProperties.FORM_FLAG_DESINKPERSISTED of the FormControl that contains this FormDesignExData is
        /// set to zero, this structure MUST NOT be stored.
        if let booleanProperties = data.booleanProperties, booleanProperties.desinkPersisted {
            self.designEx = try DesignExtender(dataStream: &dataStream)
        } else {
            self.designEx = nil
        }
    }
}
