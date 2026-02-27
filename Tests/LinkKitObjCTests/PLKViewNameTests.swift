import LinkKit
import XCTest

@testable import LinkKitObjC
@testable import LinkKitObjCInternal

final class PLKViewNameTests: XCTestCase {

    // MARK: - toObjCValue Tests

    func testAcceptTOSToObjCValue() {
        let viewName = ViewName.acceptTOS
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .acceptTOS)
    }

    func testConnectedToObjCValue() {
        let viewName = ViewName.connected
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .connected)
    }

    func testConsentToObjCValue() {
        let viewName = ViewName.consent
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .consent)
    }

    func testCredentialToObjCValue() {
        let viewName = ViewName.credential
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .credential)
    }

    func testDocumentaryVerificationToObjCValue() {
        let viewName = ViewName.documentaryVerification
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .documentaryVerification)
    }

    func testErrorToObjCValue() {
        let viewName = ViewName.error
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .error)
    }

    func testExitToObjCValue() {
        let viewName = ViewName.exit
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .exit)
    }

    func testKycCheckToObjCValue() {
        let viewName = ViewName.kycCheck
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .kycCheck)
    }

    func testLoadingToObjCValue() {
        let viewName = ViewName.loading
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .loading)
    }

    func testMatchedConsentToObjCValue() {
        let viewName = ViewName.matchedConsent
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .matchedConsent)
    }

    func testMatchedCredentialToObjCValue() {
        let viewName = ViewName.matchedCredential
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .matchedCredential)
    }

    func testMatchedMFAToObjCValue() {
        let viewName = ViewName.matchedMFA
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .matchedMFA)
    }

    func testMFAToObjCValue() {
        let viewName = ViewName.mfa
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .MFA)
    }

    func testNumbersToObjCValue() {
        let viewName = ViewName.numbers
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .numbers)
    }

    func testProfileDataReviewToObjCValue() {
        let viewName = ViewName.profileDataReview
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .profileDataReview)
    }

    func testOAuthToObjCValue() {
        let viewName = ViewName.oauth
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .oauth)
    }

    func testRecaptchaToObjCValue() {
        let viewName = ViewName.recaptcha
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .recaptcha)
    }

    func testRiskCheckToObjCValue() {
        let viewName = ViewName.riskCheck
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .riskCheck)
    }

    func testScreeningToObjCValue() {
        let viewName = ViewName.screening
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .screening)
    }

    func testSelectAccountToObjCValue() {
        let viewName = ViewName.selectAccount
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .selectAccount)
    }

    func testSelectInstitutionToObjCValue() {
        let viewName = ViewName.selectInstitution
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .selectInstitution)
    }

    func testSelfieCheckToObjCValue() {
        let viewName = ViewName.selfieCheck
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .selfieCheck)
    }

    func testSubmitDocumentsToObjCValue() {
        let viewName = ViewName.submitDocuments
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .submitDocuments)
    }

    func testSubmitDocumentsSuccessToObjCValue() {
        let viewName = ViewName.submitDocumentsSuccess
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .submitDocumentsSuccess)
    }

    func testSubmitDocumentsErrorToObjCValue() {
        let viewName = ViewName.submitDocumentsError
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .submitDocumentsError)
    }

    func testUploadDocumentsToObjCValue() {
        let viewName = ViewName.uploadDocuments
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .uploadDocuments)
    }

    func testVerifySMSToObjCValue() {
        let viewName = ViewName.verifySMS
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .verifySMS)
    }

    func testDataTransparencyToObjCValue() {
        let viewName = ViewName.dataTransparency
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .dataTransparency)
    }

    func testDataTransparencyConsentToObjCValue() {
        let viewName = ViewName.dataTransparencyConsent
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .dataTransparencyConsent)
    }

    func testSelectAuthTypeToObjCValue() {
        let viewName = ViewName.selectAuthType
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .selectAuthType)
    }

    func testSelectBrandToObjCValue() {
        let viewName = ViewName.selectBrand
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .selectBrand)
    }

    func testNumbersSelectInstitutionToObjCValue() {
        let viewName = ViewName.numbersSelectInstitution
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .numbersSelectInstitution)
    }

    func testSubmitEmailToObjCValue() {
        let viewName = ViewName.submitEmail
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .submitEmail)
    }

    func testSubmitPhoneToObjCValue() {
        let viewName = ViewName.submitPhone
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .submitPhone)
    }

    func testVerifyPhoneToObjCValue() {
        let viewName = ViewName.verifyPhone
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .verifyPhone)
    }

    func testSelectSavedInstitutionToObjCValue() {
        let viewName = ViewName.selectSavedInstitution
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .selectSavedInstitution)
    }

    func testSelectSavedAccountToObjCValue() {
        let viewName = ViewName.selectSavedAccount
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .selectSavedAccount)
    }

    func testVerifyEmailToObjCValue() {
        let viewName = ViewName.verifyEmail
        let objcValue = viewName.toObjCValue
        XCTAssertEqual(objcValue, .verifyEmail)
    }

    func testUnknownToObjCValue() {
        let viewName = ViewName.unknown("CUSTOM_VIEW")
        let objcValue = viewName.toObjCValue
        XCTAssertNil(objcValue)
    }

    // MARK: - toObjC Tests

    func testAcceptTOSToObjC() {
        let viewName = ViewName.acceptTOS
        let objcViewName = viewName.toObjC
        XCTAssertEqual(objcViewName.value, .acceptTOS)
        XCTAssertNil(objcViewName.unknownStringValue)
    }

    func testMFAToObjC() {
        let viewName = ViewName.mfa
        let objcViewName = viewName.toObjC
        XCTAssertEqual(objcViewName.value, .MFA)
        XCTAssertNil(objcViewName.unknownStringValue)
    }

    func testSelectInstitutionToObjC() {
        let viewName = ViewName.selectInstitution
        let objcViewName = viewName.toObjC
        XCTAssertEqual(objcViewName.value, .selectInstitution)
        XCTAssertNil(objcViewName.unknownStringValue)
    }

    func testUnknownToObjCWithCustomString() {
        let customView = "CUSTOM_UNKNOWN_VIEW"
        let viewName = ViewName.unknown(customView)
        let objcViewName = viewName.toObjC

        XCTAssertEqual(objcViewName.value, .none)
        XCTAssertEqual(objcViewName.unknownStringValue, customView)
    }

    func testUnknownToObjCWithEmptyString() {
        let viewName = ViewName.unknown("")
        let objcViewName = viewName.toObjC

        XCTAssertEqual(objcViewName.value, .none)
        XCTAssertEqual(objcViewName.unknownStringValue, "")
    }

    func testDataTransparencyToObjC() {
        let viewName = ViewName.dataTransparency
        let objcViewName = viewName.toObjC
        XCTAssertEqual(objcViewName.value, .dataTransparency)
        XCTAssertNil(objcViewName.unknownStringValue)
    }

    func testToObjCCreatesObjectWithUnknownStringValue() {
        let unknownStrings = [
            "CUSTOM_VIEW_1",
            "CUSTOM_VIEW_2",
            "FUTURE_VIEW_NAME",
            "test_view",
        ]

        for unknownString in unknownStrings {
            let viewName = ViewName.unknown(unknownString)
            let objcViewName = viewName.toObjC

            XCTAssertEqual(objcViewName.value, .none)
            XCTAssertEqual(objcViewName.unknownStringValue, unknownString)
        }
    }

    func testAllKnownViewNamesHaveObjCMapping() {
        for viewName in ViewName.allCases {
            let objcViewName = viewName.toObjC

            // All known cases should have a valid ObjC mapping (not PLKEventNameValueNone)
            XCTAssertNotEqual(
                objcViewName.value,
                PLKViewNameValue.none,
                "View '\(viewName)' must have a valid ObjC mapping, but got .none"
            )
        }
    }
}
