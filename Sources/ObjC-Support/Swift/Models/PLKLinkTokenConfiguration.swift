import Foundation
import LinkKit
import LinkKitObjCInternal

extension PLKLinkTokenConfiguration {
    var toSwift: LinkTokenConfiguration {
        let onSuccess: OnSuccessHandler = { success in
            self.onSuccess(success.toObjC)
        }

        let onExit: OnExitHandler = { exit in
            self.onExit(exit.toObjC)
        }

        let onEvent: OnEventHandler = { event in
            self.onEvent(event.toObjC)
        }

        let onLoad: OnLoadHandler = {
            self.onLoad?()
        }

        let result = LinkTokenConfiguration(
            token: token,
            onSuccess: onSuccess,
            onExit: onExit,
            onEvent: onEvent,
            onLoad: onLoad
        )

        return result
    }
}
