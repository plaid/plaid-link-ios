import Foundation
import LinkKit
import LinkKitObjCInternal

extension MFAType {
    var toObjC: PLKMFAType {
        switch self {
        case .code:
            return .code
        case .device:
            return .device
        case .questions:
            return .questions
        case .selections:
            return .selections
        @unknown default:
            return .none
        }
    }
}
