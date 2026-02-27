import Foundation
import LinkKit
import LinkKitObjCInternal

extension SuccessMetadata {
    var toObjC: PLKSuccessMetadata {
        return PLKSuccessMetadata(
            linkSessionID: linkSessionID,
            institution: institution.toObjC,
            accounts: accounts.map(\.toObjC),
            metadataJSON: metadataJSON
        )
    }
}
