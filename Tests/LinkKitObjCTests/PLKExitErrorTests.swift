import LinkKit
import XCTest

@testable import LinkKitObjC
@testable import LinkKitObjCInternal

final class PLKExitErrorTests: XCTestCase {

    // MARK: - Item Error Tests

    func testItemErrorToObjC() {
        let exitError = ExitError.privateObjCInitializer(
            errorCode: .itemError(.itemLoginRequired),
            errorMessage: "Item login required",
            displayMesssage: "Please log in again",
            errorJSON: "{\"status_code\":400}"
        )

        let nsError = exitError.toObjC

        XCTAssertEqual(nsError.domain, kPLKExitErrorItemDomain)
        XCTAssertEqual(nsError.userInfo[kPLKExitErrorMessageKey] as? String, "Item login required")
        XCTAssertEqual(nsError.userInfo[kPLKExitErrorDisplayMessageKey] as? String, "Please log in again")
        XCTAssertEqual(nsError.userInfo[NSLocalizedDescriptionKey] as? String, "Please log in again")
        XCTAssertEqual(nsError.userInfo[kPLKExitErrorRawJSONKey] as? String, "{\"status_code\":400}")
        XCTAssertEqual(nsError.userInfo[kPLKExitErrorCodeKey] as? String, "ITEM_LOGIN_REQUIRED")
        XCTAssertNotEqual(nsError.code, -1)
    }

    func testItemErrorWithoutDisplayMessageToObjC() {
        let exitError = ExitError.privateObjCInitializer(
            errorCode: .itemError(.itemLoginRequired),
            errorMessage: "Item login required",
            displayMesssage: nil,
            errorJSON: nil
        )

        let nsError = exitError.toObjC

        XCTAssertEqual(nsError.domain, kPLKExitErrorItemDomain)
        XCTAssertEqual(nsError.userInfo[kPLKExitErrorMessageKey] as? String, "Item login required")
        XCTAssertEqual(nsError.userInfo[kPLKExitErrorDisplayMessageKey] as? String, "")
        XCTAssertEqual(nsError.userInfo[NSLocalizedDescriptionKey] as? String, "")
        XCTAssertEqual(nsError.userInfo[kPLKExitErrorRawJSONKey] as? String, "")
    }

    // MARK: - API Error Tests

    func testApiErrorToObjC() {
        let exitError = ExitError.privateObjCInitializer(
            errorCode: .apiError(.internalServerError),
            errorMessage: "Internal server error",
            displayMesssage: "Something went wrong. Please try again.",
            errorJSON: nil
        )

        let nsError = exitError.toObjC

        XCTAssertEqual(nsError.domain, kPLKExitErrorApiDomain)
        XCTAssertEqual(nsError.userInfo[kPLKExitErrorMessageKey] as? String, "Internal server error")
        XCTAssertEqual(
            nsError.userInfo[kPLKExitErrorDisplayMessageKey] as? String,
            "Something went wrong. Please try again."
        )
        XCTAssertEqual(
            nsError.userInfo[NSLocalizedDescriptionKey] as? String,
            "Something went wrong. Please try again."
        )
        XCTAssertNotEqual(nsError.code, -1)
    }

    func testApiErrorPlannedMaintenanceToObjC() {
        let exitError = ExitError.privateObjCInitializer(
            errorCode: .apiError(.plannedMaintenance),
            errorMessage: "Planned maintenance",
            displayMesssage: "We're currently performing maintenance. Please try again later.",
            errorJSON: nil
        )

        let nsError = exitError.toObjC

        XCTAssertEqual(nsError.domain, kPLKExitErrorApiDomain)
        XCTAssertEqual(nsError.userInfo[kPLKExitErrorCodeKey] as? String, "PLANNED_MAINTENANCE")
    }

    // MARK: - Auth Error Tests

    func testAuthErrorToObjC() {
        let exitError = ExitError.privateObjCInitializer(
            errorCode: .authError(.productNotReady),
            errorMessage: "Product not ready",
            displayMesssage: "Auth product is not ready",
            errorJSON: nil
        )

        let nsError = exitError.toObjC

        XCTAssertEqual(nsError.domain, kPLKExitErrorAuthDomain)
        XCTAssertEqual(nsError.userInfo[kPLKExitErrorMessageKey] as? String, "Product not ready")
        XCTAssertEqual(nsError.userInfo[kPLKExitErrorDisplayMessageKey] as? String, "Auth product is not ready")
        XCTAssertNotEqual(nsError.code, -1)
    }

    // MARK: - Asset Report Error Tests

