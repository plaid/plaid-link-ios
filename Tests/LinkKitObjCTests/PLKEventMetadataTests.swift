import LinkKit
import XCTest

@testable import LinkKitObjC
@testable import LinkKitObjCInternal

final class PLKEventMetadataTests: XCTestCase {

    func testEventMetadataWithAllFieldsToObjC() throws {
        let jsonString = """
            {
              "link_session_id": "session_123",
              "timestamp": "2024-01-21T12:00:00.000Z",
              "institution_id": "ins_123",
              "institution_name": "Test Bank",
              "institution_search_query": "test bank",
              "request_id": "req_123",
              "error_code": {
                "type": "ITEM_ERROR",
                "code": "ITEM_LOGIN_REQUIRED"
              },
              "error_message": "Item login required",
              "exit_status": "requires_credentials",
              "mfa_type": "code",
              "view_name": "CREDENTIAL",
              "account_number_mask": "1234",
              "is_update_mode": "true",
              "match_reason": "returning_user",
              "routing_number": "021000021",
              "selection": "phoneotp",
              "issue_id": "issue_123",
              "issue_description": "Test issue",
              "issue_detected_at": "2024-01-21T11:30:00.000Z",
              "metadata_json": "{\\"custom\\":\\"data\\"}"
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let eventMetadata = try decoder.decode(EventMetadata.self, from: data)

        XCTAssertEqual(eventMetadata.linkSessionID, "session_123")
        XCTAssertEqual(eventMetadata.institutionID, "ins_123")
        XCTAssertEqual(eventMetadata.institutionName, "Test Bank")
        XCTAssertEqual(eventMetadata.institutionSearchQuery, "test bank")
        XCTAssertEqual(eventMetadata.requestID, "req_123")
        XCTAssertEqual(eventMetadata.errorMessage, "Item login required")
        XCTAssertEqual(eventMetadata.exitStatus, .requiresCredentials)
        XCTAssertEqual(eventMetadata.mfaType, .code)
        XCTAssertEqual(eventMetadata.viewName, .credential)
        XCTAssertEqual(eventMetadata.accountNumberMask, "1234")
        XCTAssertEqual(eventMetadata.isUpdateMode, "true")
        XCTAssertEqual(eventMetadata.matchReason, "returning_user")
        XCTAssertEqual(eventMetadata.routingNumber, "021000021")
        XCTAssertEqual(eventMetadata.selection, "phoneotp")
        XCTAssertEqual(eventMetadata.issueID, "issue_123")
        XCTAssertEqual(eventMetadata.issueDescription, "Test issue")
        XCTAssertNotNil(eventMetadata.issueDetectedAt)
        XCTAssertEqual(eventMetadata.metadataJSON, "{\"custom\":\"data\"}")

        let objcEventMetadata = eventMetadata.toObjC

        XCTAssertEqual(objcEventMetadata.linkSessionID, eventMetadata.linkSessionID)
        XCTAssertEqual(objcEventMetadata.institutionID, eventMetadata.institutionID)
        XCTAssertEqual(objcEventMetadata.institutionName, eventMetadata.institutionName)
        XCTAssertEqual(objcEventMetadata.institutionSearchQuery, eventMetadata.institutionSearchQuery)
        XCTAssertEqual(objcEventMetadata.requestID, eventMetadata.requestID)
        XCTAssertEqual(objcEventMetadata.accountNumberMask, eventMetadata.accountNumberMask)
        XCTAssertEqual(objcEventMetadata.isUpdateMode, eventMetadata.isUpdateMode)
        XCTAssertEqual(objcEventMetadata.matchReason, eventMetadata.matchReason)
        XCTAssertEqual(objcEventMetadata.routingNumber, eventMetadata.routingNumber)
        XCTAssertEqual(objcEventMetadata.selection, eventMetadata.selection)
        XCTAssertEqual(objcEventMetadata.issueID, eventMetadata.issueID)
        XCTAssertEqual(objcEventMetadata.issueDescription, eventMetadata.issueDescription)
        XCTAssertEqual(objcEventMetadata.issueDetectedAt, eventMetadata.issueDetectedAt)
        XCTAssertEqual(objcEventMetadata.metadataJSON, eventMetadata.metadataJSON)
        XCTAssertEqual(objcEventMetadata.timestamp, eventMetadata.timestamp)
        XCTAssertNotNil(objcEventMetadata.error)
        XCTAssertEqual(objcEventMetadata.mfaType, .code)
        XCTAssertEqual(objcEventMetadata.exitStatus?.value, .requiresCredentials)
        XCTAssertEqual(objcEventMetadata.viewName?.value, .credential)
    }

    func testEventMetadataWithMinimalFieldsToObjC() throws {
        let jsonString = """
            {
              "link_session_id": "session_minimal",
              "timestamp": "2024-01-21T12:00:00.000Z"
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let eventMetadata = try decoder.decode(EventMetadata.self, from: data)

        XCTAssertEqual(eventMetadata.linkSessionID, "session_minimal")
        XCTAssertNotNil(eventMetadata.timestamp)
        XCTAssertNil(eventMetadata.institutionID)
        XCTAssertNil(eventMetadata.institutionName)
        XCTAssertNil(eventMetadata.errorCode)
        XCTAssertNil(eventMetadata.errorMessage)
        XCTAssertNil(eventMetadata.exitStatus)
        XCTAssertNil(eventMetadata.mfaType)
        XCTAssertNil(eventMetadata.viewName)

        let objcEventMetadata = eventMetadata.toObjC

        XCTAssertEqual(objcEventMetadata.linkSessionID, "session_minimal")
        XCTAssertEqual(objcEventMetadata.timestamp, eventMetadata.timestamp)
        XCTAssertNil(objcEventMetadata.institutionID)
        XCTAssertNil(objcEventMetadata.institutionName)
        XCTAssertNil(objcEventMetadata.error)
        XCTAssertNil(objcEventMetadata.exitStatus)
        XCTAssertEqual(objcEventMetadata.mfaType, .none)
        XCTAssertNil(objcEventMetadata.viewName)
    }

    func testEventMetadataWithMFATypesToObjC() throws {
        let testCases: [(String, MFAType, PLKMFAType)] = [
            ("code", .code, .code),
            ("device", .device, .device),
            ("questions", .questions, .questions),
            ("selections", .selections, .selections),
        ]

        for (jsonValue, swiftValue, objcValue) in testCases {
            let jsonString = """
                {
                  "link_session_id": "session_mfa_test",
                  "timestamp": "2024-01-21T12:00:00.000Z",
                  "mfa_type": "\(jsonValue)"
                }
                """

            let data = jsonString.data(using: .utf8)!
            let decoder = JSONDecoder()
            let eventMetadata = try decoder.decode(EventMetadata.self, from: data)

            XCTAssertEqual(eventMetadata.mfaType, swiftValue)

            let objcEventMetadata = eventMetadata.toObjC
            XCTAssertEqual(objcEventMetadata.mfaType, objcValue)
        }
    }

    func testEventMetadataWithExitStatusToObjC() throws {
        let testCases: [(String, ExitStatus, PLKExitStatusValue)] = [
            ("requires_questions", .requiresQuestions, .requiresQuestions),
            ("requires_selections", .requiresSelections, .requiresSelections),
            ("requires_code", .requiresCode, .requiresCode),
            ("choose_device", .chooseDevice, .chooseDevice),
            ("requires_credentials", .requiresCredentials, .requiresCredentials),
            ("institution_not_found", .institutionNotFound, .institutionNotFound),
            ("requires_account_selection", .requiresAccountSelection, .requiresAccountSelection),
        ]

        for (jsonValue, swiftValue, objcValue) in testCases {
            let jsonString = """
                {
                  "link_session_id": "session_exit_test",
                  "timestamp": "2024-01-21T12:00:00.000Z",
                  "exit_status": "\(jsonValue)"
                }
                """

            let data = jsonString.data(using: .utf8)!
            let decoder = JSONDecoder()
            let eventMetadata = try decoder.decode(EventMetadata.self, from: data)

            XCTAssertEqual(eventMetadata.exitStatus, swiftValue)

            let objcEventMetadata = eventMetadata.toObjC
            XCTAssertEqual(objcEventMetadata.exitStatus?.value, objcValue)
        }
    }

    func testEventMetadataWithViewNameToObjC() throws {
        let testCases: [(String, ViewName, PLKViewNameValue)] = [
            ("CONNECTED", .connected, .connected),
            ("CONSENT", .consent, .consent),
            ("CREDENTIAL", .credential, .credential),
            ("ERROR", .error, .error),
            ("EXIT", .exit, .exit),
            ("LOADING", .loading, .loading),
            ("MFA", .mfa, .MFA),
            ("SELECT_ACCOUNT", .selectAccount, .selectAccount),
            ("SELECT_INSTITUTION", .selectInstitution, .selectInstitution),
        ]

        for (jsonValue, swiftValue, objcValue) in testCases {
            let jsonString = """
                {
                  "link_session_id": "session_view_test",
                  "timestamp": "2024-01-21T12:00:00.000Z",
                  "view_name": "\(jsonValue)"
                }
                """

            let data = jsonString.data(using: .utf8)!
            let decoder = JSONDecoder()
            let eventMetadata = try decoder.decode(EventMetadata.self, from: data)

            XCTAssertEqual(eventMetadata.viewName, swiftValue)

            let objcEventMetadata = eventMetadata.toObjC
            XCTAssertEqual(objcEventMetadata.viewName?.value, objcValue)
        }
    }

    func testEventMetadataWithErrorCodeToObjC() throws {
        let jsonString = """
            {
              "link_session_id": "session_error",
              "timestamp": "2024-01-21T12:00:00.000Z",
              "error_code": {
                "type": "ITEM_ERROR",
                "code": "ITEM_LOGIN_REQUIRED"
              },
              "error_message": "Login credentials are invalid"
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let eventMetadata = try decoder.decode(EventMetadata.self, from: data)

        XCTAssertNotNil(eventMetadata.errorCode)
        XCTAssertEqual(eventMetadata.errorMessage, "Login credentials are invalid")

        let objcEventMetadata = eventMetadata.toObjC

        let error = try XCTUnwrap(objcEventMetadata.error as NSError?, "Error should not be nil")
        let errorMessage = error.userInfo[kPLKExitErrorMessageKey] as? String
        XCTAssertEqual(errorMessage, "Login credentials are invalid")
    }

    func testEventMetadataWithIssueDatesToObjC() throws {
        let jsonString = """
            {
              "link_session_id": "session_issue",
              "timestamp": "2024-01-21T12:00:00.000Z",
              "issue_id": "known_issue_123",
              "issue_description": "Institution is experiencing downtime",
              "issue_detected_at": "2024-01-21T10:00:00.000Z"
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let eventMetadata = try decoder.decode(EventMetadata.self, from: data)

        XCTAssertEqual(eventMetadata.issueID, "known_issue_123")
        XCTAssertEqual(eventMetadata.issueDescription, "Institution is experiencing downtime")
        XCTAssertNotNil(eventMetadata.issueDetectedAt)

        let objcEventMetadata = eventMetadata.toObjC

        XCTAssertEqual(objcEventMetadata.issueID, "known_issue_123")
        XCTAssertEqual(objcEventMetadata.issueDescription, "Institution is experiencing downtime")
        XCTAssertEqual(objcEventMetadata.issueDetectedAt, eventMetadata.issueDetectedAt)
    }

    func testEventMetadataWithNullErrorCodeToObjC() throws {
        let jsonString = """
            {
              "link_session_id": "session_no_error",
              "timestamp": "2024-01-21T12:00:00.000Z",
              "institution_id": "ins_123"
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let eventMetadata = try decoder.decode(EventMetadata.self, from: data)

        XCTAssertNil(eventMetadata.errorCode)
        XCTAssertNil(eventMetadata.errorMessage)

        let objcEventMetadata = eventMetadata.toObjC

        XCTAssertNil(objcEventMetadata.error)
    }
}
