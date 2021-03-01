//
//  FeliCaEncryptionIdTests.swift
//  
//
//  Created by treastrain on 2021/03/01.
//

import XCTest
#if os(iOS)
import CoreNFC
#endif
@testable import NFCKit

final class FeliCaEncryptionIdTests: XCTestCase, NFCKitTests {
    #if os(iOS) && !targetEnvironment(macCatalyst)
    @available(iOS 13.0, *)
    func testFeliCaEncryptionId() throws {
        XCTAssertEqual(CoreNFC.NFCFeliCaEncryptionId.AES.rawValue, FeliCaEncryptionId.AES)
        XCTAssertEqual(CoreNFC.NFCFeliCaEncryptionId.AES_DES.rawValue, FeliCaEncryptionId.AES_DES)
    }
    #endif
}
