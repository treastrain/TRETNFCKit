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
            let result = kitChildren.contains { kitChild -> Bool in
                coreChild.label == kitChild.label
            }
            XCTAssertTrue(result, "\(kitMirror.subjectType) has no member \(coreChild.label ?? "nil")", line: line)
        }
    }
}
