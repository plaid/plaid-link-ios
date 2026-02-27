import Foundation
import LinkKit
import LinkKitObjCInternal

extension LinkExit {
    var toObjC: PLKLinkExit {
        return PLKLinkExit(error: error?.toObjC, metadata: metadata.toObjC)
    }
}
