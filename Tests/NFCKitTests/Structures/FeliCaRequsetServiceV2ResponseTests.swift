//
//  FeliCaRequsetServiceV2ResponseTests.swift
//  
//
//  Created by treastrain on 2021/03/01.
//

import XCTest
#if os(iOS)
import CoreNFC
#endif
@testable import NFCKit

final class FeliCaRequsetServiceV2ResponseTests: XCTestCase, NFCKitTests {
    func testFeliCaRequsetServiceV2Response() throws {
        #if os(iOS) && !targetEnvironment(macCatalyst)
        guard #available(iOS 14.0, *) else {
            XCTFail("There is a problem with the OS version you are testing.")
            return
        }
        
        var core = NFCFeliCaRequsetServiceV2Response(statusFlag1: 0, statusFlag2: 0, encryptionIdentifier: .AES, nodeKeyVersionListAES: nil, nodeKeyVersionListDES: nil)
        let kit = FeliCaRequsetServiceV2Response(from: core)
        testObjectConsistency(core, kit)
        
        core = NFCFeliCaRequsetServiceV2Response(from: kit)
        testObjectConsistency(core, kit)
        #else
        _ = FeliCaRequsetServiceV2Response(statusFlag1: 0, statusFlag2: 0, encryptionIdentifier: .AES, nodeKeyVersionListAES: nil, nodeKeyVersionListDES: nil)
        #endif
    }
}
