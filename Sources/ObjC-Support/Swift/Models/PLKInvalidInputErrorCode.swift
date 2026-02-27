import Foundation
import LinkKit
import LinkKitObjCInternal

extension InvalidInputErrorCode {
    var toObjC: PLKInvalidInputErrorCode? {
        switch self {
        case .invalidApiKeys:
            return .invalidApiKeys
        case .unauthorizedEnvironment:
            return .unauthorizedEnvironment
        case .invalidAccessToken:
            return .invalidAccessToken
        case .invalidPublicToken:
            return .invalidPublicToken
        case .invalidProduct:
            return .invalidProduct
        case .invalidAccountId:
            return .invalidAccountId
        case .invalidInstitution:
            return .invalidInstitution
        case .tooManyVerificationAttempts:
            return .tooManyVerificationAttempts
        case .unknown:
            return nil
        @unknown default:
            return nil
        }
    }
}
