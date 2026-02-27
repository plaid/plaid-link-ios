import LinkKit
import XCTest

@testable import LinkKitObjC

final class PLKInstitutionTests: XCTestCase {

    func testInstitutionToObjC() throws {
        let id = "ins_123456"
        let name = "Plaid Bank"

        let json = """
            {
            "id": "\(id)",
            "name": "\(name)"
            }
            """

        let institution = try JSONDecoder().decode(Institution.self, from: json.data(using: .utf8)!)
        let objcInstitution = institution.toObjC

        XCTAssertEqual(objcInstitution.id, "ins_123456")
        XCTAssertEqual(objcInstitution.name, "Plaid Bank")
    }
}
