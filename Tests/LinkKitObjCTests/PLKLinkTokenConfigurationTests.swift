import LinkKit
import XCTest

@testable import LinkKitObjC
@testable import LinkKitObjCInternal

final class PLKLinkTokenConfigurationTests: XCTestCase {

    func testTokenIsPassedThrough() {
        let config = PLKLinkTokenConfiguration(
            token: "test-token-123",
            onSuccess: { _ in }
        )
        config.onExit = { _ in }
        config.onEvent = { _ in }

        let swiftConfig = config.toSwift
        XCTAssertEqual(swiftConfig.token, "test-token-123")
    }

    func testOnSuccessHandlerIsCalled() throws {
        var capturedObjCSuccess: PLKLinkSuccess?
        let config = PLKLinkTokenConfiguration(
            token: "test-token",
            onSuccess: { success in
                capturedObjCSuccess = success
            }
        )
        config.onExit = { _ in }
        config.onEvent = { _ in }

        let swiftConfig = config.toSwift

        // Create Swift LinkSuccess from JSON
        let jsonString = """
            {
              "public_token": "public-token-123",
              "metadata": {
                "institution": {
                  "id": "ins_123",
                  "name": "Test Bank"
                },
                "accounts": [
                  {
                    "id": "acc_1",
                    "name": "Checking",
                    "mask": "1234",
                    "subtype": "depository.checking"
                  }
                ],
                "link_session_id": "session_123"
              }
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let linkSuccess = try decoder.decode(LinkSuccess.self, from: data)

        // Call the Swift onSuccess handler
        swiftConfig.onSuccess(linkSuccess)

        // Verify ObjC handler was called with converted data
        XCTAssertNotNil(capturedObjCSuccess)
        XCTAssertEqual(capturedObjCSuccess?.publicToken, "public-token-123")
        XCTAssertEqual(capturedObjCSuccess?.metadata.linkSessionID, "session_123")
        XCTAssertEqual(capturedObjCSuccess?.metadata.institution.id, "ins_123")
        XCTAssertEqual(capturedObjCSuccess?.metadata.institution.name, "Test Bank")
        XCTAssertEqual(capturedObjCSuccess?.metadata.accounts.count, 1)
        XCTAssertEqual(capturedObjCSuccess?.metadata.accounts.first?.id, "acc_1")
        XCTAssertEqual(capturedObjCSuccess?.metadata.accounts.first?.name, "Checking")
        XCTAssertEqual(capturedObjCSuccess?.metadata.accounts.first?.mask, "1234")
    }

    func testOnExitHandlerIsCalled() throws {
        var capturedObjCExit: PLKLinkExit?
        let config = PLKLinkTokenConfiguration(
            token: "test-token",
            onSuccess: { _ in }
        )
        config.onExit = { exit in
            capturedObjCExit = exit
        }
        config.onEvent = { _ in }

        let swiftConfig = config.toSwift

        // Create Swift LinkExit from JSON
        let jsonString = """
            {
              "error": {
                "errorCode": {
                  "type": "ITEM_ERROR",
                  "code": "ITEM_LOGIN_REQUIRED"
                },
                "errorMessage": "Item login required",
                "displayMessage": "Please log in again"
              },
              "metadata": {
                "status": "requires_credentials",
                "institution": {
                  "id": "ins_123",
                  "name": "Test Bank"
                },
                "link_session_id": "session_123",
                "request_id": "req_123"
              }
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let linkExit = try decoder.decode(LinkExit.self, from: data)

        // Call the Swift onExit handler
        swiftConfig.onExit?(linkExit)

        // Verify ObjC handler was called with converted data
        XCTAssertNotNil(capturedObjCExit)
        XCTAssertEqual(capturedObjCExit?.metadata.linkSessionID, "session_123")
        XCTAssertEqual(capturedObjCExit?.metadata.requestID, "req_123")
        XCTAssertEqual(capturedObjCExit?.metadata.institution?.id, "ins_123")
        XCTAssertEqual(capturedObjCExit?.metadata.institution?.name, "Test Bank")
        XCTAssertNotNil(capturedObjCExit?.error)
        XCTAssertEqual(capturedObjCExit?.error?.localizedDescription, "Please log in again")
    }

    func testOnEventHandlerIsCalled() throws {
        var capturedObjCEvent: PLKLinkEvent?
        let config = PLKLinkTokenConfiguration(
            token: "test-token",
            onSuccess: { _ in }
        )
        config.onExit = { _ in }
        config.onEvent = { event in
            capturedObjCEvent = event
        }

        let swiftConfig = config.toSwift

        // Create Swift LinkEvent from JSON
        let jsonString = """
            {
              "event_name": "OPEN",
              "metadata": {
                "link_session_id": "session_123",
                "request_id": "req_123",
                "institution_id": "ins_123",
                "institution_name": "Test Bank",
                "view_name": "SELECT_INSTITUTION",
                "timestamp": "2024-01-21T12:00:00.000Z"
              }
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let linkEvent = try decoder.decode(LinkEvent.self, from: data)

        // Call the Swift onEvent handler
        swiftConfig.onEvent?(linkEvent)

        // Verify ObjC handler was called with converted data
        XCTAssertNotNil(capturedObjCEvent)
        XCTAssertEqual(capturedObjCEvent?.eventName.value, .open)
        XCTAssertEqual(capturedObjCEvent?.eventMetadata.linkSessionID, "session_123")
        XCTAssertEqual(capturedObjCEvent?.eventMetadata.requestID, "req_123")
        XCTAssertEqual(capturedObjCEvent?.eventMetadata.institutionID, "ins_123")
        XCTAssertEqual(capturedObjCEvent?.eventMetadata.institutionName, "Test Bank")
    }

    func testOnLoadHandlerIsCalled() {
        var onLoadCalled = false
        let config = PLKLinkTokenConfiguration(
            token: "test-token",
            onSuccess: { _ in }
        )
        config.onExit = { _ in }
        config.onEvent = { _ in }
        config.onLoad = {
            onLoadCalled = true
        }

        let swiftConfig = config.toSwift

        // Call the Swift onLoad handler
        swiftConfig.onLoad?()

        // Verify ObjC handler was called
        XCTAssertTrue(onLoadCalled)
    }

    func testOnLoadHandlerIsOptional() {
        let config = PLKLinkTokenConfiguration(
            token: "test-token",
            onSuccess: { _ in }
        )
        config.onExit = { _ in }
        config.onEvent = { _ in }
        // Don't set onLoad

        let swiftConfig = config.toSwift

        // Verify onLoad handler exists but doesn't crash when called
        XCTAssertNotNil(swiftConfig.onLoad)
        swiftConfig.onLoad?()
    }

    func testAllHandlersWorkTogether() throws {
        var successCalled = false
        var exitCalled = false
        var eventCalled = false
        var loadCalled = false

        let config = PLKLinkTokenConfiguration(
            token: "test-token-all",
            onSuccess: { _ in successCalled = true }
        )
        config.onExit = { _ in exitCalled = true }
        config.onEvent = { _ in eventCalled = true }
        config.onLoad = { loadCalled = true }

        let swiftConfig = config.toSwift

        // Test onLoad
        swiftConfig.onLoad?()
        XCTAssertTrue(loadCalled)

        // Test onSuccess
        let successJSON = """
            {
              "public_token": "token",
              "metadata": {
                "institution": {"id": "ins", "name": "Bank"},
                "accounts": [{"id": "acc", "name": "Account", "subtype": "depository.checking"}],
                "link_session_id": "session"
              }
            }
            """
        let successData = successJSON.data(using: .utf8)!
        let linkSuccess = try JSONDecoder().decode(LinkSuccess.self, from: successData)
        swiftConfig.onSuccess(linkSuccess)
        XCTAssertTrue(successCalled)

        // Test onExit
        let exitJSON = """
            {
              "metadata": {
                "linkSessionID": "session",
                "requestID": "req"
              }
            }
            """
        let exitData = exitJSON.data(using: .utf8)!
        let linkExit = try JSONDecoder().decode(LinkExit.self, from: exitData)
        swiftConfig.onExit?(linkExit)
        XCTAssertTrue(exitCalled)

        // Test onEvent
        let eventJSON = """
            {
              "event_name": "OPEN",
              "metadata": {
                "link_session_id": "session",
                "request_id": "req",
                "timestamp": "2024-01-21T12:00:00.000Z"
              }
            }
            """
        let eventData = eventJSON.data(using: .utf8)!
        let linkEvent = try JSONDecoder().decode(LinkEvent.self, from: eventData)
        swiftConfig.onEvent?(linkEvent)
        XCTAssertTrue(eventCalled)
    }
}
