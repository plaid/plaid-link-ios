import Foundation
import LinkKit
import LinkKitObjCInternal

extension Institution {
    var toObjC: PLKInstitution {
        return PLKInstitution(id: id, name: name)
    }
}
