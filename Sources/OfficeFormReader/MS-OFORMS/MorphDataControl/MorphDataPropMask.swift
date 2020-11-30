//
//  MorphDataPropMask.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.2.5.2 MorphDataPropMask
/// Specifies the properties of the control that are not set to the file format default. For each bit, a value of zero specifies that the corresponding
/// property is the file format default and is not stored in the file.
/// All properties that do not apply to the specific type of control specified by the DisplayStyle property MUST have the corresponding bit set to
/// zero in this structure.
public struct MorphDataPropMask {
    public let fVariousPropertyBits: Bool
    public let fBackColor: Bool
    public let fForeColor: Bool
    public let fMaxLength: Bool
    public let fBorderStyle: Bool
    public let fScrollBars: Bool
    public let fDisplayStyle: Bool
    public let fMousePointer: Bool
    public let fSize: Bool
    public let fPasswordChar: Bool
    public let fListWidth: Bool
    public let fBoundColumn: Bool
    public let fTextColumn: Bool
    public let fColumnCount: Bool
    public let fListRows: Bool
    public let fcColumnInfo: Bool
    public let fMatchEntry: Bool
    public let fListStyle: Bool
    public let fShowDropButtonWhen: Bool
    public let unusedBits1: Bool
    public let fDropButtonStyle: Bool
    public let fMultiSelect: Bool
    public let fValue: Bool
    public let fCaption: Bool
    public let fPicturePosition: Bool
    public let fBorderColor: Bool
    public let fSpecialEffect: Bool
    public let fMouseIcon: Bool
    public let fPicture: Bool
    public let fAccelerator: Bool
    public let unusedBits2: Bool
    public let reserved: Bool
    public let fGroupName: Bool
    public let unusedBits3: UInt32
    
    public init(dataStream: inout DataStream) throws {
        var flags1: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)

        /// A - fVariousPropertyBits (1 bit): Specifies whether the VariousPropertyBits property is stored in the DataBlock.VariousPropertyBits
        /// of the MorphDataControl that contains this MorphDataPropMask.
        self.fVariousPropertyBits = flags1.readBit()

        /// B - fBackColor (1 bit): Specifies whether the BackColor property is stored in the DataBlock.BackColor of the MorphDataControl
        /// that contains this MorphDataPropMask.
        self.fBackColor = flags1.readBit()

        /// C - fForeColor (1 bit): Specifies whether the ForeColor property is stored in the DataBlock.ForeColor of the MorphDataControl
        /// that contains this MorphDataPropMask.
        self.fForeColor = flags1.readBit()

        /// D - fMaxLength (1 bit): Specifies whether the MaxLength property is stored in the DataBlock.MaxLength of the MorphDataControl
        /// that contains this MorphDataPropMask.
        self.fMaxLength = flags1.readBit()

        /// E - fBorderStyle (1 bit): Specifies whether the BorderStyle property is stored in the DataBlock.BorderStyle of the MorphDataControl
        /// that contains this MorphDataPropMask.
        self.fBorderStyle = flags1.readBit()

        /// F - fScrollBars (1 bit): Specifies whether the ScrollBars property is stored in the DataBlock.ScrollBars of the MorphDataControl
        /// that contains this MorphDataPropMask.
        self.fScrollBars = flags1.readBit()

        /// G - fDisplayStyle (1 bit): Specifies whether the DisplayStyle property is stored in the DataBlock.DisplayStyle of the MorphDataControl
        /// that contains this MorphDataPropMask.
        self.fDisplayStyle = flags1.readBit()

        /// H - fMousePointer (1 bit): Specifies whether the MousePointer property is stored in the DataBlock.MousePointer of the
        /// MorphDataControl that contains this MorphDataPropMask.
        self.fMousePointer = flags1.readBit()

        /// I - fSize (1 bit): Specifies whether the Size property is stored in the ExtraDataBlock.Size of the MorphDataControl that contains
        /// this MorphDataPropMask. MUST be set to 1.
        self.fSize = flags1.readBit()

        /// J - fPasswordChar (1 bit): Specifies whether the PasswordChar property is stored in the DataBlock.PasswordChar of the
        /// MorphDataControl that contains this MorphDataPropMask.
        self.fPasswordChar = flags1.readBit()

        /// K - fListWidth (1 bit): Specifies whether the ListWidth property is stored in the DataBlock.ListWidth of the MorphDataControl that
        /// contains this MorphDataPropMask.
        self.fListWidth = flags1.readBit()

        /// L - fBoundColumn (1 bit): Specifies whether the BoundColumn property is stored in the DataBlock.BoundColumn of the
        /// MorphDataControl that contains this MorphDataPropMask.
        self.fBoundColumn = flags1.readBit()

        /// M - fTextColumn (1 bit): Specifies whether the TextColumn property is stored in the DataBlock.TextColumn of the
        /// MorphDataControl that contains this MorphDataPropMask.
        self.fTextColumn = flags1.readBit()

