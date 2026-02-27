import LinkKit
import XCTest

@testable import LinkKitObjC

final class PLKSuccessMetadataTests: XCTestCase {

    func testSuccessMetadataWithSingleAccountToObjC() throws {
        let jsonString = """
            {
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
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let successMetadata = try decoder.decode(SuccessMetadata.self, from: data)

        let objcMetadata = successMetadata.toObjC

        XCTAssertEqual(objcMetadata.linkSessionID, "link_session_123")
        XCTAssertEqual(objcMetadata.institution.id, "ins_123")
        XCTAssertEqual(objcMetadata.institution.name, "Test Bank")
        XCTAssertEqual(objcMetadata.accounts.count, 1)
        XCTAssertEqual(objcMetadata.accounts[0].id, "acc_123")
        XCTAssertEqual(objcMetadata.accounts[0].name, "Checking")
        XCTAssertEqual(objcMetadata.accounts[0].mask, "0000")
        XCTAssertNil(objcMetadata.metadataJSON)
    }

    func testSuccessMetadataWithMultipleAccountsToObjC() throws {
        let jsonString = """
            {
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
              "link_session_id": "link_session_456"
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let successMetadata = try decoder.decode(SuccessMetadata.self, from: data)

        let objcMetadata = successMetadata.toObjC

        XCTAssertEqual(objcMetadata.linkSessionID, "link_session_456")
        XCTAssertEqual(objcMetadata.institution.id, "ins_456")
        XCTAssertEqual(objcMetadata.institution.name, "Another Bank")
        XCTAssertEqual(objcMetadata.accounts.count, 3)

        XCTAssertEqual(objcMetadata.accounts[0].id, "acc_1")
        XCTAssertEqual(objcMetadata.accounts[0].name, "Checking")
        XCTAssertEqual(objcMetadata.accounts[0].mask, "0001")

        XCTAssertEqual(objcMetadata.accounts[1].id, "acc_2")
        XCTAssertEqual(objcMetadata.accounts[1].name, "Savings")
        XCTAssertEqual(objcMetadata.accounts[1].mask, "0002")

        XCTAssertEqual(objcMetadata.accounts[2].id, "acc_3")
        XCTAssertEqual(objcMetadata.accounts[2].name, "Credit Card")
        XCTAssertEqual(objcMetadata.accounts[2].mask, "1234")

        XCTAssertNil(objcMetadata.metadataJSON)
    }

    func testSuccessMetadataWithMetadataJSONToObjC() throws {
        let jsonString = """
            {
              "institution": {
                "id": "ins_789",
                "name": "Bank with Metadata"
              },
              "accounts": [{
                "id": "acc_789",
                "name": "Account",
                "mask": "9999",
                "subtype": "depository.checking"
              }],
              "link_session_id": "link_session_789",
              "metadata_json": "json_string"
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let successMetadata = try decoder.decode(SuccessMetadata.self, from: data)

        let objcMetadata = successMetadata.toObjC

        XCTAssertEqual(objcMetadata.linkSessionID, "link_session_789")
        XCTAssertEqual(objcMetadata.institution.id, "ins_789")
        XCTAssertEqual(objcMetadata.institution.name, "Bank with Metadata")
        XCTAssertEqual(objcMetadata.accounts.count, 1)
        XCTAssertNotNil(objcMetadata.metadataJSON)
        XCTAssertEqual(objcMetadata.metadataJSON, "json_string")
    }

    func testSuccessMetadataPreservesLinkSessionID() throws {
        let jsonString = """
            {
              "institution": {
                "id": "ins_test",
                "name": "Test Institution"
              },
              "accounts": [{
                "id": "acc_test",
                "name": "Test Account",
                "subtype": "depository.checking"
              }],
              "link_session_id": "unique_link_session_id_12345"
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let successMetadata = try decoder.decode(SuccessMetadata.self, from: data)

        let objcMetadata = successMetadata.toObjC

        XCTAssertEqual(objcMetadata.linkSessionID, "unique_link_session_id_12345")
    }

    func testSuccessMetadataInstitutionConvertsCorrectly() throws {
        let jsonString = """
            {
              "institution": {
                "id": "ins_complex",
                "name": "Complex Institution Name & Co."
              },
              "accounts": [{
                "id": "acc_minimal",
                "name": "Minimal Account",
                "subtype": "depository.checking"
              }],
              "link_session_id": "session_123"
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let successMetadata = try decoder.decode(SuccessMetadata.self, from: data)

        let objcMetadata = successMetadata.toObjC

        XCTAssertEqual(objcMetadata.institution.id, "ins_complex")
        XCTAssertEqual(objcMetadata.institution.name, "Complex Institution Name & Co.")
    }

    func testSuccessMetadataAccountsArrayMapCorrectly() throws {
        let jsonString = """
            {
              "institution": {
                "id": "ins_array_test",
                "name": "Array Test Bank"
              },
              "accounts": [
                {
                  "id": "acc_first",
                  "name": "First Account",
                  "mask": "1111",
                  "subtype": "depository.checking"
                },
                {
                  "id": "acc_second",
                  "name": "Second Account",
                  "mask": "2222",
                  "subtype": "depository.savings"
                },
                {
                  "id": "acc_third",
                  "name": "Third Account",
                  "mask": "3333",
                  "subtype": "credit.credit card"
                },
                {
                  "id": "acc_fourth",
                  "name": "Fourth Account",
                  "mask": "4444",
                  "subtype": "investment.401k"
                }
              ],
              "link_session_id": "session_array_test"
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let successMetadata = try decoder.decode(SuccessMetadata.self, from: data)

        let objcMetadata = successMetadata.toObjC

        XCTAssertEqual(objcMetadata.accounts.count, 4)
        XCTAssertEqual(objcMetadata.accounts[0].id, "acc_first")
        XCTAssertEqual(objcMetadata.accounts[1].id, "acc_second")
        XCTAssertEqual(objcMetadata.accounts[2].id, "acc_third")
        XCTAssertEqual(objcMetadata.accounts[3].id, "acc_fourth")
    }

    func testSuccessMetadataWithEmptyMetadataJSONToObjC() throws {
        let jsonString = """
            {
              "institution": {
                "id": "ins_empty",
                "name": "Empty Metadata Bank"
              },
              "accounts": [{
                "id": "acc_empty",
                "name": "Empty Metadata Account",
                "subtype": "depository.checking"
              }],
              "link_session_id": "session_empty"
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let successMetadata = try decoder.decode(SuccessMetadata.self, from: data)

        let objcMetadata = successMetadata.toObjC

        XCTAssertNil(objcMetadata.metadataJSON)
    }

    func testSuccessMetadataMultipleConversionsProduceSameResult() throws {
        let jsonString = """
            {
              "institution": {
                "id": "ins_repeat",
                "name": "Repeat Bank"
              },
              "accounts": [{
                "id": "acc_repeat",
                "name": "Repeat Account",
                "mask": "5555",
                "subtype": "depository.checking"
              }],
              "link_session_id": "session_repeat",
              "metadata_json": "{\\"test\\":\\"value\\"}"
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let successMetadata = try decoder.decode(SuccessMetadata.self, from: data)

        let objcMetadata1 = successMetadata.toObjC
        let objcMetadata2 = successMetadata.toObjC

        XCTAssertEqual(objcMetadata1.linkSessionID, objcMetadata2.linkSessionID)
        XCTAssertEqual(objcMetadata1.institution.id, objcMetadata2.institution.id)
        XCTAssertEqual(objcMetadata1.institution.name, objcMetadata2.institution.name)
        XCTAssertEqual(objcMetadata1.accounts.count, objcMetadata2.accounts.count)
        XCTAssertEqual(objcMetadata1.metadataJSON, objcMetadata2.metadataJSON)
    }

    func testSuccessMetadataWithComplexAccountSubtypes() throws {
        let jsonString = """
            {
              "institution": {
                "id": "ins_subtypes",
                "name": "Subtype Test Bank"
              },
              "accounts": [
                {
                  "id": "acc_checking",
                  "name": "Checking",
                  "subtype": "depository.checking"
                },
                {
                  "id": "acc_savings",
                  "name": "Savings",
                  "subtype": "depository.savings"
                },
                {
                  "id": "acc_credit",
                  "name": "Credit Card",
                  "subtype": "credit.credit card"
                },
                {
                  "id": "acc_401k",
                  "name": "401k",
                  "subtype": "investment.401k"
                },
                {
                  "id": "acc_mortgage",
                  "name": "Mortgage",
                  "subtype": "loan.mortgage"
                }
              ],
              "link_session_id": "session_subtypes"
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let successMetadata = try decoder.decode(SuccessMetadata.self, from: data)

        let objcMetadata = successMetadata.toObjC

        XCTAssertEqual(objcMetadata.accounts.count, 5)
        XCTAssertEqual(objcMetadata.accounts[0].id, "acc_checking")
        XCTAssertEqual(objcMetadata.accounts[1].id, "acc_savings")
        XCTAssertEqual(objcMetadata.accounts[2].id, "acc_credit")
        XCTAssertEqual(objcMetadata.accounts[3].id, "acc_401k")
        XCTAssertEqual(objcMetadata.accounts[4].id, "acc_mortgage")
    }
}
