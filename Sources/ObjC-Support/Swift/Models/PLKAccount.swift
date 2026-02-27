import Foundation
import LinkKit
import LinkKitObjCInternal

extension Account {
    var toObjC: PLKAccount {
        return PLKAccount(
            accountID: id,
            name: name,
            mask: mask,
            subtype: subtype.toObjC,
            verificationStatus: verificationStatus?.toObjC
        )
    }
}
