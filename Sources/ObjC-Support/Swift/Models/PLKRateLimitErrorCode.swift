import Foundation
import LinkKit
import LinkKitObjCInternal

extension RateLimitErrorCode {
    var toObjC: PLKRateLimitErrorCode? {
        switch self {
        case .accountsLimit:
            return .accountsLimit
        case .additionLimit:
            return .additionLimit
        case .authLimit:
            return .authLimit
        case .identityLimit:
            return .identityLimit
        case .incomeLimit:
            return .incomeLimit
        case .itemGetLimit:
            return .itemGetLimit
        case .rateLimit:
            return .rateLimit
        case .transactionsLimit:
            return .transactionsLimit
        case .unknown:
            return nil
        @unknown default:
            return nil
        }
    }
}
