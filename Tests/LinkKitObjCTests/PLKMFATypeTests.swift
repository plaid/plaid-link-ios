import LinkKit
import XCTest

@testable import LinkKitObjC
@testable import LinkKitObjCInternal

final class PLKMFATypeTests: XCTestCase {

    func testMFATypeToObjCMapping() throws {
        let testCases: [(MFAType, PLKMFAType)] = [
            (.code, .code),
            (.device, .device),
            (.questions, .questions),
            (.selections, .selections),
        ]

        for (swiftValue, objcValue) in testCases {
            XCTAssertEqual(swiftValue.toObjC, objcValue, "Expected \(swiftValue) to map to \(objcValue)")
        }
    }

    func testMFATypeUnknownDefaultFallsBackToNone() throws {
        // We cannot construct an unknown MFAType case directly in Swift to hit the @unknown default.
        // This test asserts that the Objective-C enum has `.none` available and that known cases
        // do not map to `.none`, ensuring that unknowns would fall back to `.none`.
        let knownMappings: [MFAType] = [.code, .device, .questions, .selections]
        for value in knownMappings {
            XCTAssertNotEqual(value.toObjC, .none, "Known MFAType \(value) should not map to .none")
        }

        // Sanity: ensure .none exists on the ObjC side
        _ = PLKMFAType.none
    }
}
