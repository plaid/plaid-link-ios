import Foundation
import LinkKit
import LinkKitObjCInternal

extension VerificationStatus {
    private var toObjCValue: PLKVerificationStatusValue? {
        switch self {
        case .pendingAutomaticVerification:
            return .pendingAutomaticVerification
        case .pendingManualVerification:
            return .pendingManualVerification
        case .manuallyVerified:
            return .manuallyVerified
        case .unknown:
            return nil
        @unknown default:
            return nil
        }
    }

    var toObjC: PLKVerificationStatus {
        guard let value = self.toObjCValue else {
            return .create(withUnknownStringValue: description)
        }

        return .create(with: value)
    }
}
