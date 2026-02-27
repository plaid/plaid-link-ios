import LinkKit
import XCTest

@testable import LinkKitObjC
@testable import LinkKitObjCInternal

final class PLKPlaidConfigurationErrorTests: XCTestCase {

    // MARK: - toObjC Conversion Tests

    func testInvalidTokenToObjC() {
        let configError = ConfigurationError.invalidToken(message: "Invalid token provided")

        let objcError = configError.toObjC

        XCTAssertEqual(objcError, .invalidToken)
        XCTAssertEqual(objcError.rawValue, 0)
    }

    // MARK: - NSError Conversion Tests

    func testInvalidTokenNSError() {
        let errorMessage = "The link token is invalid or has expired"
        let configError = ConfigurationError.invalidToken(message: errorMessage)

        let nsError = configError.nsError

        XCTAssertEqual(nsError.domain, kPLKDefaultErrorDomain)
        XCTAssertEqual(nsError.code, PLKPlaidConfigurationError.invalidToken.rawValue)
        XCTAssertEqual(nsError.userInfo["message"] as? String, errorMessage)
        XCTAssertEqual(nsError.localizedDescription, errorMessage)
    }

    func testInvalidTokenNSErrorWithEmptyMessage() {
        let configError = ConfigurationError.invalidToken(message: "")

        let nsError = configError.nsError

        XCTAssertEqual(nsError.domain, kPLKDefaultErrorDomain)
        XCTAssertEqual(nsError.code, PLKPlaidConfigurationError.invalidToken.rawValue)
        XCTAssertEqual(nsError.userInfo["message"] as? String, "")
        XCTAssertEqual(nsError.localizedDescription, "")
    }

    func testInvalidTokenNSErrorWithLongMessage() {
        let longMessage =
            "This is a very long error message that contains detailed information about why the link token is invalid. It might include information about token expiration, malformed tokens, or other validation errors that occurred during the configuration process."
        let configError = ConfigurationError.invalidToken(message: longMessage)

        let nsError = configError.nsError

        XCTAssertEqual(nsError.domain, kPLKDefaultErrorDomain)
        XCTAssertEqual(nsError.code, PLKPlaidConfigurationError.invalidToken.rawValue)
        XCTAssertEqual(nsError.userInfo["message"] as? String, longMessage)
        XCTAssertEqual(nsError.localizedDescription, longMessage)
    }

    // MARK: - Error Code Raw Value Tests

    func testInvalidTokenRawValue() {
        let error = PLKPlaidConfigurationError.invalidToken
        XCTAssertEqual(error.rawValue, 0)
    }

    // MARK: - Error Domain Tests

    func testErrorDomain() {
        let configError = ConfigurationError.invalidToken(message: "Test message")
        let nsError = configError.nsError

        XCTAssertEqual(nsError.domain, kPLKDefaultErrorDomain)
        XCTAssertNotEqual(nsError.domain, "")
    }
}
