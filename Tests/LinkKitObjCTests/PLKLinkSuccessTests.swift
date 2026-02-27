import LinkKit
import XCTest

@testable import LinkKitObjC

final class PLKLinkSuccessTests: XCTestCase {

    func testLinkSuccessWithSingleAccountToObjC() throws {
        let jsonString = """
            {
              "public_token": "public-token-abc123",
              "metadata": {
                "institution": {
                  "id": "ins_123",
                  "name": "Test Bank"
                },
                "accounts": [{
                  "id": "acc_123",
                  "name": "Checking",
                  "mask": "0000",
                  "subtype": "depository.checking",
                  "verificationStatus": "manually_verified"
                }],
                "link_session_id": "link_session_123"
              }
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let linkSuccess = try decoder.decode(LinkSuccess.self, from: data)

        let objcLinkSuccess = linkSuccess.toObjC

        XCTAssertEqual(objcLinkSuccess.publicToken, "public-token-abc123")
        XCTAssertEqual(objcLinkSuccess.metadata.linkSessionID, "link_session_123")
        XCTAssertEqual(objcLinkSuccess.metadata.institution.id, "ins_123")
        XCTAssertEqual(objcLinkSuccess.metadata.institution.name, "Test Bank")
        XCTAssertEqual(objcLinkSuccess.metadata.accounts.count, 1)
        XCTAssertEqual(objcLinkSuccess.metadata.accounts[0].id, "acc_123")
        XCTAssertEqual(objcLinkSuccess.metadata.accounts[0].name, "Checking")
        XCTAssertEqual(objcLinkSuccess.metadata.accounts[0].mask, "0000")
        XCTAssertNil(objcLinkSuccess.metadata.metadataJSON)
    }

    func testLinkSuccessWithMultipleAccountsToObjC() throws {
        let jsonString = """
            {
              "public_token": "public-token-xyz789",
              "metadata": {
                "institution": {
                  "id": "ins_456",
                  "name": "Another Bank"
                },
                "accounts": [
                  {
                    "id": "acc_1",
                    "name": "Checking",
                    "mask": "0001",
                    "subtype": "depository.checking",
                    "verificationStatus": "manually_verified"
                  },
                  {
                    "id": "acc_2",
                    "name": "Savings",
                    "mask": "0002",
                    "subtype": "depository.savings",
                    "verificationStatus": "pending_automatic_verification"
                  },
                  {
                    "id": "acc_3",
                    "name": "Credit Card",
                    "mask": "1234",
                    "subtype": "credit.credit card"
                  }
                ],
                "link_session_id": "link_session_456",
                "metadata_json": "{\\"custom\\":\\"data\\"}"
              }
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let linkSuccess = try decoder.decode(LinkSuccess.self, from: data)

        let objcLinkSuccess = linkSuccess.toObjC

        XCTAssertEqual(objcLinkSuccess.publicToken, "public-token-xyz789")
        XCTAssertEqual(objcLinkSuccess.metadata.linkSessionID, "link_session_456")
        XCTAssertEqual(objcLinkSuccess.metadata.institution.id, "ins_456")
        XCTAssertEqual(objcLinkSuccess.metadata.institution.name, "Another Bank")
        XCTAssertEqual(objcLinkSuccess.metadata.accounts.count, 3)

        XCTAssertEqual(objcLinkSuccess.metadata.accounts[0].id, "acc_1")
        XCTAssertEqual(objcLinkSuccess.metadata.accounts[0].name, "Checking")
        XCTAssertEqual(objcLinkSuccess.metadata.accounts[0].mask, "0001")

        XCTAssertEqual(objcLinkSuccess.metadata.accounts[1].id, "acc_2")
        XCTAssertEqual(objcLinkSuccess.metadata.accounts[1].name, "Savings")
        XCTAssertEqual(objcLinkSuccess.metadata.accounts[1].mask, "0002")

        XCTAssertEqual(objcLinkSuccess.metadata.accounts[2].id, "acc_3")
        XCTAssertEqual(objcLinkSuccess.metadata.accounts[2].name, "Credit Card")
        XCTAssertEqual(objcLinkSuccess.metadata.accounts[2].mask, "1234")

        XCTAssertEqual(objcLinkSuccess.metadata.metadataJSON, "{\"custom\":\"data\"}")
    }

    func testLinkSuccessWithMetadataJSONToObjC() throws {
        let jsonString = """
            {
              "public_token": "public-token-json",
              "metadata": {
                "institution": {
                  "id": "ins_789",
                  "name": "JSON Bank"
                },
                "accounts": [{
                  "id": "acc_json",
                  "name": "Account",
                  "subtype": "investment.ira"
                }],
                "link_session_id": "link_session_json",
                "metadata_json": "{\\"key\\":\\"value\\",\\"nested\\":{\\"field\\":123}}"
              }
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let linkSuccess = try decoder.decode(LinkSuccess.self, from: data)

        let objcLinkSuccess = linkSuccess.toObjC

        XCTAssertEqual(objcLinkSuccess.publicToken, "public-token-json")
        XCTAssertEqual(objcLinkSuccess.metadata.metadataJSON, "{\"key\":\"value\",\"nested\":{\"field\":123}}")
    }

    func testLinkSuccessPreservesPublicToken() throws {
        let tokens = [
            "public-sandbox-abc123",
            "public-development-xyz789",
            "public-production-def456",
        ]

        for token in tokens {
            let jsonString = """
                {
                  "public_token": "\(token)",
                  "metadata": {
                    "institution": {
                      "id": "ins_test",
                      "name": "Test"
                    },
                    "accounts": [{
                      "id": "acc_test",
                      "name": "Test Account",
                      "subtype": "other.other"
                    }],
                    "link_session_id": "session_test"
                  }
                }
                """

            let data = jsonString.data(using: .utf8)!
            let decoder = JSONDecoder()
            let linkSuccess = try decoder.decode(LinkSuccess.self, from: data)

            let objcLinkSuccess = linkSuccess.toObjC

            XCTAssertEqual(objcLinkSuccess.publicToken, token)
        }
    }

    func testLinkSuccessAccountSubtypesConvertCorrectly() throws {
        let testCases: [(String, String)] = [
            ("depository.checking", "checking"),
            ("depository.savings", "savings"),
            ("credit.credit card", "credit card"),
            ("loan.mortgage", "mortgage"),
            ("investment.brokerage", "brokerage"),
        ]

        for (subtypeJSON, expectedRawValue) in testCases {
            let jsonString = """
                {
                  "public_token": "token_test",
                  "metadata": {
                    "institution": {
                      "id": "ins_test",
                      "name": "Test Bank"
                    },
                    "accounts": [{
                      "id": "acc_test",
                      "name": "Test Account",
                      "subtype": "\(subtypeJSON)"
                    }],
                    "link_session_id": "session_test"
                  }
                }
                """

            let data = jsonString.data(using: .utf8)!
            let decoder = JSONDecoder()
            let linkSuccess = try decoder.decode(LinkSuccess.self, from: data)

            let objcLinkSuccess = linkSuccess.toObjC

            XCTAssertEqual(objcLinkSuccess.metadata.accounts[0].subtype.rawStringValue, expectedRawValue)
        }
    }
}
