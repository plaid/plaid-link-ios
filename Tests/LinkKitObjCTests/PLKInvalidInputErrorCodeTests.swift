import LinkKit
import XCTest

@testable import LinkKitObjC

final class PLKInvalidInputErrorCodeTests: XCTestCase {

    func testInvalidApiKeysToObjC() {
        let errorCode = InvalidInputErrorCode.invalidApiKeys
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .invalidApiKeys)
    }

    func testUnauthorizedEnvironmentToObjC() {
        let errorCode = InvalidInputErrorCode.unauthorizedEnvironment
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .unauthorizedEnvironment)
    }

    func testInvalidAccessTokenToObjC() {
        let errorCode = InvalidInputErrorCode.invalidAccessToken
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .invalidAccessToken)
    }

    func testInvalidPublicTokenToObjC() {
        let errorCode = InvalidInputErrorCode.invalidPublicToken
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .invalidPublicToken)
    }

    func testInvalidProductToObjC() {
        let errorCode = InvalidInputErrorCode.invalidProduct
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .invalidProduct)
    }

    func testInvalidAccountIdToObjC() {
        let errorCode = InvalidInputErrorCode.invalidAccountId
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .invalidAccountId)
    }

    func testInvalidInstitutionToObjC() {
        let errorCode = InvalidInputErrorCode.invalidInstitution
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .invalidInstitution)
    }

    func testTooManyVerificationAttemptsToObjC() {
        let errorCode = InvalidInputErrorCode.tooManyVerificationAttempts
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .tooManyVerificationAttempts)
    }

    func testUnknownToObjC() {
        let errorCode = InvalidInputErrorCode.unknown("CUSTOM_ERROR")
        let objcErrorCode = errorCode.toObjC
        XCTAssertNil(objcErrorCode)
    }

    func testAllKnownErrorCodesMapToObjC() {
        let knownErrorCodes: [InvalidInputErrorCode] = [
            .invalidApiKeys,
            .unauthorizedEnvironment,
            .invalidAccessToken,
            .invalidPublicToken,
            .invalidProduct,
            .invalidAccountId,
            .invalidInstitution,
            .tooManyVerificationAttempts,
        ]

        for errorCode in knownErrorCodes {
            let objcErrorCode = errorCode.toObjC
            XCTAssertNotNil(objcErrorCode, "Error code '\(errorCode.description)' should have a valid ObjC mapping")
        }
    }
}
