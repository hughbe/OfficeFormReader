//
//  fmFontPitchAndFamily.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.29.1 fmFontPitchAndFamily
/// An unsigned integer specifying character pitch and font family. The four low-order bits specify the character pitch of a font, and the
/// four high-order bits specify the font family.
public struct fmFontPitchAndFamily {
    public let pitch: fmFontPitch
    public let family: fmFontFamily
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// Pitch (4 bits): Specifies the character pitch of a font. MUST be a value specified in fmFontPitch.
        guard let pitch = fmFontPitch(rawValue: flags.readBits(count: 4)) else {
            throw OfficeFormFileError.corrupted
        }
        
        self.pitch = pitch
        
        /// Family (4 bits): Specifies the font family of a font. MUST be a value specified in fmFontFamily.
        guard let family = fmFontFamily(rawValue: flags.readBits(count: 4)) else {
            throw OfficeFormFileError.corrupted
        }
        
        self.family = family
    }
}
