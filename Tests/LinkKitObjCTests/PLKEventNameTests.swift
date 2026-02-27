import LinkKit
import XCTest

@testable import LinkKitObjC
@testable import LinkKitObjCInternal

final class PLKEventNameTests: XCTestCase {

    // MARK: - Specific Conversion Tests

    func testOpenToObjC() {
        let eventName = EventName.open
        let objcEventName = eventName.toObjC
        XCTAssertEqual(objcEventName.value, .open)
    }

    func testCloseOAuthToObjC() {
        let eventName = EventName.closeOAuth
        let objcEventName = eventName.toObjC
        XCTAssertEqual(objcEventName.value, .closeOAuth)
    }

    func testErrorToObjC() {
        let eventName = EventName.error
        let objcEventName = eventName.toObjC
        XCTAssertEqual(objcEventName.value, .error)
    }

    func testExitToObjC() {
        let eventName = EventName.exit
        let objcEventName = eventName.toObjC
        XCTAssertEqual(objcEventName.value, .exit)
    }

    func testHandoffToObjC() {
        let eventName = EventName.handoff
        let objcEventName = eventName.toObjC
        XCTAssertEqual(objcEventName.value, .handoff)
    }

    func testSelectInstitutionToObjC() {
        let eventName = EventName.selectInstitution
        let objcEventName = eventName.toObjC
        XCTAssertEqual(objcEventName.value, .selectInstitution)
    }

    func testSubmitCredentialsToObjC() {
        let eventName = EventName.submitCredentials
        let objcEventName = eventName.toObjC
        XCTAssertEqual(objcEventName.value, .submitCredentials)
    }

    func testTransitionViewToObjC() {
        let eventName = EventName.transitionView
        let objcEventName = eventName.toObjC
        XCTAssertEqual(objcEventName.value, .transitionView)
    }

    func testUnknownToObjC() {
        let eventName = EventName.unknown("CUSTOM_EVENT")
        let objcEventName = eventName.toObjC
        XCTAssertEqual(objcEventName.value, .none)
        XCTAssertEqual(objcEventName.unknownStringValue, "CUSTOM_EVENT")
    }

    // MARK: - Comprehensive Mapping Tests

    func testAllKnownEventNamesHaveObjCMapping() {
        for eventName in EventName.allCases {
            let objcEventName = eventName.toObjC

            // All known cases should have a valid ObjC mapping (not PLKEventNameValueNone)
            XCTAssertNotEqual(
                objcEventName.value,
                PLKEventNameValue.none,
                "Event '\(eventName)' must have a valid ObjC mapping, but got .none"
            )
        }
    }

    func testSelectSavedInstitutionMapping() {
        let eventName = EventName.selectSavedInstitution
        let objcEventName = eventName.toObjC
        XCTAssertEqual(objcEventName.value, .selectSavedInstitution)
    }

    func testMultipleSwiftCasesCanMapToSameObjCValue() {
        // Some Swift cases intentionally map to the same ObjC value
        // For example, selectDegradedInstitution, selectDownInstitution, and selectInstitution
        // all map to .selectInstitution in ObjC

        let degraded = EventName.selectDegradedInstitution.toObjC
        let down = EventName.selectDownInstitution.toObjC
        let normal = EventName.selectInstitution.toObjC

        XCTAssertEqual(degraded.value, .selectInstitution)
        XCTAssertEqual(down.value, .selectInstitution)
        XCTAssertEqual(normal.value, .selectInstitution)
    }
}
