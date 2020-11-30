//
//  fmMousePointer.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

/// [MS-OFORMS] 2.5.50.1 fmMousePointer
/// The following table specifies the values of this enumeration and their meanings.
public enum fmMousePointer: UInt8 {
    /// fmMousePointerDefault 0x00 Standard pointer.
    case `default` = 0x00
    
    /// fmMousePointerArrow 0x01 Arrow.
    case arrow = 0x01
    
    /// fmMousePointerCross 0x02 Cross-hair pointer.
    case cross = 0x02
    
    /// fmMousePointerIBeam 0x03 I-beam.
    case iBean = 0x03
    
    /// fmMousePointerSizeNESW 0x06 Double arrow pointing northeast and southwest.
    case sizeNESW = 0x06
    
    /// fmMousePointerSizeNS 0x07 Double arrow pointing north and south.
    case sizeNS = 0x07
    
    /// fmMousePointerSizeNWSE 0x08 Double arrow pointing northwest and southeast.
    case sizeNWSE = 0x08
    
    /// fmMousePointerSizeWE 0x09 Double arrow pointing west and east.
    case sizeWE = 0x09
    
    /// fmMousePointerUpArrow 0x0A Up arrow.
    case upArrow = 0x0A
    
    /// fmMousePointerHourGlass 0x0B Hourglass.
    case hourglass = 0x0B
    
    /// fmMousePointerNoDrop 0x0C "Not" symbol (circle with a diagonal line) on top of the object being dragged.
    case noDrop = 0x0C
    
    /// fmMousePointerAppStarting 0x0D Arrow with an hourglass.
    case appStarting = 0x0D
    
    /// fmMousePointerHelp 0x0E Arrow with a question mark.
    case help = 0x0E
    
    /// fmMousePointerSizeAll 0x0F "Size-all" cursor (arrows pointing north, south, east, and west).
    case sizeAll = 0x0F
    
    /// fmMousePointerCustom 0x63 Uses the icon specified by the MouseIcon property.
    case custom = 0x63
}
