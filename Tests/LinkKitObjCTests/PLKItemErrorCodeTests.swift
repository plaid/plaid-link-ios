import LinkKit
import XCTest

@testable import LinkKitObjC

final class PLKItemErrorCodeTests: XCTestCase {

    func testInsufficientCredentialsToObjC() {
        let errorCode = ItemErrorCode.insufficientCredentials
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .insufficientCredentials)
    }

    func testInvalidCredentialsToObjC() {
        let errorCode = ItemErrorCode.invalidCredentials
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .invalidCredentials)
    }

    func testInvalidMfaToObjC() {
        let errorCode = ItemErrorCode.invalidMfa
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .invalidMfa)
    }

    func testInvalidSendMethodToObjC() {
        let errorCode = ItemErrorCode.invalidSendMethod
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .invalidSendMethod)
    }

    func testInvalidUpdatedUsernameToObjC() {
        let errorCode = ItemErrorCode.invalidUpdatedUsername
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .invalidUpdatedUsername)
    }

    func testItemLockedToObjC() {
        let errorCode = ItemErrorCode.itemLocked
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .itemLocked)
    }

    func testItemLoginRequiredToObjC() {
        let errorCode = ItemErrorCode.itemLoginRequired
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .itemLoginRequired)
    }

    func testItemNoErrorToObjC() {
        let errorCode = ItemErrorCode.itemNoError
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .itemNoError)
    }

    func testItemNotSupportedToObjC() {
        let errorCode = ItemErrorCode.itemNotSupported
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .itemNotSupported)
    }

    func testIncorrectDepositAmountsToObjC() {
        let errorCode = ItemErrorCode.incorrectDepositAmounts
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .incorrectDepositAmounts)
    }

    func testUserSetupRequiredToObjC() {
        let errorCode = ItemErrorCode.userSetupRequired
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .userSetupRequired)
    }

    func testMfaNotSupportedToObjC() {
        let errorCode = ItemErrorCode.mfaNotSupported
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .mfaNotSupported)
    }

    func testNoAccountsToObjC() {
        let errorCode = ItemErrorCode.noAccounts
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .noAccounts)
    }

    func testNoAuthAccountsToObjC() {
        let errorCode = ItemErrorCode.noAuthAccounts
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .noAuthAccounts)
    }

    func testNoInvestmentAccountsToObjC() {
        let errorCode = ItemErrorCode.noInvestmentAccounts
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .noInvestmentAccounts)
    }

    func testNoLiabilityAccountsToObjC() {
        let errorCode = ItemErrorCode.noLiabilityAccounts
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .noLiabilityAccounts)
    }

    func testProductNotReadyToObjC() {
        let errorCode = ItemErrorCode.productNotReady
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .productNotReady)
    }

    func testProductsNotSupportedToObjC() {
        let errorCode = ItemErrorCode.productsNotSupported
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .productsNotSupported)
    }

    func testInstantMatchFailedToObjC() {
        let errorCode = ItemErrorCode.instantMatchFailed
        let objcErrorCode = errorCode.toObjC
        XCTAssertEqual(objcErrorCode, .instantMatchFailed)
    }

    func testUnknownToObjC() {
        let errorCode = ItemErrorCode.unknown("CUSTOM_ITEM_ERROR")
        let objcErrorCode = errorCode.toObjC
        XCTAssertNil(objcErrorCode)
    }

    func testAllKnownErrorCodesMapToObjC() {
        let knownErrorCodes: [ItemErrorCode] = [
            .insufficientCredentials,
            .invalidCredentials,
            .invalidMfa,
            .invalidSendMethod,
            .invalidUpdatedUsername,
            .itemLocked,
            .itemLoginRequired,
            .itemNoError,
            .itemNotSupported,
            .incorrectDepositAmounts,
            .userSetupRequired,
            .mfaNotSupported,
            .noAccounts,
            .noAuthAccounts,
            .noInvestmentAccounts,
            .noLiabilityAccounts,
            .productNotReady,
            .productsNotSupported,
            .instantMatchFailed,
        ]

        for errorCode in knownErrorCodes {
            let objcErrorCode = errorCode.toObjC
            XCTAssertNotNil(objcErrorCode, "Error code '\(errorCode.description)' should have a valid ObjC mapping")
        }
    }
}
