//
//  fmMatchEntry.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

import DataStream

/// [MS-OFORMS] 2.5.45.1 fmMatchEntry
/// The following table specifies the values of this enumeration and their meanings.
public enum fmMatchEntry: UInt8 {
    /// fmMatchEntryFirstLetter 0x00 The control searches for the next entry that starts with the character entered. Repeatedly typing the same
    /// letter cycles through all entries beginning with that letter.
    case firstLetter = 0x00
    
    /// fmMatchEntryComplete 0x01 As each character is typed, the control searches for an entry matching all characters entered.
    case complete = 0x01
    
    /// fmMatchEntryNone 0x02 The list is not searched when characters are typed.
    case none = 0x02
    
    public init(dataStream: inout DataStream) throws {
        guard let value = Self(rawValue: try dataStream.read()) else {
            throw OfficeFormFileError.corrupted
        }
        
        self = value
    }
}
