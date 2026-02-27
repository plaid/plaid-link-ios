import Foundation
import LinkKit
import LinkKitObjCInternal

extension InstitutionErrorCode {
    var toObjC: PLKInstitutionErrorCode? {
        switch self {
        case .institutionDown:
            return .institutionDown
        case .institutionNotResponding:
            return .institutionNotResponding
        case .institutionNotAvailable:
            return .institutionNotAvailable
        case .institutionNoLongerSupported:
            return .institutionNoLongerSupported
        case .unknown:
            return nil
        @unknown default:
            return nil
        }
    }
}
