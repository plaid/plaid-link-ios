import LinkKit
import XCTest

@testable import LinkKitObjC

final class PLKInstitutionErrorCodeTests: XCTestCase {

    func testInstitutionDownToObjC() {
        let errorCode = InstitutionErrorCode.institutionDown
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .institutionDown)
    }

    func testInstitutionNotRespondingToObjC() {
        let errorCode = InstitutionErrorCode.institutionNotResponding
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .institutionNotResponding)
    }

    func testInstitutionNotAvailableToObjC() {
        let errorCode = InstitutionErrorCode.institutionNotAvailable
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .institutionNotAvailable)
    }

    func testInstitutionNoLongerSupportedToObjC() {
        let errorCode = InstitutionErrorCode.institutionNoLongerSupported
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .institutionNoLongerSupported)
    }

    func testUnknownToObjC() {
        let errorCode = InstitutionErrorCode.unknown("CUSTOM_INSTITUTION_ERROR")
        let objcErrorCode = errorCode.toObjC
        XCTAssertNil(objcErrorCode)
    }
}
