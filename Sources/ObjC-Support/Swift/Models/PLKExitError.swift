import Foundation
import LinkKit
import LinkKitObjCInternal

extension ExitError {
    var toObjC: NSError {
        var userInfo: [String: String] = [
            kPLKExitErrorMessageKey: errorMessage,
            kPLKExitErrorDisplayMessageKey: displayMessage ?? "",
            NSLocalizedDescriptionKey: displayMessage ?? "",
            kPLKExitErrorRawJSONKey: errorJSON ?? "",
        ]

        let errorDomain: String
        let errorCodeInt: Int?
        let errorCodeString: String?
        switch errorCode {

        case .apiError(let code):
            errorDomain = kPLKExitErrorApiDomain
            errorCodeInt = code.toObjC?.rawValue
            errorCodeString = code.description
        case .authError(let code):
            errorDomain = kPLKExitErrorAuthDomain
            errorCodeInt = code.toObjC?.rawValue
            errorCodeString = code.description
        case .assetReportError(let code):
            errorDomain = kPLKExitErrorAssetReportDomain
            errorCodeInt = code.toObjC?.rawValue
            errorCodeString = code.description
        case .internal(let code):
            errorDomain = kPLKExitErrorInternalDomain
            errorCodeInt = nil
            errorCodeString = code
        case .institutionError(let code):
            errorDomain = kPLKExitErrorInstitutionErrorDomain
            errorCodeInt = code.toObjC?.rawValue
            errorCodeString = code.description
        case .itemError(let code):
            errorDomain = kPLKExitErrorItemDomain
            errorCodeInt = code.toObjC?.rawValue
            errorCodeString = code.description
        case .invalidInput(let code):
            errorDomain = kPLKExitErrorInvalidInputDomain
            errorCodeInt = code.toObjC?.rawValue
            errorCodeString = code.description
        case .invalidRequest(let code):
            errorDomain = kPLKExitErrorInvalidRequestDomain
            errorCodeInt = code.toObjC?.rawValue
            errorCodeString = code.description
        case .rateLimitExceeded(let code):
            errorDomain = kPLKExitErrorRateLimitExceededDomain
            errorCodeInt = code.toObjC?.rawValue
            errorCodeString = code.description
        case .unknown(let type, let code):
            errorDomain = kPLKExitErrorUnknownDomain
            userInfo[kPLKExitErrorUnknownTypeKey] = type
            errorCodeInt = nil
            errorCodeString = code
        @unknown default:
            errorDomain = kPLKExitErrorUnknownDomain
            userInfo[kPLKExitErrorUnknownTypeKey] = "unknown default"
            errorCodeInt = 5555
            errorCodeString = "5555"
        }

        userInfo[kPLKExitErrorCodeKey] = errorCodeString

        return NSError(
            domain: errorDomain,
            code: errorCodeInt ?? -1,
            userInfo: userInfo
        )
    }
}
