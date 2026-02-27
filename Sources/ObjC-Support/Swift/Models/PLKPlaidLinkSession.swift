import Foundation
import LinkKit
import LinkKitObjCInternal

/// Protocol defining the required methods for a Layer session
protocol LinkSessionProtocol {
    var showGradientBackground: Bool { get set }
    func open(using: PresentationMethod)
}

/// Extension to make PlaidLayerSession conform to the protocol
extension PlaidLinkSession: LinkSessionProtocol {}

final class PLKPlaidLinkSessionShim: NSObject, PLKPlaidLinkSession {

    init(session: LinkSessionProtocol) {
        self.session = session
    }

    var showGradientBackground: Bool = false {
        didSet {
            session.showGradientBackground = showGradientBackground
        }
    }

    func open(
        presentationHandler: @escaping PLKPresentationHandler,
        dismissalHandler: @escaping PLKDismissalHandler
    ) {
        session.open(using: .custom(presentationHandler, dismissalHandler))
    }

    private var session: LinkSessionProtocol
}
