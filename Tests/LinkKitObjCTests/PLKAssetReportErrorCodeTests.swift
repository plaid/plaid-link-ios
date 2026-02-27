import LinkKit
import XCTest

@testable import LinkKitObjC

final class PLKAssetReportErrorCodeTests: XCTestCase {

    // MARK: - toObjC Conversion Tests

    func testProductNotEnabledToObjC() {
        let errorCode = AssetReportErrorCode.productNotEnabled
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .productNotEnabled)
    }

    func testDataUnavailableToObjC() {
        let errorCode = AssetReportErrorCode.dataUnavailable
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .dataUnavailable)
    }

    func testProductNotReadyToObjC() {
        let errorCode = AssetReportErrorCode.productNotReady
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .productNotReady)
    }

    func testAssetReportGenerationFailedToObjC() {
        let errorCode = AssetReportErrorCode.assetReportGenerationFailed
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .assetReportGenerationFailed)
    }

    func testInvalidParentToObjC() {
        let errorCode = AssetReportErrorCode.invalidParent
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .invalidParent)
    }

    func testInsightsNotEnabledToObjC() {
        let errorCode = AssetReportErrorCode.insightsNotEnabled
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .insightsNotEnabled)
    }

    func testInsightsPreviouslyNotEnabledToObjC() {
        let errorCode = AssetReportErrorCode.insightsPreviouslyNotEnabled
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .insightsPreviouslyNotEnabled)
    }

    func testUnknownToObjC() {
        let errorCode = AssetReportErrorCode.unknown("CUSTOM_ASSET_ERROR")
        let objcErrorCode = errorCode.toObjC
        XCTAssertNil(objcErrorCode)
    }
}
