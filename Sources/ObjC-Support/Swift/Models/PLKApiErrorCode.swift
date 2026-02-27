import Foundation
import LinkKit
import LinkKitObjCInternal

extension ApiErrorCode {
    var toObjC: PLKApiErrorCode? {
        switch self {
        case .internalServerError:
            return .internalServerError
        case .plannedMaintenance:
            return .plannedMaintenance
        case .unknown:
            return nil
        @unknown default:
            return nil
        }
    }
}
