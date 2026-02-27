import Foundation
import LinkKit
import LinkKitObjCInternal

extension LinkEvent {
    var toObjC: PLKLinkEvent {
        return PLKLinkEvent(eventName: eventName.toObjC, eventMetadata: metadata.toObjC)
    }
}
