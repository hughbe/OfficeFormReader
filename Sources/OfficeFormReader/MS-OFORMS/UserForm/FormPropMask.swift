//
//  FormPropMask.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.10.2 FormPropMask
/// Specifies the properties of the control that are not set to the file format default. For each bit, a value of zero specifies that the corresponding
/// property is the file format default and is not stored in the file.
public struct FormPropMask {
    public let unused1: Bool
    public let fBackColor: Bool
    public let fForeColor: Bool
    public let fNextAvailableID: Bool
    public let unused2: UInt8
    public let fBooleanProperties: Bool
    public let fBorderStyle: Bool
    public let fMousePointer: Bool
    public let fScrollBars: Bool
    public let fDisplayedSize: Bool
    public let fLogicalSize: Bool
    public let fScrollPosition: Bool
    public let fGroupCnt: Bool
    public let reserved: Bool
    public let fMouseIcon: Bool
    public let fCycle: Bool
    public let fSpecialEffect: Bool
    public let fBorderColor: Bool
    public let fCaption: Bool
    public let fFont: Bool
    public let fPicture: Bool
    public let fZoom: Bool
    public let fPictureAlignment: Bool
    public let fPictureTiling: Bool
    public let fPictureSizeMode: Bool
    public let fShapeCookie: Bool
    public let fDrawBuffer: Bool
    public let unused3: UInt8
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - Unused1 (1 bit): MUST be set to zero.
        self.unused1 = flags.readBit()
        
        /// B - fBackColor (1 bit): Specifies whether the BackColor property is stored in the DataBlock.BackColor of the FormControl that
        /// contains this FormPropMask.
        self.fBackColor = flags.readBit()
        
        /// C - fForeColor (1 bit): Specifies whether the ForeColor property is stored in the DataBlock.ForeColor of the FormControl that
        /// contains this FormPropMask.
        self.fForeColor = flags.readBit()
        
        /// D - fNextAvailableID (1 bit): Specifies whether the NextAvailableID property is stored in the DataBlock.NextAvailableID of the
        /// FormControl that contains this FormPropMask.
        self.fNextAvailableID = flags.readBit()
        
        /// E - Unused2 (2 bits): MUST be set to zero.
        self.unused2 = UInt8(flags.readBits(count: 2))
        
        /// F - fBooleanProperties (1 bit): Specifies whether the BooleanProperties property is stored in the DataBlock.BooleanProperties of
        /// the FormControl that contains this FormPropMask.
        self.fBooleanProperties = flags.readBit()
        
        /// G - fBorderStyle (1 bit): Specifies whether the BorderStyle property is stored in the DataBlock.BorderStyle of the FormControl that
        /// contains this FormPropMask.
        self.fBorderStyle = flags.readBit()
        
        /// H - fMousePointer (1 bit): Specifies whether the MousePointer property is stored in the DataBlock.MousePointer of the FormControl
        /// that contains this FormPropMask.
        self.fMousePointer = flags.readBit()
        
        /// I - fScrollBars (1 bit): Specifies whether the ScrollBars property is stored in the DataBlock.ScrollBars of the FormControl that
        /// contains this FormPropMask.
        self.fScrollBars = flags.readBit()
        
        /// J - fDisplayedSize (1 bit): Specifies whether the DisplayedSize property is stored in the ExtraDataBlock.DisplayedSize of the
        /// FormControl that contains this FormPropMask.
        self.fDisplayedSize = flags.readBit()
        
        /// K - fLogicalSize (1 bit): Specifies whether the LogicalSize property is stored in the ExtraDataBlock.LogicalSize of the FormControl
        /// that contains this FormPropMask.
        self.fLogicalSize = flags.readBit()
        
        /// L - fScrollPosition (1 bit): Specifies whether the ScrollPosition property is stored in the ExtraDataBlock.ScrollPosition of the
        /// FormControl that contains this FormPropMask.
        self.fScrollPosition = flags.readBit()
        
        /// M - fGroupCnt (1 bit): Specifies whether the GroupCount property is stored in the DataBlock.GroupCnt of the FormControl that
        /// contains this FormPropMask.
        self.fGroupCnt = flags.readBit()
        
        /// N - Reserved (1 bit): MUST be set to zero and MUST be ignored.
        self.reserved = flags.readBit()
        
        /// O - fMouseIcon (1 bit): Specifies whether the MouseIcon property is stored in the StreamData.MouseIcon of the FormControl that
        /// contains this FormPropMask. When this bit is set to 1, a value of 0xFFFF MUST be stored in the DataBlock.MouseIcon of the
        /// FormControl.
        self.fMouseIcon = flags.readBit()
        
        /// P - fCycle (1 bit): Specifies whether the Cycle property is stored in the DataBlock.Cycle of the FormControl that contains this
        /// FormPropMask.
        self.fCycle = flags.readBit()
        
        /// Q - fSpecialEffect (1 bit): Specifies whether the SpecialEffect property is stored in the DataBlock.SpecialEffect of the FormControl
        /// that contains this FormPropMask.
        self.fSpecialEffect = flags.readBit()
        
        /// R - fBorderColor (1 bit): Specifies whether the BorderColor property is stored in the DataBlock.BorderColor of the FormControl that
        /// contains this FormPropMask.
        self.fBorderColor = flags.readBit()
        
        /// S - fCaption (1 bit): Specifies whether the size and compression flag of the Caption property are stored in the
        /// DataBlock.LengthAndCompression of the FormControl that contains this FormPropMask and the Caption string is stored in the
        /// ExtraDataBlock.Caption of the FormControl.
        self.fCaption = flags.readBit()
        
        /// T - fFont (1 bit): Specifies whether the Font property is stored in the StreamData.GuidAndFont of the FormControl that contains this
        /// FormPropMask.
        self.fFont = flags.readBit()
        
        /// U - fPicture (1 bit): Specifies whether the Picture property is stored in the StreamData.Picture of the FormControl that contains this
        /// FormPropMask.
        self.fPicture = flags.readBit()
        
        /// V - fZoom (1 bit): Specifies whether the Zoom property is stored in the DataBlock.Zoom of the FormControl that contains this
        /// FormPropMask.
        self.fZoom = flags.readBit()
        
        /// W - fPictureAlignment (1 bit): Specifies whether the PictureAlignment property is stored in the DataBlock.PictureAlignment of the
        /// FormControl that contains this FormPropMask.
        self.fPictureAlignment = flags.readBit()
        
        /// X - fPictureTiling (1 bit): Specifies whether the value of the PictureTiling property is not the file format default.
        self.fPictureTiling = flags.readBit()
        
        /// Y - fPictureSizeMode (1 bit): Specifies whether the PictureSizeMode property is stored in the DataBlock.PictureSizeMode of the
        /// FormControl that contains this FormPropMask.
        self.fPictureSizeMode = flags.readBit()
        
        /// Z - fShapeCookie (1 bit): Specifies whether the ShapeCookie property is stored in the DataBlock.ShapeCookie of the FormControl
        /// that contains this FormPropMask.
        self.fShapeCookie = flags.readBit()
        
        /// a - fDrawBuffer (1 bit): Specifies whether the DrawBuffer property is stored in the DataBlock.DrawBuffer of the FormControl that
        /// contains this FormPropMask. MUST be set to 1.
        self.fDrawBuffer = flags.readBit()
     
        /// Unused3 (4 bits): MUST be set to zero.
        self.unused3 = UInt8(flags.readRemainingBits())
    }
}
