import LinkKit
import XCTest

@testable import LinkKitObjC

final class PLKLinkEventTests: XCTestCase {

    func testLinkEventToObjCWithOpenEvent() throws {
        let jsonString = """
            {
              "event_name": "OPEN",
              "metadata": {
                "link_session_id": "session_123",
                "timestamp": "2024-01-21T12:00:00.000Z"
              }
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let linkEvent = try decoder.decode(LinkEvent.self, from: data)

        let objcLinkEvent = linkEvent.toObjC

        XCTAssertEqual(objcLinkEvent.eventName.value, .open)
        XCTAssertEqual(objcLinkEvent.eventMetadata.linkSessionID, "session_123")
    }

    func testLinkEventToObjCWithSelectInstitutionEvent() throws {
        let jsonString = """
            {
              "event_name": "SELECT_INSTITUTION",
              "metadata": {
                "link_session_id": "session_456",
                "institution_id": "ins_123",
                "institution_name": "Test Bank",
                "timestamp": "2024-01-21T12:05:00.000Z"
              }
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let linkEvent = try decoder.decode(LinkEvent.self, from: data)

        let objcLinkEvent = linkEvent.toObjC

        XCTAssertEqual(objcLinkEvent.eventName.value, .selectInstitution)
        XCTAssertEqual(objcLinkEvent.eventMetadata.linkSessionID, "session_456")
        XCTAssertEqual(objcLinkEvent.eventMetadata.institutionID, "ins_123")
        XCTAssertEqual(objcLinkEvent.eventMetadata.institutionName, "Test Bank")
    }

    func testLinkEventToObjCWithErrorEvent() throws {
        let jsonString = """
            {
              "event_name": "ERROR",
              "metadata": {
                "link_session_id": "session_789",
                "error_code": {
                  "type": "ITEM_ERROR",
                  "code": "ITEM_LOGIN_REQUIRED"
                },
                "error_message": "Item login required",
                "timestamp": "2024-01-21T12:10:00.000Z"
              }
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let linkEvent = try decoder.decode(LinkEvent.self, from: data)

        let objcLinkEvent = linkEvent.toObjC

        XCTAssertEqual(objcLinkEvent.eventName.value, .error)
        XCTAssertEqual(objcLinkEvent.eventMetadata.linkSessionID, "session_789")
        XCTAssertNotNil(objcLinkEvent.eventMetadata.error)
    }

    func testLinkEventToObjCWithSubmitCredentialsEvent() throws {
        let jsonString = """
            {
              "event_name": "SUBMIT_CREDENTIALS",
              "metadata": {
                "link_session_id": "session_999",
                "institution_id": "ins_999",
                "institution_name": "Another Bank",
                "timestamp": "2024-01-21T12:15:00.000Z"
              }
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let linkEvent = try decoder.decode(LinkEvent.self, from: data)

        let objcLinkEvent = linkEvent.toObjC

        XCTAssertEqual(objcLinkEvent.eventName.value, .submitCredentials)
        XCTAssertEqual(objcLinkEvent.eventMetadata.linkSessionID, "session_999")
        XCTAssertEqual(objcLinkEvent.eventMetadata.institutionID, "ins_999")
        XCTAssertEqual(objcLinkEvent.eventMetadata.institutionName, "Another Bank")
    }

    func testLinkEventToObjCPreservesAllMetadata() throws {
        let jsonString = """
            {
              "event_name": "TRANSITION_VIEW",
              "metadata": {
                "link_session_id": "session_complete",
                "request_id": "req_123",
                "institution_id": "ins_final",
                "institution_name": "Final Bank",
                "view_name": "CONNECTED",
                "timestamp": "2024-01-21T12:20:00.000Z"
              }
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let linkEvent = try decoder.decode(LinkEvent.self, from: data)

        let objcLinkEvent = linkEvent.toObjC

        XCTAssertEqual(objcLinkEvent.eventName.value, .transitionView)
        XCTAssertEqual(objcLinkEvent.eventMetadata.linkSessionID, "session_complete")
        XCTAssertEqual(objcLinkEvent.eventMetadata.requestID, "req_123")
        XCTAssertEqual(objcLinkEvent.eventMetadata.institutionID, "ins_final")
        XCTAssertEqual(objcLinkEvent.eventMetadata.institutionName, "Final Bank")
        XCTAssertNotNil(objcLinkEvent.eventMetadata.viewName)
    }
}
