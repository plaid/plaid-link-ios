import Foundation
import LinkKit
import LinkKitObjCInternal

extension ViewName {
    var toObjCValue: PLKViewNameValue? {
        switch self {
        case .acceptTOS:
            return .acceptTOS
        case .connected:
            return .connected
        case .consent:
            return .consent
        case .credential:
            return .credential
        case .documentaryVerification:
            return .documentaryVerification
        case .error:
            return .error
        case .exit:
            return .exit
        case .kycCheck:
            return .kycCheck
        case .loading:
            return .loading
        case .matchedConsent:
            return .matchedConsent
        case .matchedCredential:
            return .matchedCredential
        case .matchedMFA:
            return .matchedMFA
        case .mfa:
            return .MFA
        case .numbers:
            return .numbers
        case .profileDataReview:
            return .profileDataReview
        case .oauth:
            return .oauth
        case .recaptcha:
            return .recaptcha
        case .riskCheck:
            return .riskCheck
        case .screening:
            return .screening
        case .selectAccount:
            return .selectAccount
        case .selectInstitution:
            return .selectInstitution
        case .selfieCheck:
            return .selfieCheck
        case .submitDocuments:
            return .submitDocuments
        case .submitDocumentsSuccess:
            return .submitDocumentsSuccess
        case .submitDocumentsError:
            return .submitDocumentsError
        case .uploadDocuments:
            return .uploadDocuments
        case .verifySMS:
            return .verifySMS
        case .dataTransparency:
            return .dataTransparency
        case .dataTransparencyConsent:
            return .dataTransparencyConsent
        case .selectAuthType:
            return .selectAuthType
        case .selectBrand:
            return .selectBrand
        case .numbersSelectInstitution:
            return .numbersSelectInstitution
        case .submitEmail:
            return .submitEmail
        case .submitPhone:
            return .submitPhone
        case .verifyPhone:
            return .verifyPhone
        case .selectSavedInstitution:
            return .selectSavedInstitution
        case .selectSavedAccount:
            return .selectSavedAccount
        case .verifyEmail:
            return .verifyEmail
        case .unknown:
            return nil
        @unknown default:
            return nil
        }
    }

    var toObjC: PLKViewName {
        guard let value = self.toObjCValue else {
            return .create(withUnknownStringValue: description)
        }

        return .create(with: value)
    }
}
