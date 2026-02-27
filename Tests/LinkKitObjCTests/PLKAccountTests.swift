import LinkKit
import XCTest

@testable import LinkKitObjC

final class PLKAccountTests: XCTestCase {

    func testAccountToObjC() throws {
        let jsonString = """
            {
              "id": "acc_123456789",
              "name": "Plaid Checking",
              "mask": "0000",
              "subtype": "depository.checking",
              "verificationStatus": "manually_verified"
            }
            """

        let data = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let account = try decoder.decode(Account.self, from: data)

        XCTAssertEqual(account.id, "acc_123456789")
        XCTAssertEqual(account.name, "Plaid Checking")
        XCTAssertEqual(account.mask, "0000")
        XCTAssertEqual(account.subtype, .depository(.checking))
        XCTAssertEqual(account.verificationStatus, .manuallyVerified)

        let objcAccount = account.toObjC

        XCTAssertEqual(objcAccount.id, account.id)
        XCTAssertEqual(objcAccount.name, account.name)
        XCTAssertEqual(objcAccount.mask, account.mask)
        XCTAssertEqual(objcAccount.subtype.rawStringValue, account.subtype.toObjC.rawStringValue)
        XCTAssertEqual(objcAccount.verificationStatus?.value, account.verificationStatus?.toObjC.value)
    }
}
