//
//  SITE_FLAG.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.4.1 SITE_FLAG
/// Specifies Boolean properties of an embedded control on a form. Unless otherwise specified, each bit applies to all control types. All bits that
/// do not apply to a particular type of control MUST be set to zero for that control.
public struct SITE_FLAG {
    public let fTabStop: Bool
    public let fVisible: Bool
    public let fDefault: Bool
    public let fCancel: Bool
    public let fStreamed: Bool
    public let fAutoSize: Bool
    public let unused1: UInt8
    public let fPreserveHeight: Bool
    public let fFitToParent: Bool
    public let reserved1: UInt8
    public let fSelectChild: Bool
    public let unused2: UInt8
    public let fPromoteControls: Bool
    public let unused3: UInt16
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fTabStop (1 bit): Specifies whether the control can receive focus while the user is navigating controls using the TAB key.
        self.fTabStop = flags.readBit()
        
        /// B - fVisible (1 bit): Specifies whether the control is displayed.
        self.fVisible = flags.readBit()
        
        /// C - fDefault (1 bit): Specifies whether the control is the default option on the form.
        self.fDefault = flags.readBit()
        
        /// D - fCancel (1 bit): Specifies whether the control is the cancel option on the form.
        self.fCancel = flags.readBit()
        
        /// E - fStreamed (1 bit): Specifies whether the control is stored in the Object stream of the form. A value of zero specifies that the
        /// control has its own storage.
        self.fStreamed = flags.readBit()
        
        /// F - fAutoSize (1 bit): Specifies whether the control automatically resizes to display its entire contents.
        self.fAutoSize = flags.readBit()
        
        /// G - Unused1 (2 bits): MUST be set to zero.
        self.unused1 = UInt8(flags.readBits(count: 2))
        
        /// H - fPreserveHeight (1 bit): Specifies whether to preserve the height of a control when resizing. Applies to ListBox.
        self.fPreserveHeight = flags.readBit()
        
        /// I - fFitToParent (1 bit): Specifies whether to adjust the size of a control when the size of its parent changes.
        self.fFitToParent = flags.readBit()
        
        /// J - Reserved1 (3 bits): MUST be set to zero and MUST be ignored.
        self.reserved1 = UInt8(flags.readBits(count: 3))
        
        /// K - fSelectChild (1 bit): Specifies whether to select the first child of a container control when the container control is the next
        /// control to which the user is navigating.
        self.fSelectChild = flags.readBit()
        
        /// Unused2 (4 bits): MUST be set to zero.
        self.unused2 = UInt8(flags.readBits(count: 4))
        
        /// L - fPromoteControls (1 bit): Specifies whether child controls are identified as child objects of the control or as child objects of the
        /// parent of the control. MUST be set to 1 for the following controls: Frame, MultiPage and Page. MUST be set to zero for all other
        /// controls.
        self.fPromoteControls = flags.readBit()
        
        /// Unused3 (13 bits): MUST be set to zero.
        self.unused3 = UInt16(flags.readRemainingBits())
    }
}