        /// N - fColumnCount (1 bit): Specifies whether the ColumnCount property is stored in the DataBlock.ColumnCount of the
        /// MorphDataControl that contains this MorphDataPropMask.
        self.fColumnCount = flags1.readBit()

        /// O - fListRows (1 bit): Specifies whether the ListRows property is stored in the DataBlock.ListRows of the MorphDataControl that
        /// contains this MorphDataPropMask.
        self.fListRows = flags1.readBit()

        /// P - fcColumnInfo (1 bit): Specifies whether the cColumnInfo property is stored in the DataBlock.cColumnInfo of the
        /// MorphDataControl that contains this MorphDataPropMask.
        self.fcColumnInfo = flags1.readBit()

        /// Q - fMatchEntry (1 bit): Specifies whether the MatchEntry property is stored in the DataBlock.MatchEntry of the MorphDataControl
        /// that contains this MorphDataPropMask.
        self.fMatchEntry = flags1.readBit()

        /// R - fListStyle (1 bit): Specifies whether the ListStyle property is stored in the DataBlock.ListStyle of the MorphDataControl that
        /// contains this MorphDataPropMask.
        self.fListStyle = flags1.readBit()

        /// S - fShowDropButtonWhen (1 bit): Specifies whether the ShowDropButtonWhen property is stored in the
        /// DataBlock.ShowDropButtonWhen of the MorphDataControl that contains this MorphDataPropMask.
        self.fShowDropButtonWhen = flags1.readBit()

        /// T - UnusedBits1 (1 bit): MUST be set to zero.
        self.unusedBits1 = flags1.readBit()

        /// U - fDropButtonStyle (1 bit): Specifies whether the DropButtonStyle property is stored in the DataBlock.DropButtonStyle of the
        /// MorphDataControl that contains this MorphDataPropMask.
        self.fDropButtonStyle = flags1.readBit()

        /// V - fMultiSelect (1 bit): Specifies whether the MultiSelect property is stored in the DataBlock.MultiSelect of the MorphDataControl
        /// that contains this MorphDataPropMask.
        self.fMultiSelect = flags1.readBit()

        /// W - fValue (1 bit): Specifies whether the size and compression flag of the Value property are stored in the DataBlock.Value of the
        /// MorphDataControl that contains this MorphDataPropMask and the Value string is stored in the ExtraDataBlock.Value of the
        /// MorphDataControl.
        self.fValue = flags1.readBit()

        /// X - fCaption (1 bit): Specifies whether the size and compression flag of the Caption property are stored in the DataBlock.Caption
        /// of the MorphDataControl that contains this MorphDataPropMask and the Caption string is stored in the ExtraDataBlock.Caption of
        /// the MorphDataControl.
        self.fCaption = flags1.readBit()

        /// Y - fPicturePosition (1 bit): Specifies whether the PicturePosition property is stored in the DataBlock.PicturePosition of the
        /// MorphDataControl that contains this MorphDataPropMask.
        self.fPicturePosition = flags1.readBit()

        /// Z - fBorderColor (1 bit): Specifies whether the BorderColor property is stored in the DataBlock.BorderColor of the
        /// MorphDataControl that contains this MorphDataPropMask.
        self.fBorderColor = flags1.readBit()

        /// a - fSpecialEffect (1 bit): Specifies whether the SpecialEffect property is stored in the DataBlock.SpecialEffect of the
        /// MorphDataControl that contains this MorphDataPropMask.
        self.fSpecialEffect = flags1.readBit()

        /// b - fMouseIcon (1 bit): Specifies whether the MouseIcon property is stored in the StreamData.MouseIcon of the MorphDataControl
        /// that contains this MorphDataPropMask. When this bit is set to 1, a value of 0xFFFF MUST be stored in the DataBlock.MouseIcon
        /// of the MorphDataControl.
        self.fMouseIcon = flags1.readBit()

        /// c - fPicture (1 bit): Specifies whether the Picture property is stored in the StreamData.Picture of the MorphDataControl that
        /// contains this MorphDataPropMask. When this bit is set to 1, a value of 0xFFFF MUST be stored in the DataBlock.Picture of the
        /// MorphDataControl.
        self.fPicture = flags1.readBit()

        /// d - fAccelerator (1 bit): Specifies whether the Accelerator property is stored in the DataBlock.Accelerator of the MorphDataControl
        /// that contains this MorphDataPropMask.
        self.fAccelerator = flags1.readBit()

        /// e - UnusedBits2 (1 bit): MUST be set to zero.
        self.unusedBits2 = flags1.readBit()

        /// f - Reserved (1 bit): MUST be set to 1 and MUST be ignored.
        self.reserved = flags1.readBit()

        var flags2: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// g - fGroupName (1 bit): Specifies whether the size and compression flag of the GroupName property are stored in the
        /// DataBlock.GroupName of the MorphDataControl that contains this MorphDataPropMask and the GroupName string is stored in
        /// the ExtraDataBlock.GroupName of the MorphDataControl.
        self.fGroupName = flags2.readBit()
        
        /// UnusedBits3 (31 bits): MUST be set to zero.
        self.unusedBits3 = flags2.readRemainingBits()
    }
}
