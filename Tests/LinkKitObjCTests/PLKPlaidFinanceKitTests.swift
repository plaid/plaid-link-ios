import LinkKit
import XCTest

@testable import LinkKitObjC
@testable import LinkKitObjCInternal

#if canImport(FinanceKit) && compiler(>=5.10) && !targetEnvironment(macCatalyst)
@available(iOS 17.4, *)
final class PLKPlaidFinanceKitTests: XCTestCase {

    // MARK: - SyncBehavior Tests

    func testSyncBehaviorLiveConvertsToSwift() {
        let objcBehavior = PLKPlaidFinanceKit.PLKSyncBehavior.live
        let swiftBehavior = objcBehavior.swiftValue

        // Verify it converts to the Swift enum properly
        switch swiftBehavior {
        case .live:
            XCTAssertTrue(true, "Correctly converted to .live")
        case .simulated:
            XCTFail("Should have converted to .live, not .simulated")
        @unknown default:
            XCTFail("unknown default")
        }
    }

    func testSyncBehaviorSimulatedConvertsToSwift() {
        let objcBehavior = PLKPlaidFinanceKit.PLKSyncBehavior.simulated
        let swiftBehavior = objcBehavior.swiftValue

        // Verify it converts to the Swift enum properly
        switch swiftBehavior {
        case .simulated:
            XCTAssertTrue(true, "Correctly converted to .simulated")
        case .live:
            XCTFail("Should have converted to .simulated, not .live")
        @unknown default:
            XCTFail("unknown default")
        }
    }

    func testSyncBehaviorRawValues() {
        // Verify the Int raw values are stable
        XCTAssertEqual(PLKPlaidFinanceKit.PLKSyncBehavior.live.rawValue, 0)
        XCTAssertEqual(PLKPlaidFinanceKit.PLKSyncBehavior.simulated.rawValue, 1)
    }

    // MARK: - FinanceKitError Conversion Tests

    func testInvalidTokenErrorConvertsToObjC() {
        let swiftError = FinanceKitError.invalidToken(message: "Invalid token format")
        let objcError = swiftError.toObjC

        XCTAssertEqual(objcError, .invalidToken)
        XCTAssertEqual(objcError.rawValue, 0)
    }

    func testPermissionErrorConvertsToObjC() {
        let swiftError = FinanceKitError.permissionError(message: "Permission denied")
        let objcError = swiftError.toObjC

        XCTAssertEqual(objcError, .permissionError)
        XCTAssertEqual(objcError.rawValue, 1)
    }

    func testLinkApiErrorConvertsToObjC() {
        let swiftError = FinanceKitError.linkApiError(message: "API request failed")
        let objcError = swiftError.toObjC

        XCTAssertEqual(objcError, .linkApiError)
        XCTAssertEqual(objcError.rawValue, 2)
    }

    func testPermissionAccessErrorConvertsToObjC() {
        let swiftError = FinanceKitError.permissionAccessError(message: "Cannot access permission")
        let objcError = swiftError.toObjC

        XCTAssertEqual(objcError, .permissionAccessError)
        XCTAssertEqual(objcError.rawValue, 3)
    }

    func testUnknownErrorConvertsToObjC() {
        let underlyingError = NSError(domain: "TestDomain", code: 999, userInfo: nil)
        let swiftError = FinanceKitError.unknown(error: underlyingError)
        let objcError = swiftError.toObjC

        XCTAssertEqual(objcError, .unknown)
        XCTAssertEqual(objcError.rawValue, 4)
    }

    // MARK: - NSError Conversion Tests

    func testInvalidTokenErrorConvertsToNSError() {
        let message = "Invalid token format"
        let swiftError = FinanceKitError.invalidToken(message: message)
        let nsError = swiftError.toNSError

        XCTAssertEqual(nsError.domain, kPLKDefaultErrorDomain)
        XCTAssertEqual(nsError.code, PLKPlaidFinanceKitError.invalidToken.rawValue)
        XCTAssertEqual(nsError.userInfo["message"] as? String, message)
        XCTAssertEqual(nsError.localizedDescription, message)
    }

    func testPermissionErrorConvertsToNSError() {
        let message = "Permission denied by user"
        let swiftError = FinanceKitError.permissionError(message: message)
        let nsError = swiftError.toNSError

        XCTAssertEqual(nsError.domain, kPLKDefaultErrorDomain)
        XCTAssertEqual(nsError.code, PLKPlaidFinanceKitError.permissionError.rawValue)
        XCTAssertEqual(nsError.userInfo["message"] as? String, message)
        XCTAssertEqual(nsError.localizedDescription, message)
    }

    func testLinkApiErrorConvertsToNSError() {
        let message = "API request failed with status 500"
        let swiftError = FinanceKitError.linkApiError(message: message)
        let nsError = swiftError.toNSError

        XCTAssertEqual(nsError.domain, kPLKDefaultErrorDomain)
        XCTAssertEqual(nsError.code, PLKPlaidFinanceKitError.linkApiError.rawValue)
        XCTAssertEqual(nsError.userInfo["message"] as? String, message)
        XCTAssertEqual(nsError.localizedDescription, message)
    }

