import Foundation
import LinkKit
import LinkKitObjCInternal

extension ExitStatus {
    var toObjCValue: PLKExitStatusValue? {
        switch self {
        case .requiresQuestions:
            return .requiresQuestions

        case .requiresSelections:
            return .requiresSelections

        case .requiresCode:
            return .requiresCode

        case .chooseDevice:
            return .chooseDevice

        case .requiresCredentials:
            return .requiresCredentials

        case .institutionNotFound:
            return .institutionNotFound

        case .requiresAccountSelection:
            return .requiresAccountSelection

        case .continueToThirdParty:
            return .continueToThridParty

        case .unknown:
            return nil

        @unknown default:
            return nil
        }
    }

    var toObjC: PLKExitStatus {
        guard let value = self.toObjCValue else {
            return .create(withUnknownStringValue: description)
        }

        return .create(with: value)
    }
}
