import Foundation
import LinkKit
import LinkKitObjCInternal

extension EventName {
    private var toObjCValue: PLKEventNameValue? {
        switch self {
        case .autoSubmitPhone:
            return .autoSubmitPhone
        case .bankIncomeInsightsCompleted:
            return .bankIncomeInsightsCompleted
        case .closeOAuth:
            return .closeOAuth
        case .error:
            return .error
        case .exit:
            return .exit
        case .failOAuth:
            return .failOAuth
        case .handoff:
            return .handoff
        case .identityVerificationStartStep:
            return .identityVerificationStartStep
        case .identityVerificationPassStep:
            return .identityVerificationPassStep
        case .identityVerificationFailStep:
            return .identityVerificationFailStep
        case .identityVerificationPendingReviewStep:
            return .identityVerificationPendingReviewStep
        case .identityVerificationPendingReviewSession:
            return .identityVerificationPendingReviewSession
        case .identityVerificationCreateSession:
            return .identityVerificationCreateSession
        case .identityVerificationResumeSession:
            return .identityVerificationResumeSession
        case .identityVerificationPassSession:
            return .identityVerificationPassSession
        case .identityVerificationFailSession:
            return .identityVerificationFailSession
        case .identityVerificationOpenUI:
            return .identityVerificationOpenUI
        case .identityVerificationResumeUI:
            return .identityVerificationResumeUI
        case .identityVerificationCloseUI:
            return .identityVerificationCloseUI
        case .layerAutoFillNotAvailable:
            return .layerAutoFillNotAvailable
        case .layerReady:
            return .layerReady
        case .layerNotAvailable:
            return .layerNotAvailable
        case .matchedSelectInstitution:
            return .matchedSelectInstitution
        case .matchedSelectVerifyMethod:
            return .matchedSelectVerifyMethod
        case .open:
            return .open
        case .openMyPlaid:
            return .openMyPlaid
        case .openOAuth:
            return .openOAuth
        case .profileEligibilityCheckReady:
            return .profileEligibilityCheckReady
        case .profileEligibilityCheckError:
            return .profileEligibilityCheckError
        case .searchInstitution:
            return .searchInstitution
        case .selectDegradedInstitution:
            return .selectInstitution
        case .selectDownInstitution:
            return .selectInstitution
        case .selectInstitution:
            return .selectInstitution
        case .submitCredentials:
            return .submitCredentials
        case .submitMFA:
            return .submitMFA
        case .transitionView:
            return .transitionView
        case .selectFilteredInstitution:
            return .selectFilteredInstitution
        case .selectBrand:
            return .selectBrand
        case .selectAuthType:
            return .selectAuthType
        case .submitAccountNumber:
            return .submitAccountNumber
        case .submitDocuments:
            return .submitDocuments
        case .submitDocumentsSuccess:
            return .submitDocumentsSuccess
        case .submitDocumentsError:
            return .submitDocumentsError
        case .submitRoutingNumber:
            return .submitRoutingNumber
        case .viewDataTypes:
            return .viewDataTypes
        case .submitPhone:
            return .submitPhone
        case .skipSubmitPhone:
            return .skipSubmitPhone
        case .submitOTP:
            return .submitOTP
        case .verifyPhone:
            return .verifyPhone
        case .connectNewInstitution:
            return .connectNewInstitution
        case .submitEmail:
            return .submitEmail
        case .skipSubmitEmail:
            return .skipSubmitEmail
        case .rememberMeEnabled:
            return .rememberMeEnabled
        case .rememberMeDisabled:
            return .rememberMeDisabled
        case .rememberMeHoldout:
            return .rememberMeHoldout
        case .selectSavedInstitution:
            return .selectSavedInstitution
        case .selectSavedAccount:
            return .selectSavedAccount
        case .autoSelectSavedInstitution:
            return .autoSelectSavedInstitution
        case .plaidCheckPane:
            return .plaidCheckPane
        case .unknown:
            return nil
        case .identityMatchPassed:
            return .identityMatchPassed
        case .identityMatchFailed:
            return .identityMatchFailed
        case .issueFollowed:
            return .issueFollowed
        case .selectAccount:
            return .selectAccount
        @unknown default:
            return nil
        }
    }

    var toObjC: PLKEventName {
        guard let value = self.toObjCValue else {
            return .create(withUnknownStringValue: description)
        }

        return .create(with: value)
    }
}
