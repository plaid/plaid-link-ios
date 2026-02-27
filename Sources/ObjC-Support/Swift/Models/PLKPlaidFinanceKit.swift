import Foundation
import LinkKit
import LinkKitObjCInternal

// MARK: FinanceKit

#if canImport(FinanceKit) && compiler(>=5.10) && !targetEnvironment(macCatalyst)
@available(iOS 17.4, *)
@objc public final class PLKPlaidFinanceKit: NSObject {

    /// Objective-C compatible version of SyncBehavior.
    /// Note: Objective-C enums must inherit from Int.
    @objc(PLKSyncBehavior)
    public enum PLKSyncBehavior: Int {

        /// Performs a real sync using live FinanceKit data.
        case live

        /// Simulates sync behavior for testing or local development.
        case simulated

        /// Internal helper to convert back to the modern Swift-only enum if needed.
        internal var swiftValue: PlaidFinanceKit.SyncBehavior {
            switch self {
            case .live: return .live
            case .simulated: return .simulated
            }
        }
    }

    @objc public static func syncFinanceKit(
        token: String,
        requestAuthorizationIfNeeded: Bool,
        syncBehavior: PLKSyncBehavior,
        onSuccess: @escaping () -> Void,
        onError: @escaping (NSError) -> Void
    ) {
        PlaidFinanceKit.sync(
            token: token,
            requestAuthorizationIfNeeded: requestAuthorizationIfNeeded,
            syncBehavior: syncBehavior.swiftValue,
            completion: { result in
                switch result {
                case .success:
                    onSuccess()
                case .failure(let error):
                    onError(error.toNSError)
                }
            }
        )
    }
}

@available(iOS 17.4, *)
@objc enum PLKPlaidFinanceKitError: Int {
    case invalidToken
    case permissionError
    case linkApiError
    case permissionAccessError
    case unknown
}

@available(iOS 17.4, *)
extension FinanceKitError {
    var toObjC: PLKPlaidFinanceKitError {
        switch self {
        case .invalidToken:
            return .invalidToken
        case .permissionError:
            return .permissionError
        case .linkApiError:
            return .linkApiError
        case .permissionAccessError:
            return .permissionAccessError
        case .unknown:
            return .unknown
        @unknown default:
            return .unknown
        }
    }

    var toNSError: NSError {
        switch self {
        case .invalidToken(let message), .permissionError(let message),
            .linkApiError(let message), .permissionAccessError(let message):
            return NSError(
                domain: kPLKDefaultErrorDomain,
                code: self.toObjC.rawValue,
                userInfo: ["message": message, NSLocalizedDescriptionKey: message]
            )
        case .unknown(let error):
            return NSError(
                domain: kPLKDefaultErrorDomain,
                code: self.toObjC.rawValue,
                userInfo: [
                    "message": error.localizedDescription, NSLocalizedDescriptionKey: error.localizedDescription,
                ]
            )
        @unknown default:
            return NSError(
                domain: kPLKDefaultErrorDomain,
                code: self.toObjC.rawValue,
                userInfo: [
                    "message": "unknown default", NSLocalizedDescriptionKey: "unknown default",
                ]
            )
        }
    }
}
#endif  // if canImport(FinanceKit) && compiler(>=5.10) && !targetEnvironment(macCatalyst)
