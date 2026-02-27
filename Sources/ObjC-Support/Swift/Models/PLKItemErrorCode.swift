import Foundation
import LinkKit
import LinkKitObjCInternal

extension ItemErrorCode {
    var toObjC: PLKItemErrorCode? {
        switch self {
        case .insufficientCredentials:
            return .insufficientCredentials
        case .invalidCredentials:
            return .invalidCredentials
        case .invalidMfa:
            return .invalidMfa
        case .invalidSendMethod:
            return .invalidSendMethod
        case .invalidUpdatedUsername:
            return .invalidUpdatedUsername
        case .itemLocked:
            return .itemLocked
        case .itemLoginRequired:
            return .itemLoginRequired
        case .itemNoError:
            return .itemNoError
        case .itemNotSupported:
            return .itemNotSupported
        case .incorrectDepositAmounts:
            return .incorrectDepositAmounts
        case .userSetupRequired:
            return .userSetupRequired
        case .mfaNotSupported:
            return .mfaNotSupported
        case .noAccounts:
            return .noAccounts
        case .noAuthAccounts:
            return .noAuthAccounts
        case .noInvestmentAccounts:
            return .noInvestmentAccounts
        case .noLiabilityAccounts:
            return .noLiabilityAccounts
        case .productNotReady:
            return .productNotReady
        case .productsNotSupported:
            return .productsNotSupported
        case .instantMatchFailed:
            return .instantMatchFailed
        case .unknown:
            return nil
        @unknown default:
            return nil
        }
    }
}
