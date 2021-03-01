import XCTest
#if os(iOS)
import CoreNFC
#endif
@testable import NFCKit

public protocol NFCKitTests: XCTestCase {
    func testObjectConsistency(_ coreSubject: Any, _ kitSubject: Any, line: UInt)
    func testObjectNameConsistency(_ coreMirror: Mirror, _ kitMirror: Mirror, line: UInt)
    func testPropertiesConsistency(_ coreMirror: Mirror, _ kitMirror: Mirror, line: UInt)
}

public extension NFCKitTests {
    func testObjectConsistency(_ coreSubject: Any, _ kitSubject: Any, line: UInt = #line) {
        let coreMirror = Mirror(reflecting: coreSubject)
        let kitMirror = Mirror(reflecting: kitSubject)
        
        testObjectNameConsistency(coreMirror, kitMirror, line: line)
        testPropertiesConsistency(coreMirror, kitMirror, line: line)
    }
    
    func testObjectNameConsistency(_ coreMirror: Mirror, _ kitMirror: Mirror, line: UInt = #line) {
        let coreObjectName = "\(coreMirror.subjectType)"
        let coreObjectNameWithoutPrefix = coreObjectName.replacingOccurrences(of: "NFC", with: "")
        let kitObjectName = "\(kitMirror.subjectType)"
        
        XCTAssertEqual(coreObjectNameWithoutPrefix, kitObjectName, "Inconsistent class/struct names: \(coreObjectName) vs. \(kitObjectName)", line: line)
    }
    
    func testPropertiesConsistency(_ coreMirror: Mirror, _ kitMirror: Mirror, line: UInt = #line) {
        let coreChildren = coreMirror.children
        let kitChildren = kitMirror.children
        
        for coreChild in coreChildren {
            let coreChildMirror = Mirror(reflecting: coreChild.value)
            let coreChildValue: AnyObject
            switch coreChildMirror.displayStyle {
            #if os(iOS) && !targetEnvironment(macCatalyst)
            case .enum:
                switch coreChild.value {
                case let feliCaEncryptionId as NFCFeliCaEncryptionId:
                    coreChildValue = feliCaEncryptionId.rawValue as AnyObject
                default:
                    fatalError("The processing to rawValue of the enum is not described.")
                }
            #endif
            default:
                coreChildValue = coreChild.value as AnyObject
            }
            let result = kitChildren.contains { kitChild -> Bool in
                coreChild.label == kitChild.label && coreChildValue === (kitChild.value as AnyObject)
            }
            XCTAssertTrue(result, "\(kitMirror.subjectType) has no member \"\(coreChild.label ?? "nil")\" or the value doesn't match.", line: line)
        }
    }
}
