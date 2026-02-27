import Foundation
import LinkKit
import LinkKitObjCInternal

extension PLKEnvironment {
    var toSwift: Environment? {
        switch self {
        case .production:
            return .production
        case .sandbox:
            return .sandbox
        @unknown default:
            return nil
        }
    }
}
