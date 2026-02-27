import LinkKit
import XCTest

@testable import LinkKitObjC
@testable import LinkKitObjCInternal

final class PLKLinkExitTests: XCTestCase {

    func testLinkExitWithErrorAndMetadataToObjC() throws {
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

        XCTAssertNotNil(linkExit.error)
        XCTAssertEqual(linkExit.error?.errorMessage, "Item login required")
        XCTAssertEqual(linkExit.metadata.linkSessionID, "session_123")
        XCTAssertEqual(linkExit.metadata.requestID, "req_123")
        XCTAssertEqual(linkExit.metadata.institution?.id, "ins_123")
        XCTAssertEqual(linkExit.metadata.institution?.name, "Test Bank")
        XCTAssertEqual(linkExit.metadata.status, .requiresCredentials)

        let objcLinkExit = linkExit.toObjC

        XCTAssertNotNil(objcLinkExit.error)

        let nsError = objcLinkExit.error as? NSError

        XCTAssertEqual(nsError?.domain, kPLKExitErrorItemDomain)
        XCTAssertEqual(nsError?.userInfo[kPLKExitErrorMessageKey] as? String, "Item login required")
        XCTAssertEqual(nsError?.localizedDescription, "Please log in again")
        XCTAssertEqual(objcLinkExit.metadata.linkSessionID, "session_123")
        XCTAssertEqual(objcLinkExit.metadata.requestID, "req_123")
        XCTAssertEqual(objcLinkExit.metadata.institution?.id, "ins_123")
        XCTAssertEqual(objcLinkExit.metadata.institution?.name, "Test Bank")
        XCTAssertEqual(objcLinkExit.metadata.status?.value, .requiresCredentials)
    }

