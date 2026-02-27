import LinkKit
import XCTest

@testable import LinkKitObjC
@testable import LinkKitObjCInternal

final class PLKVerificationStatusTests: XCTestCase {

    func testPendingAutomaticVerificationToObjC() {
        let status = VerificationStatus.pendingAutomaticVerification
        let objcStatus = status.toObjC

        XCTAssertEqual(objcStatus.value, .pendingAutomaticVerification)
        XCTAssertNil(objcStatus.unknownStringValue)
    }

    func testPendingManualVerificationToObjC() {
        let status = VerificationStatus.pendingManualVerification
        let objcStatus = status.toObjC

        XCTAssertEqual(objcStatus.value, .pendingManualVerification)
        XCTAssertNil(objcStatus.unknownStringValue)
    }

    func testManuallyVerifiedToObjC() {
        let status = VerificationStatus.manuallyVerified
        let objcStatus = status.toObjC

        XCTAssertEqual(objcStatus.value, .manuallyVerified)
        XCTAssertNil(objcStatus.unknownStringValue)
    }

    func testUnknownStatusToObjC() {
        let status = VerificationStatus.unknown("some_new_verification_status")
        let objcStatus = status.toObjC

        XCTAssertEqual(objcStatus.value, .none)
        XCTAssertNotNil(objcStatus.unknownStringValue)
        XCTAssertEqual(objcStatus.unknownStringValue, "some_new_verification_status")
    }

    func testUnknownStatusWithEmptyStringToObjC() {
        let status = VerificationStatus.unknown("")
        let objcStatus = status.toObjC

        XCTAssertEqual(objcStatus.value, .none)
        XCTAssertNotNil(objcStatus.unknownStringValue)
        XCTAssertEqual(objcStatus.unknownStringValue, "")
    }

    func testUnknownStatusWithComplexStringToObjC() {
        let status = VerificationStatus.unknown("future_verification_type_v2")
        let objcStatus = status.toObjC

        XCTAssertEqual(objcStatus.value, .none)
        XCTAssertNotNil(objcStatus.unknownStringValue)
        XCTAssertEqual(objcStatus.unknownStringValue, "future_verification_type_v2")
    }

    func testAllKnownStatusesMapToValidObjCValues() {
        let knownStatuses: [VerificationStatus] = [
            .pendingAutomaticVerification,
            .pendingManualVerification,
            .manuallyVerified,
        ]

        for status in knownStatuses {
            let objcStatus = status.toObjC
            XCTAssertNotEqual(objcStatus.value, .none)
            XCTAssertNil(objcStatus.unknownStringValue)
        }
    }

    func testVerificationStatusDecodingAndConversion() throws {
        let testCases: [(json: String, expectedValue: PLKVerificationStatusValue, expectedUnknown: String?)] = [
            (
                json: "\"pending_automatic_verification\"",
                expectedValue: .pendingAutomaticVerification,
                expectedUnknown: nil
            ),
            (
                json: "\"pending_manual_verification\"",
                expectedValue: .pendingManualVerification,
                expectedUnknown: nil
            ),
            (
                json: "\"manually_verified\"",
                expectedValue: .manuallyVerified,
                expectedUnknown: nil
            ),
            (
                json: "\"unknown_future_status\"",
                expectedValue: .none,
                expectedUnknown: "unknown_future_status"
            ),
        ]

        for testCase in testCases {
            let data = testCase.json.data(using: .utf8)!
            let decoder = JSONDecoder()
            let status = try decoder.decode(VerificationStatus.self, from: data)
            let objcStatus = status.toObjC

            XCTAssertEqual(objcStatus.value, testCase.expectedValue)
            XCTAssertEqual(objcStatus.unknownStringValue, testCase.expectedUnknown)
        }
    }

    func testMultipleConversionsProduceSameResult() {
        let status = VerificationStatus.pendingAutomaticVerification

        let objcStatus1 = status.toObjC
        let objcStatus2 = status.toObjC

        XCTAssertEqual(objcStatus1.value, objcStatus2.value)
        XCTAssertEqual(objcStatus1.unknownStringValue, objcStatus2.unknownStringValue)
    }

    func testVerificationStatusInAccountContext() throws {
        let jsonString = """
            {
              "id": "acc_test",
              "name": "Test Account",
              "mask": "1234",
              "subtype": "depository.checking",
              "verificationStatus": "pending_automatic_verification"
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let account = try decoder.decode(Account.self, from: data)

        XCTAssertEqual(account.verificationStatus, .pendingAutomaticVerification)

        let objcAccount = account.toObjC
        XCTAssertEqual(objcAccount.verificationStatus?.value, .pendingAutomaticVerification)
        XCTAssertNil(objcAccount.verificationStatus?.unknownStringValue)
    }

    func testVerificationStatusNilInAccountContext() throws {
        let jsonString = """
            {
              "id": "acc_test",
              "name": "Test Account",
              "mask": "1234",
              "subtype": "depository.checking"
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let account = try decoder.decode(Account.self, from: data)

        XCTAssertNil(account.verificationStatus)

        let objcAccount = account.toObjC
        XCTAssertNil(objcAccount.verificationStatus)
    }

    func testVerificationStatusWithDifferentUnknownValues() {
        let unknownValues = [
            "new_status_type_1",
            "future_verification_method",
            "automatically_verified_v2",
            "custom_verification_flow",
        ]

        for unknownValue in unknownValues {
            let status = VerificationStatus.unknown(unknownValue)
            let objcStatus = status.toObjC

            XCTAssertEqual(objcStatus.value, .none)
            XCTAssertEqual(objcStatus.unknownStringValue, unknownValue)
        }
    }

    func testVerificationStatusDescriptionUsedForUnknown() {
        let status = VerificationStatus.unknown("test_status")
        let objcStatus = status.toObjC

        XCTAssertEqual(objcStatus.unknownStringValue, status.description)
    }
}