    func testPermissionAccessErrorConvertsToNSError() {
        let message = "Cannot access FinanceKit permission"
        let swiftError = FinanceKitError.permissionAccessError(message: message)
        let nsError = swiftError.toNSError

        XCTAssertEqual(nsError.domain, kPLKDefaultErrorDomain)
        XCTAssertEqual(nsError.code, PLKPlaidFinanceKitError.permissionAccessError.rawValue)
        XCTAssertEqual(nsError.userInfo["message"] as? String, message)
        XCTAssertEqual(nsError.localizedDescription, message)
    }

    func testUnknownErrorConvertsToNSError() {
        let underlyingMessage = "Something went wrong"
        let underlyingError = NSError(
            domain: "TestDomain",
            code: 999,
            userInfo: [NSLocalizedDescriptionKey: underlyingMessage]
        )
        let swiftError = FinanceKitError.unknown(error: underlyingError)
        let nsError = swiftError.toNSError

        XCTAssertEqual(nsError.domain, kPLKDefaultErrorDomain)
        XCTAssertEqual(nsError.code, PLKPlaidFinanceKitError.unknown.rawValue)
        XCTAssertEqual(nsError.userInfo["message"] as? String, underlyingMessage)
        XCTAssertEqual(nsError.localizedDescription, underlyingMessage)
    }

    // MARK: - PLKPlaidFinanceKitError Raw Values

    func testPlaidFinanceKitErrorRawValues() {
        // Ensure enum raw values are stable for Objective-C compatibility
        XCTAssertEqual(PLKPlaidFinanceKitError.invalidToken.rawValue, 0)
        XCTAssertEqual(PLKPlaidFinanceKitError.permissionError.rawValue, 1)
        XCTAssertEqual(PLKPlaidFinanceKitError.linkApiError.rawValue, 2)
        XCTAssertEqual(PLKPlaidFinanceKitError.permissionAccessError.rawValue, 3)
        XCTAssertEqual(PLKPlaidFinanceKitError.unknown.rawValue, 4)
    }

    // MARK: - Integration Tests

    func testAllErrorTypesConvertCorrectly() {
        let testCases: [(FinanceKitError, PLKPlaidFinanceKitError)] = [
            (.invalidToken(message: "test"), .invalidToken),
            (.permissionError(message: "test"), .permissionError),
            (.linkApiError(message: "test"), .linkApiError),
            (.permissionAccessError(message: "test"), .permissionAccessError),
            (.unknown(error: NSError(domain: "test", code: 0)), .unknown),
        ]

        for (swiftError, expectedObjcError) in testCases {
            XCTAssertEqual(swiftError.toObjC, expectedObjcError)
        }
    }

    func testErrorMessagesPreservedInNSError() {
        let testMessages = [
            "Token is malformed",
            "User denied FinanceKit access",
            "Network request timed out",
            "Cannot read FinanceKit permission status",
            "Unexpected error occurred",
        ]

        let errors: [FinanceKitError] = [
            .invalidToken(message: testMessages[0]),
            .permissionError(message: testMessages[1]),
            .linkApiError(message: testMessages[2]),
            .permissionAccessError(message: testMessages[3]),
            .unknown(
                error: NSError(
                    domain: "test",
                    code: 0,
                    userInfo: [NSLocalizedDescriptionKey: testMessages[4]]
                )
            ),
        ]

        for (index, error) in errors.enumerated() {
            let nsError = error.toNSError
            XCTAssertEqual(nsError.localizedDescription, testMessages[index])
            XCTAssertEqual(nsError.userInfo["message"] as? String, testMessages[index])
        }
    }

    func testNSErrorDomainIsConsistent() {
        let errors: [FinanceKitError] = [
            .invalidToken(message: "test"),
            .permissionError(message: "test"),
            .linkApiError(message: "test"),
            .permissionAccessError(message: "test"),
            .unknown(error: NSError(domain: "test", code: 0)),
        ]

        for error in errors {
            let nsError = error.toNSError
            XCTAssertEqual(nsError.domain, kPLKDefaultErrorDomain)
        }
    }

    func testNSErrorCodesMatchObjCEnumValues() {
        let testCases: [(FinanceKitError, Int)] = [
            (.invalidToken(message: ""), PLKPlaidFinanceKitError.invalidToken.rawValue),
            (.permissionError(message: ""), PLKPlaidFinanceKitError.permissionError.rawValue),
            (.linkApiError(message: ""), PLKPlaidFinanceKitError.linkApiError.rawValue),
            (.permissionAccessError(message: ""), PLKPlaidFinanceKitError.permissionAccessError.rawValue),
            (.unknown(error: NSError(domain: "", code: 0)), PLKPlaidFinanceKitError.unknown.rawValue),
        ]

        for (swiftError, expectedCode) in testCases {
            let nsError = swiftError.toNSError
            XCTAssertEqual(nsError.code, expectedCode)
        }
    }
}
#endif  // canImport(FinanceKit) && compiler(>=5.10) && !targetEnvironment(macCatalyst)