    func testLinkExitWithoutErrorToObjC() throws {
        let jsonString = """
            {
              "metadata": {
                "link_session_id": "session_no_error",
                "request_id": "req_no_error"
              }
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let linkExit = try decoder.decode(LinkExit.self, from: data)

        XCTAssertNil(linkExit.error)
        XCTAssertEqual(linkExit.metadata.linkSessionID, "session_no_error")
        XCTAssertEqual(linkExit.metadata.requestID, "req_no_error")

        let objcLinkExit = linkExit.toObjC

        XCTAssertNil(objcLinkExit.error)
        XCTAssertEqual(objcLinkExit.metadata.linkSessionID, "session_no_error")
        XCTAssertEqual(objcLinkExit.metadata.requestID, "req_no_error")
    }

    func testLinkExitWithApiErrorToObjC() throws {
        let jsonString = """
            {
              "error": {
                "errorCode": {
                  "type": "API_ERROR",
                  "code": "INTERNAL_SERVER_ERROR"
                },
                "errorMessage": "An internal server error occurred",
                "displayMessage": "Something went wrong. Please try again."
              },
              "metadata": {
                "link_session_id": "session_api_error",
                "request_id": "req_api_error"
              }
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let linkExit = try decoder.decode(LinkExit.self, from: data)

        XCTAssertNotNil(linkExit.error)
        XCTAssertEqual(linkExit.error?.errorMessage, "An internal server error occurred")

        let objcLinkExit = linkExit.toObjC

        XCTAssertNotNil(objcLinkExit.error)
        let nsError = objcLinkExit.error as? NSError

        XCTAssertEqual(nsError?.domain, kPLKExitErrorApiDomain)
        XCTAssertEqual(
            nsError?.userInfo[kPLKExitErrorMessageKey] as? String,
            "An internal server error occurred"
        )
        XCTAssertEqual(objcLinkExit.error?.localizedDescription, "Something went wrong. Please try again.")
    }

    func testLinkExitWithInstitutionErrorToObjC() throws {
        let jsonString = """
            {
              "error": {
                "errorCode": {
                  "type": "INSTITUTION_ERROR",
                  "code": "INSTITUTION_DOWN"
                },
                "errorMessage": "The institution is down",
                "displayMessage": "The financial institution is currently unavailable"
              },
              "metadata": {
                "status": "institution_not_found",
                "institution": {
                  "id": "ins_down",
                  "name": "Down Bank"
                },
                "link_session_id": "session_inst_error",
                "request_id": "req_inst_error"
              }
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let linkExit = try decoder.decode(LinkExit.self, from: data)

        XCTAssertNotNil(linkExit.error)
        XCTAssertEqual(linkExit.metadata.institution?.name, "Down Bank")

        let objcLinkExit = linkExit.toObjC

        XCTAssertNotNil(objcLinkExit.error)
        let nsError = objcLinkExit.error as? NSError

        XCTAssertEqual(nsError?.domain, kPLKExitErrorInstitutionErrorDomain)
        XCTAssertEqual(objcLinkExit.metadata.institution?.name, "Down Bank")
        XCTAssertEqual(objcLinkExit.metadata.status?.value, .institutionNotFound)
    }

    func testLinkExitWithMetadataOnlyToObjC() throws {
        let jsonString = """
            {
              "metadata": {
                "status": "requires_questions",
                "institution": {
                  "id": "ins_456",
                  "name": "Question Bank"
                },
                "link_session_id": "session_metadata",
                "request_id": "req_metadata"
              }
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let linkExit = try decoder.decode(LinkExit.self, from: data)

        XCTAssertNil(linkExit.error)
        XCTAssertEqual(linkExit.metadata.status, .requiresQuestions)
        XCTAssertEqual(linkExit.metadata.institution?.id, "ins_456")
        XCTAssertEqual(linkExit.metadata.institution?.name, "Question Bank")

        let objcLinkExit = linkExit.toObjC

        XCTAssertNil(objcLinkExit.error)
        XCTAssertEqual(objcLinkExit.metadata.status?.value, .requiresQuestions)
        XCTAssertEqual(objcLinkExit.metadata.institution?.id, "ins_456")
        XCTAssertEqual(objcLinkExit.metadata.institution?.name, "Question Bank")
        XCTAssertEqual(objcLinkExit.metadata.linkSessionID, "session_metadata")
        XCTAssertEqual(objcLinkExit.metadata.requestID, "req_metadata")
    }

    func testLinkExitWithInternalErrorToObjC() throws {
        let jsonString = """
            {
              "error": {
                "errorCode": {
                  "type": "INTERNAL",
                  "code": "SDK_ERROR"
                },
                "errorMessage": "SDK encountered an error",
                "displayMessage": "An unexpected error occurred"
              },
              "metadata": {
                "link_session_id": "session_internal"
              }
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let linkExit = try decoder.decode(LinkExit.self, from: data)

        XCTAssertNotNil(linkExit.error)

        let objcLinkExit = linkExit.toObjC

        XCTAssertNotNil(objcLinkExit.error)
        let nsError = objcLinkExit.error as? NSError

        XCTAssertEqual(nsError?.domain, kPLKExitErrorInternalDomain)
        XCTAssertEqual(nsError?.code, -1)
        XCTAssertEqual(objcLinkExit.metadata.linkSessionID, "session_internal")
    }

    func testLinkExitWithUnknownErrorToObjC() throws {
        let jsonString = """
            {
              "error": {
                "errorCode": {
                  "type": "CUSTOM_ERROR_TYPE",
                  "code": "CUSTOM_ERROR_CODE"
                },
                "errorMessage": "A custom error occurred",
                "displayMessage": "Custom error message"
              },
              "metadata": {
                "link_session_id": "session_unknown"
              }
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let linkExit = try decoder.decode(LinkExit.self, from: data)

        XCTAssertNotNil(linkExit.error)

        let objcLinkExit = linkExit.toObjC

        XCTAssertNotNil(objcLinkExit.error)

        let nsError = objcLinkExit.error as? NSError
        XCTAssertEqual(nsError?.domain, kPLKExitErrorUnknownDomain)
        XCTAssertEqual(nsError?.code, -1)
        XCTAssertEqual(nsError?.userInfo[kPLKExitErrorUnknownTypeKey] as? String, "CUSTOM_ERROR_TYPE")
        XCTAssertEqual(nsError?.userInfo[kPLKExitErrorCodeKey] as? String, "CUSTOM_ERROR_CODE")
    }

    func testMultipleLinkExitConversions() throws {
        let exitScenarios = [
            """
            {
              "error": {"errorCode": {"type": "ITEM_ERROR", "code": "ITEM_LOGIN_REQUIRED"}, "errorMessage": "Login required"},
              "metadata": {"link_session_id": "session_1"}
            }
            """,
            """
            {
              "metadata": {"link_session_id": "session_2"}
            }
            """,
            """
            {
              "error": {"errorCode": {"type": "API_ERROR", "code": "PLANNED_MAINTENANCE"}, "errorMessage": "Maintenance"},
              "metadata": {"link_session_id": "session_3"}
            }
            """,
        ]

        let decoder = JSONDecoder()
        for (index, jsonString) in exitScenarios.enumerated() {
            let data = jsonString.data(using: .utf8)!
            let linkExit = try decoder.decode(LinkExit.self, from: data)
            let objcLinkExit = linkExit.toObjC

            XCTAssertEqual(objcLinkExit.metadata.linkSessionID, "session_\(index + 1)")

            // First and third scenarios have errors
            if index == 0 || index == 2 {
                XCTAssertNotNil(objcLinkExit.error)
            } else {
                XCTAssertNil(objcLinkExit.error)
            }
        }
    }
}
