import Foundation
import LinkKit
import LinkKitObjCInternal

extension AuthErrorCode {
    var toObjC: PLKAuthErrorCode? {
        switch self {
        case .productNotReady:
            return .productNotReady
        case .verificationExpired:
            return .verificationExpired
        case .unknown:
            return nil
        @unknown default:
            return nil
        }
    }
}
