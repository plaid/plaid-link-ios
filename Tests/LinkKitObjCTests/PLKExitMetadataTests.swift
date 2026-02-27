import LinkKit
import XCTest

@testable import LinkKitObjC

final class PLKExitMetadataTests: XCTestCase {

    func testExitMetadataWithAllFieldsToObjC() throws {
        let jsonString = """
            {
              "status": "requires_credentials",
              "institution": {
                "id": "ins_123",
                "name": "Test Bank"
              },
              "link_session_id": "session_123",
              "request_id": "req_123",
              "metadata_json": "{\\"custom\\":\\"data\\"}"
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let exitMetadata = try decoder.decode(ExitMetadata.self, from: data)

        XCTAssertEqual(exitMetadata.status, .requiresCredentials)
        XCTAssertEqual(exitMetadata.institution?.id, "ins_123")
        XCTAssertEqual(exitMetadata.institution?.name, "Test Bank")
        XCTAssertEqual(exitMetadata.linkSessionID, "session_123")
        XCTAssertEqual(exitMetadata.requestID, "req_123")
        XCTAssertEqual(exitMetadata.metadataJSON, "{\"custom\":\"data\"}")

        let objcExitMetadata = exitMetadata.toObjC

        XCTAssertEqual(objcExitMetadata.status?.value, .requiresCredentials)
        XCTAssertEqual(objcExitMetadata.institution?.id, "ins_123")
        XCTAssertEqual(objcExitMetadata.institution?.name, "Test Bank")
        XCTAssertEqual(objcExitMetadata.linkSessionID, "session_123")
        XCTAssertEqual(objcExitMetadata.requestID, "req_123")
        XCTAssertEqual(objcExitMetadata.metadataJSON, "{\"custom\":\"data\"}")
    }
}
