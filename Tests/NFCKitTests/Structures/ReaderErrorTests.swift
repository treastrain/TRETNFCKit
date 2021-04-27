//
//  ReaderErrorTests.swift
//  
//
//  Created by treastrain on 2021/04/28.
//

import XCTest
#if os(iOS)
import CoreNFC
#endif
@testable import NFCKit

final class ReaderErrorTests: XCTestCase, NFCKitTests {
    func testReaderError() throws {
        #if os(iOS) && !targetEnvironment(macCatalyst)
        guard #available(iOS 11.0, *) else {
            XCTFail("There is a problem with the OS version you are testing.")
            return
        }
        
        let kitErrors = ReaderError.Code.allCases.map { code in
            ReaderError(code)
        }
        for kitError in kitErrors {
            guard let coreError = CoreNFC.NFCReaderError(from: kitError) else {
                XCTAssertNotNil(nil, "NFCKit.ReaderError.errorCode: \(kitError.errorCode)")
                continue
            }
            let kitError = ReaderError(from: coreError)
            testObjectConsistency(coreError, kitError)
        }
        #else
        _ = ReaderError(.kitErrorCoreNFCAndNFCKitErrorCodeConversionFailed, userInfo: [:], description: "")
        #endif
    }
}
