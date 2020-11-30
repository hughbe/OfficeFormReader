//
//  DX_MODE.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.5.1 DX_MODE
/// Specifies Boolean design-time properties of a UserForm.
public struct DX_MODE {
    public let fInheritDesign: Bool
    public let fDesign: Bool
    public let fInheritShowToolbox: Bool
    public let fShowToolbox: Bool
    public let fInheritShowGrid: Bool
    public let fShowGrid: Bool
    public let fInheritSnapToGrid: Bool
    public let fSnapToGrid: Bool
    public let fInheritGridX: Bool
    public let fInheritGridY: Bool
    public let fInheritClickControl: Bool
    public let fInheritDblClickControl: Bool
    public let fInheritShowInvisible: Bool
    public let fShowInvisible: Bool
    public let fInheritShowTooltips: Bool
    public let fShowTooltips: Bool
    public let fInheritLayoutImmediate: Bool
    public let fLayoutImmediate: Bool

    public let unused: UInt16
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)

        /// A - fInheritDesign (1 bit): Specifies whether the form has the same value as the client application design surface settings for fDesign.
        self.fInheritDesign = flags.readBit()

        /// B - fDesign (1 bit): Specifies whether the form is currently in design mode.
        self.fDesign = flags.readBit()

        /// C - fInheritShowToolbox (1 bit): Specifies whether the form has the same value as the client application design-time settings for
        ///  fShowToolbox.
        self.fInheritShowToolbox = flags.readBit()

        /// D - fShowToolbox (1 bit): Specifies whether the toolbox is visible.
        self.fShowToolbox = flags.readBit()

        /// E - fInheritShowGrid (1 bit): Specifies whether the form has the same value as the client application design-time settings for
        /// fShowGrid.
        self.fInheritShowGrid = flags.readBit()

        /// F - fShowGrid (1 bit): Specifies whether to display a grid on the design surface of the form.
        self.fShowGrid = flags.readBit()

        /// G - fInheritSnapToGrid (1 bit): Specifies whether the form has the same value as the client application design-time settings for
        /// fSnapToGrid.
        self.fInheritSnapToGrid = flags.readBit()

        /// H - fSnapToGrid (1 bit): Specifies whether to keep controls on the form in positions that are on the grid.
        self.fSnapToGrid = flags.readBit()

        /// I - fInheritGridX (1 bit): Specifies whether the form has the same value as the client application design-time settings for
        /// DataBlock.GridX.
        self.fInheritGridX = flags.readBit()

        /// J - fInheritGridY (1 bit): Specifies whether the form has the same value as the client application design-time settings for
        /// DataBlock.GridY.
        self.fInheritGridY = flags.readBit()

        /// K - fInheritClickControl (1 bit): Specifies whether the form has the same value as the client application design-time settings for
        /// DataBlock.ClickControlMode.
        self.fInheritClickControl = flags.readBit()

        /// L - fInheritDblClickControl (1 bit): Specifies whether the form has the same value as the client application design-time settings
        /// for DataBlock.DblClickControlMode.
        self.fInheritDblClickControl = flags.readBit()

        /// M - fInheritShowInvisible (1 bit): Specifies whether the form has the same value as the client application design-time settings
        /// for fShowInvisible.
        self.fInheritShowInvisible = flags.readBit()

        /// N - fShowInvisible (1 bit): Specifies whether to display controls that have been marked as not visible.
        self.fShowInvisible = flags.readBit()

        /// O - fInheritShowTooltips (1 bit): Specifies whether the form has the same value as the client application design-time settings
        /// for fShowTooltips.
        self.fInheritShowTooltips = flags.readBit()

        /// P - fShowTooltips (1 bit): Specifies whether to display tooltips for controls on the design surface.
        self.fShowTooltips = flags.readBit()

        /// Q - fInheritLayoutImmediate (1 bit): Specifies whether the form has the same value as the client application design-time settings
        /// for fLayoutImmediate.
        self.fInheritLayoutImmediate = flags.readBit()

        /// R - fLayoutImmediate (1 bit): Specifies whether to update the design surface after a property has changed.
        self.fLayoutImmediate = flags.readBit()
        
        /// Unused (14 bits): MUST be set to zero.
        self.unused = UInt16(flags.readRemainingBits())
    }
}
