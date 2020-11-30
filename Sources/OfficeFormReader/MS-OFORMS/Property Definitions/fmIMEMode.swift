//
//  fmIMEMode.swift
//  
//
//  Created by Hugh Bellamy on 29/11/2020.
//

/// [MS-OFORMS] 2.5.96.2 fmIMEMode
/// The following table specifies the values of this enumeration and their meanings.
public enum fmIMEMode: UInt8 {
    /// fmIMEModeNoControl 0x0 Does not control IME.
    case noControl = 0x0
    
    /// fmIMEModeOn 0x1 IME on.
    case on = 0x1
    
    /// fmIMEModeOff 0x2 IME off. English mode.
    case off = 0x2
    
    /// fmIMEModeDisable 0x3 IME off. User cannot turn on IME by keyboard.
    case disable = 0x3
    
    /// fmIMEModeHiragana 0x4 IME on with full-width hiragana mode.
    case hiragana = 0x4
    
    /// fmIMEModeKatakana 0x5 IME on with full-width katakana mode.
    case katakana = 0x5
    
    /// fmIMEModeKatakanaHalf 0x6 IME on with half-width katakana mode.
    case katakanaHalf = 0x6
    
    /// fmIMEModeAlphaFull 0x7 IME on with full-width alphanumeric mode.
    case alphaFull = 0x7
    
    /// fmIMEModeAlpha 0x8 IME on with half-width alphanumeric mode.
    case alpha = 0x8
    
    /// fmIMEModeHangulFull 0x9 IME on with full-width Hangul mode.
    case hangulFull = 0x9
    
    /// fmIMEModeHangul 0xA IME on with half-width Hangul mode.
    case hangul = 0xA
    
    /// fmIMEModeHanziFull 0xB IME on with full-width hanzi mode.
    case hanziFull = 0xB
    
    /// fmIMEModeHanzi 0xC IME on with half-width hanzi mode.
    case hanzi = 0xC
}
