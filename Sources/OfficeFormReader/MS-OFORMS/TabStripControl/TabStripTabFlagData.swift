//
//  TabStripTabFlagData.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.9.6 TabStripTabFlagData
/// Specifies properties for individual tabs in the TabStripControl that contains this TabStripTabFlagData. If PropMask.fTabData is set to zero, these
/// properties MUST NOT be stored in the file.
/// Arrays in this structure are ordered. The first element in each array corresponds to the first tab. The order of elements in ExtraDataBlock.Items specifies
/// the order of the tabs.
public struct TabStripTabFlagData {
    public let tabStripTabFlags: [TabStripTabFlag]?
    
    public init(dataStream: inout DataStream, mask: TabStripPropMask, data: TabStripDataBlock) throws {
        /// TabStripTabFlags (variable): An array of TabStripTabFlag. Specifies Boolean properties of each tab. The number of elements in this array
        /// MUST be equal to the value of the DataBlock.TabData of the TabStripControl that contains this TabStripTabFlagData.
        if mask.fTabData {
            var tabStripTabFlags: [TabStripTabFlag] = []
            tabStripTabFlags.reserveCapacity(Int(data.tabData!))
            for _ in 0..<data.tabData! {
                tabStripTabFlags.append(try TabStripTabFlag(dataStream: &dataStream))
            }
            
            self.tabStripTabFlags = tabStripTabFlags
        } else {
            self.tabStripTabFlags = nil
        }
    }
}