    func testAssetReportErrorToObjC() {
        let exitError = ExitError.privateObjCInitializer(
            errorCode: .assetReportError(.productNotEnabled),
            errorMessage: "Asset report product not enabled",
            displayMesssage: "This feature is not enabled for your account",
            errorJSON: nil
        )

        let nsError = exitError.toObjC

        XCTAssertEqual(nsError.domain, kPLKExitErrorAssetReportDomain)
        XCTAssertEqual(nsError.userInfo[kPLKExitErrorMessageKey] as? String, "Asset report product not enabled")
        XCTAssertNotEqual(nsError.code, -1)
    }

    // MARK: - Internal Error Tests

    func testInternalErrorToObjC() {
        let exitError = ExitError.privateObjCInitializer(
            errorCode: .internal("INTERNAL_SDK_ERROR"),
            errorMessage: "SDK encountered an internal error",
            displayMesssage: "An unexpected error occurred",
            errorJSON: nil
        )

        let nsError = exitError.toObjC

        XCTAssertEqual(nsError.domain, kPLKExitErrorInternalDomain)
        XCTAssertEqual(nsError.userInfo[kPLKExitErrorMessageKey] as? String, "SDK encountered an internal error")
        XCTAssertEqual(nsError.userInfo[kPLKExitErrorCodeKey] as? String, "INTERNAL_SDK_ERROR")
        XCTAssertEqual(nsError.code, -1)
    }

    // MARK: - Institution Error Tests

    func testInstitutionErrorToObjC() {
        let exitError = ExitError.privateObjCInitializer(
            errorCode: .institutionError(.institutionDown),
            errorMessage: "Institution is down",
            displayMesssage: "The financial institution is currently unavailable",
            errorJSON: nil
        )

        let nsError = exitError.toObjC

        XCTAssertEqual(nsError.domain, kPLKExitErrorInstitutionErrorDomain)
        XCTAssertEqual(nsError.userInfo[kPLKExitErrorMessageKey] as? String, "Institution is down")
        XCTAssertNotEqual(nsError.code, -1)
    }

    // MARK: - Invalid Input Error Tests

    func testInvalidInputErrorToObjC() {
        let exitError = ExitError.privateObjCInitializer(
            errorCode: .invalidInput(.invalidAccountId),
            errorMessage: "Invalid account number",
            displayMesssage: "The account number you entered is invalid",
            errorJSON: nil
        )

        let nsError = exitError.toObjC

        XCTAssertEqual(nsError.domain, kPLKExitErrorInvalidInputDomain)
        XCTAssertEqual(nsError.userInfo[kPLKExitErrorMessageKey] as? String, "Invalid account number")
        XCTAssertNotEqual(nsError.code, -1)
    }

    // MARK: - Invalid Request Error Tests

    func testInvalidRequestErrorToObjC() {
        let exitError = ExitError.privateObjCInitializer(
            errorCode: .invalidRequest(.missingFields),
            errorMessage: "Missing required fields",
            displayMesssage: nil,
            errorJSON: nil
        )

        let nsError = exitError.toObjC

        XCTAssertEqual(nsError.domain, kPLKExitErrorInvalidRequestDomain)
        XCTAssertEqual(nsError.userInfo[kPLKExitErrorMessageKey] as? String, "Missing required fields")
        XCTAssertNotEqual(nsError.code, -1)
    }

    // MARK: - Rate Limit Error Tests

    func testRateLimitErrorToObjC() {
        let exitError = ExitError.privateObjCInitializer(
            errorCode: .rateLimitExceeded(.accountsLimit),
            errorMessage: "Rate limit exceeded for accounts",
            displayMesssage: "Too many requests. Please try again later.",
            errorJSON: nil
        )

        let nsError = exitError.toObjC

        XCTAssertEqual(nsError.domain, kPLKExitErrorRateLimitExceededDomain)
        XCTAssertEqual(nsError.userInfo[kPLKExitErrorMessageKey] as? String, "Rate limit exceeded for accounts")
        XCTAssertNotEqual(nsError.code, -1)
    }

    // MARK: - Unknown Error Tests

    func testUnknownErrorToObjC() {
        let exitError = ExitError.privateObjCInitializer(
            errorCode: .unknown(type: "CUSTOM_ERROR_TYPE", code: "CUSTOM_ERROR_CODE"),
            errorMessage: "Unknown error occurred",
            displayMesssage: "An unknown error occurred",
            errorJSON: nil
        )

        let nsError = exitError.toObjC

        XCTAssertEqual(nsError.domain, kPLKExitErrorUnknownDomain)
        XCTAssertEqual(nsError.userInfo[kPLKExitErrorMessageKey] as? String, "Unknown error occurred")
        XCTAssertEqual(nsError.userInfo[kPLKExitErrorCodeKey] as? String, "CUSTOM_ERROR_CODE")
        XCTAssertEqual(nsError.userInfo[kPLKExitErrorUnknownTypeKey] as? String, "CUSTOM_ERROR_TYPE")
        XCTAssertEqual(nsError.code, -1)
    }

