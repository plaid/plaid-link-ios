import LinkKit
import XCTest

@testable import LinkKitObjC

final class PLKInvalidRequestErrorCodeTests: XCTestCase {

    func testMissingFieldsToObjC() {
        let errorCode = InvalidRequestErrorCode.missingFields
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .missingFields)
    }

    func testUnknownFieldsToObjC() {
        let errorCode = InvalidRequestErrorCode.unknownFields
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .unknownFields)
    }

    func testInvalidFieldToObjC() {
        let errorCode = InvalidRequestErrorCode.invalidField
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .invalidField)
    }

    func testInvalidBodyToObjC() {
        let errorCode = InvalidRequestErrorCode.invalidBody
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .invalidBody)
    }

    func testInvalidAddressToObjC() {
        let errorCode = InvalidRequestErrorCode.invalidAddress
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .invalidAddress)
    }

    func testNotFoundToObjC() {
        let errorCode = InvalidRequestErrorCode.notFound
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .notFound)
    }

    func testSandboxOnlyToObjC() {
        let errorCode = InvalidRequestErrorCode.sandboxOnly
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .sandboxOnly)
    }

    func testUnknownToObjC() {
        let errorCode = InvalidRequestErrorCode.unknown("CUSTOM_INVALID_REQUEST_ERROR")
        let objcErrorCode = errorCode.toObjC
        XCTAssertNil(objcErrorCode)
    }
}
