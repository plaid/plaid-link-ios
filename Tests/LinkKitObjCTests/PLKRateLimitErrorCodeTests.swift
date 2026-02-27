import LinkKit
import XCTest

@testable import LinkKitObjC
@testable import LinkKitObjCInternal

final class PLKRateLimitErrorCodeTests: XCTestCase {

    func testAccountsLimitToObjC() {
        let errorCode = RateLimitErrorCode.accountsLimit
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .accountsLimit)
    }

    func testAdditionLimitToObjC() {
        let errorCode = RateLimitErrorCode.additionLimit
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .additionLimit)
    }

    func testAuthLimitToObjC() {
        let errorCode = RateLimitErrorCode.authLimit
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .authLimit)
    }

    func testIdentityLimitToObjC() {
        let errorCode = RateLimitErrorCode.identityLimit
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .identityLimit)
    }

    func testIncomeLimitToObjC() {
        let errorCode = RateLimitErrorCode.incomeLimit
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .incomeLimit)
    }

    func testItemGetLimitToObjC() {
        let errorCode = RateLimitErrorCode.itemGetLimit
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .itemGetLimit)
    }

    func testRateLimitToObjC() {
        let errorCode = RateLimitErrorCode.rateLimit
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .rateLimit)
    }

    func testTransactionsLimitToObjC() {
        let errorCode = RateLimitErrorCode.transactionsLimit
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .transactionsLimit)
    }

    func testUnknownToObjC() {
        let errorCode = RateLimitErrorCode.unknown("CUSTOM_RATE_LIMIT_ERROR")
        let objcErrorCode = errorCode.toObjC
        XCTAssertNil(objcErrorCode)
    }

    func testUnknownWithDifferentStringToObjC() {
        let errorCode = RateLimitErrorCode.unknown("ANOTHER_UNKNOWN_ERROR")
        let objcErrorCode = errorCode.toObjC
        XCTAssertNil(objcErrorCode)
    }

    func testUnknownWithEmptyStringToObjC() {
        let errorCode = RateLimitErrorCode.unknown("")
        let objcErrorCode = errorCode.toObjC
        XCTAssertNil(objcErrorCode)
    }

    func testAllKnownErrorCodesMapToObjC() {
        let testCases: [(RateLimitErrorCode, PLKRateLimitErrorCode)] = [
            (.accountsLimit, .accountsLimit),
            (.additionLimit, .additionLimit),
            (.authLimit, .authLimit),
            (.identityLimit, .identityLimit),
            (.incomeLimit, .incomeLimit),
            (.itemGetLimit, .itemGetLimit),
            (.rateLimit, .rateLimit),
            (.transactionsLimit, .transactionsLimit),
        ]

        for (swiftCode, expectedObjCCode) in testCases {
            let objcCode = swiftCode.toObjC
            XCTAssertEqual(objcCode, expectedObjCCode, "Failed for \(swiftCode)")
        }
    }

    func testToObjCReturnsNilForUnknownDefault() {
        let errorCode = RateLimitErrorCode.unknown("UNHANDLED_ERROR")
        let objcErrorCode = errorCode.toObjC
        XCTAssertNil(objcErrorCode, "Unknown error codes should return nil")
    }
}
