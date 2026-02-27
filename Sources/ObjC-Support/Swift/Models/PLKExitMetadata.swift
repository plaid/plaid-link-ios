import Foundation
import LinkKit
import LinkKitObjCInternal

extension ExitMetadata {
    var toObjC: PLKExitMetadata {
        return PLKExitMetadata(
            status: status?.toObjC,
            institution: institution?.toObjC,
            requestID: requestID,
            linkSessionID: linkSessionID,
            metadataJSON: metadataJSON
        )
    }
}
