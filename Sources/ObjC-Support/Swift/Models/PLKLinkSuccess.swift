import Foundation
import LinkKit
import LinkKitObjCInternal

extension LinkSuccess {
    var toObjC: PLKLinkSuccess {
        return PLKLinkSuccess(publicToken: publicToken, metadata: metadata.toObjC)
    }
}
