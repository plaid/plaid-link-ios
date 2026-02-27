import LinkKit
import XCTest

@testable import LinkKitObjC
@testable import LinkKitObjCInternal

final class PLKExitStatusTests: XCTestCase {

    // MARK: - Specific Conversion Tests

    func testRequiresQuestionsToObjC() {
        let exitStatus = ExitStatus.requiresQuestions
        let objcExitStatus = exitStatus.toObjC
        XCTAssertEqual(objcExitStatus.value, .requiresQuestions)
    }

    func testRequiresSelectionsToObjC() {
        let exitStatus = ExitStatus.requiresSelections
        let objcExitStatus = exitStatus.toObjC
        XCTAssertEqual(objcExitStatus.value, .requiresSelections)
    }

    func testRequiresCodeToObjC() {
        let exitStatus = ExitStatus.requiresCode
        let objcExitStatus = exitStatus.toObjC
        XCTAssertEqual(objcExitStatus.value, .requiresCode)
    }

    func testChooseDeviceToObjC() {
        let exitStatus = ExitStatus.chooseDevice
        let objcExitStatus = exitStatus.toObjC
        XCTAssertEqual(objcExitStatus.value, .chooseDevice)
    }

    func testRequiresCredentialsToObjC() {
        let exitStatus = ExitStatus.requiresCredentials
        let objcExitStatus = exitStatus.toObjC
        XCTAssertEqual(objcExitStatus.value, .requiresCredentials)
    }

    func testInstitutionNotFoundToObjC() {
        let exitStatus = ExitStatus.institutionNotFound
        let objcExitStatus = exitStatus.toObjC
        XCTAssertEqual(objcExitStatus.value, .institutionNotFound)
    }

    func testRequiresAccountSelectionToObjC() {
        let exitStatus = ExitStatus.requiresAccountSelection
        let objcExitStatus = exitStatus.toObjC
        XCTAssertEqual(objcExitStatus.value, .requiresAccountSelection)
    }

    func testContinueToThirdPartyToObjC() {
        let exitStatus = ExitStatus.continueToThirdParty
        let objcExitStatus = exitStatus.toObjC
        // NOTE: There's a typo in the ObjC enum: "continueToThridParty" (missing 'i')
        XCTAssertEqual(objcExitStatus.value, .continueToThridParty)
    }

    func testUnknownToObjC() {
        let exitStatus = ExitStatus.unknown("custom_exit_status")
        let objcExitStatus = exitStatus.toObjC
        XCTAssertEqual(objcExitStatus.value, .none)
        XCTAssertEqual(objcExitStatus.unknownStringValue, "custom_exit_status")
    }

    func testAllKnownExitStatusesMapToValidObjCValues() {
        // Test all known exit status cases convert successfully
        let knownStatuses: [ExitStatus] = [
            .requiresQuestions,
            .requiresSelections,
            .requiresCode,
            .chooseDevice,
            .requiresCredentials,
            .institutionNotFound,
            .requiresAccountSelection,
            .continueToThirdParty,
        ]

        for exitStatus in knownStatuses {
            let objcExitStatus = exitStatus.toObjC
            XCTAssertNotEqual(
                objcExitStatus.value,
                .none,
                "Status '\(exitStatus.description)' should have a valid ObjC mapping"
            )
            XCTAssertNil(
                objcExitStatus.unknownStringValue,
                "Known status '\(exitStatus.description)' should not have unknownStringValue"
            )
        }
    }

    func testOneToOneMappingBetweenSwiftAndObjC() {
        // Verify that all 8 known Swift cases map to distinct ObjC values
        let mappings: [(ExitStatus, PLKExitStatusValue)] = [
            (.requiresQuestions, .requiresQuestions),
            (.requiresSelections, .requiresSelections),
            (.requiresCode, .requiresCode),
            (.chooseDevice, .chooseDevice),
            (.requiresCredentials, .requiresCredentials),
            (.institutionNotFound, .institutionNotFound),
            (.requiresAccountSelection, .requiresAccountSelection),
            (.continueToThirdParty, .continueToThridParty),
        ]

        for (swiftStatus, expectedObjCValue) in mappings {
            let objcStatus = swiftStatus.toObjC
            XCTAssertEqual(
                objcStatus.value,
                expectedObjCValue,
                "Status '\(swiftStatus.description)' should map to '\(expectedObjCValue.rawValue)'"
            )
        }
    }
}
