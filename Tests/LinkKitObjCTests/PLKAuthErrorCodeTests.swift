import LinkKit
import XCTest

@testable import LinkKitObjC

final class PLKAuthErrorCodeTests: XCTestCase {

    func testProductNotReadyToObjC() {
        let errorCode = AuthErrorCode.productNotReady
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .productNotReady)
    }

    func testVerificationExpiredToObjC() {
        let errorCode = AuthErrorCode.verificationExpired
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .verificationExpired)
    }

    func testUnknownToObjC() {
        let errorCode = AuthErrorCode.unknown("CUSTOM_AUTH_ERROR")
        let objcErrorCode = errorCode.toObjC
        XCTAssertNil(objcErrorCode)
    }
}