    // MARK: - Error with Full JSON Metadata Tests

    func testErrorWithCompleteMetadataToObjC() {
        let jsonMetadata = """
            {
                "error_code": "ITEM_LOGIN_REQUIRED",
                "error_type": "ITEM_ERROR",
                "error_message": "the login details of this item have changed",
                "display_message": "The login details of this item have changed (credentials, MFA, or required user action). Please re-authenticate.",
                "status": 400
            }
            """

        let exitError = ExitError.privateObjCInitializer(
            errorCode: .itemError(.itemLoginRequired),
            errorMessage: "the login details of this item have changed",
            displayMesssage:
                "The login details of this item have changed (credentials, MFA, or required user action). Please re-authenticate.",
            errorJSON: jsonMetadata
        )

        let nsError = exitError.toObjC

        XCTAssertEqual(nsError.domain, kPLKExitErrorItemDomain)
        XCTAssertEqual(
            nsError.userInfo[kPLKExitErrorMessageKey] as? String,
            "the login details of this item have changed"
        )
        XCTAssertEqual(
            nsError.userInfo[kPLKExitErrorDisplayMessageKey] as? String,
            "The login details of this item have changed (credentials, MFA, or required user action). Please re-authenticate."
        )
        XCTAssertEqual(
            nsError.userInfo[NSLocalizedDescriptionKey] as? String,
            "The login details of this item have changed (credentials, MFA, or required user action). Please re-authenticate."
        )
        XCTAssertNotNil(nsError.userInfo[kPLKExitErrorRawJSONKey])
        XCTAssertTrue((nsError.userInfo[kPLKExitErrorRawJSONKey] as? String)?.contains("ITEM_LOGIN_REQUIRED") ?? false)
    }

    // MARK: - Error Code Conversion Tests

    func testItemErrorWithUnknownCodeToObjC() {
        let exitError = ExitError.privateObjCInitializer(
            errorCode: .itemError(.unknown("CUSTOM_ITEM_ERROR")),
            errorMessage: "Custom item error",
            displayMesssage: nil,
            errorJSON: nil
        )

        let nsError = exitError.toObjC

        XCTAssertEqual(nsError.domain, kPLKExitErrorItemDomain)
        XCTAssertEqual(nsError.code, -1)  // Unknown codes should return -1
    }

    func testApiErrorWithUnknownCodeToObjC() {
        let exitError = ExitError.privateObjCInitializer(
            errorCode: .apiError(.unknown("CUSTOM_API_ERROR")),
            errorMessage: "Custom API error",
            displayMesssage: nil,
            errorJSON: nil
        )

        let nsError = exitError.toObjC

        XCTAssertEqual(nsError.domain, kPLKExitErrorApiDomain)
        XCTAssertEqual(nsError.code, -1)
    }

    // MARK: - Multiple Error Types Tests

    func testMultipleItemErrorsToObjC() {
        let errorCodes: [ItemErrorCode] = [
            .itemLoginRequired,
            .userSetupRequired,
            .mfaNotSupported,
            .noAccounts,
        ]

        for errorCode in errorCodes {
            let exitError = ExitError.privateObjCInitializer(
                errorCode: .itemError(errorCode),
                errorMessage: "Test error",
                displayMesssage: nil,
                errorJSON: nil
            )

            let nsError = exitError.toObjC

            XCTAssertEqual(nsError.domain, kPLKExitErrorItemDomain)
            XCTAssertEqual(nsError.userInfo[kPLKExitErrorMessageKey] as? String, "Test error")
        }
    }

    func testMultipleInstitutionErrorsToObjC() {
        let errorCodes: [InstitutionErrorCode] = [
            .institutionDown,
            .institutionNotResponding,
            .institutionNotAvailable,
            .institutionNoLongerSupported,
        ]

        for errorCode in errorCodes {
            let exitError = ExitError.privateObjCInitializer(
                errorCode: .institutionError(errorCode),
                errorMessage: "Test error",
                displayMesssage: nil,
                errorJSON: nil
            )

            let nsError = exitError.toObjC

            XCTAssertEqual(nsError.domain, kPLKExitErrorInstitutionErrorDomain)
            XCTAssertEqual(nsError.userInfo[kPLKExitErrorMessageKey] as? String, "Test error")
        }
    }
}
