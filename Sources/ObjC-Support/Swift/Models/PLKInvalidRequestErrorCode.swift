import Foundation
import LinkKit
import LinkKitObjCInternal

extension InvalidRequestErrorCode {
    var toObjC: PLKInvalidRequestErrorCode? {
        switch self {
        case .missingFields:
            return .missingFields
        case .unknownFields:
            return .unknownFields
        case .invalidField:
            return .invalidField
        case .invalidBody:
            return .invalidBody
        case .invalidAddress:
            return .invalidAddress
        case .notFound:
            return .notFound
        case .sandboxOnly:
            return .sandboxOnly
        case .unknown:
            return nil
        @unknown default:
            return nil
        }
    }
}
