import Foundation
import LinkKit
import LinkKitObjCInternal

final class PLKPlaidHeadlessSessionShim: NSObject, PLKPlaidHeadlessSession {

    init(session: PlaidHeadlessSession) {
        self.session = session
    }

    func start() {
        session.start()
    }

    private let session: PlaidHeadlessSession
}
