//
//  Tag.swift
//  
//
//  Created by treastrain on 2021/04/29.
//

import Foundation
#if os(iOS)
import CoreNFC
#endif

/// A NFC tag object.  The NFCTagReaderSession returns an instance of this type when a tag is detected.
public enum Tag {

    #if os(iOS)
    /// FeliCa tag.
    @available(iOS 13.0, *)
    case feliCa(NFCFeliCaTag)

    /// ISO14443-4 type A / B tag with ISO7816 communication.
    @available(iOS 13.0, *)
    case iso7816(NFCISO7816Tag)

    /// ISO15693 tag.
    @available(iOS 13.0, *)
    case iso15693(NFCISO15693Tag)

    /// MiFare technology tag (MIFARE Plus, UltraLight, DESFire) base on ISO14443.
    @available(iOS 13.0, *)
    case miFare(NFCMiFareTag)
    #endif

    /// Check whether a detected tag is available.  Returns `true` if tag is available in the current reader session.
    /// A tag remove from the RF field will become unavailable.  Tag in disconnected state will return `false`.
    public var isAvailable: Bool {
        #if os(iOS)
        return true
        #else
        return false
        #endif
    }
}

extension Tag: Equatable {
    public static func == (lhs: Tag, rhs: Tag) -> Bool {
        return true
    }
    
    @available(iOS 13.0, *)
    public static func == (lhs: CoreNFC.NFCTag, rhs: Tag) -> Bool {
        switch lhs {
        case .feliCa(_):
            let aaa = rhs
            return rhs is NFCFeliCaTag
        case .iso7816(_):
            <#code#>
        case .iso15693(_):
            <#code#>
        case .miFare(_):
            <#code#>
        @unknown default:
            return false
        }
        return lhs.errorCode == rhs.errorCode
    }
}
