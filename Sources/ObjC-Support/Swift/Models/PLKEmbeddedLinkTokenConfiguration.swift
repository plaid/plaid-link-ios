import Foundation
import LinkKit
import LinkKitObjCInternal

extension PLKEmbeddedLinkTokenConfiguration {
    var toSwift: EmbeddedLinkTokenConfiguration {
        let onSuccess: OnSuccessHandler = { success in
            self.onSuccess(success.toObjC)
        }

        let onExit: OnExitHandler = { exit in
            self.onExit(exit.toObjC)
        }

        let onEvent: OnEventHandler = { event in
            self.onEvent(event.toObjC)
        }

        let result = EmbeddedLinkTokenConfiguration(
            token: token,
            onSuccess: onSuccess,
            onExit: onExit,
            onEvent: onEvent
        )
        return result
    }
}
