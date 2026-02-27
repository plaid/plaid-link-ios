import Foundation
import LinkKit
import LinkKitObjCInternal

extension PLKLayerTokenConfiguration {
    var toSwift: LayerTokenConfiguration {
        let onSuccess: OnSuccessHandler = { success in
            self.onSuccess(success.toObjC)
        }

        let onExit: OnExitHandler = { exit in
            self.onExit(exit.toObjC)
        }

        let onEvent: OnEventHandler = { event in
            self.onEvent(event.toObjC)
        }

        let result = LayerTokenConfiguration(token: token, onSuccess: onSuccess, onExit: onExit, onEvent: onEvent)
        return result
    }
}
