import Foundation
import LinkKit
import LinkKitObjCInternal

@objc enum PLKPlaidConfigurationError: Int {
    case invalidToken
}

extension ConfigurationError {
    var toObjC: PLKPlaidConfigurationError {
        switch self {
        case .invalidToken:
            return .invalidToken
        @unknown default:
            return .invalidToken
        }
    }

    var nsError: NSError {
        switch self {
        case .invalidToken(let message):
            return NSError(
                domain: kPLKDefaultErrorDomain,
                code: self.toObjC.rawValue,
                userInfo: ["message": message, NSLocalizedDescriptionKey: message]
            )
        @unknown default:
            return NSError(
                domain: kPLKDefaultErrorDomain,
                code: self.toObjC.rawValue,
                userInfo: ["message": message, NSLocalizedDescriptionKey: "unknown default"]
            )
        }
    }
}
