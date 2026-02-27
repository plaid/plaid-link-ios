import LinkKit
import XCTest

@testable import LinkKitObjC

final class PLKApiErrorCodeTests: XCTestCase {

    func testInternalServerErrorToObjC() {
        let errorCode = ApiErrorCode.internalServerError
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .internalServerError)
    }

    func testPlannedMaintenanceToObjC() {
        let errorCode = ApiErrorCode.plannedMaintenance
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .plannedMaintenance)
    }

    func testUnknownToObjC() {
        let errorCode = ApiErrorCode.unknown("CUSTOM_ERROR")
        let objcErrorCode = errorCode.toObjC
        XCTAssertNil(objcErrorCode)
    }
}
