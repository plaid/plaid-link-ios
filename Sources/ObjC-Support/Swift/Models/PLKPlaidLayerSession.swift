import Foundation
import LinkKit
import LinkKitObjCInternal

/// Protocol defining the required methods for a Layer session
protocol LayerSessionProtocol {
    func submit(data: SubmissionData)
    func open(using: PresentationMethod)
}

/// Extension to make PlaidLayerSession conform to the protocol
extension PlaidLayerSession: LayerSessionProtocol {}

final class PLKPlaidLayerSessionShim: NSObject, PLKPlaidLayerSession {

    init(session: LayerSessionProtocol) {
        self.session = session
    }

    func submit(_ data: PLKSubmissionData) {
        session.submit(data: SwiftPLKSubmissionData(data: data))
    }

    func open(
        presentationHandler: @escaping PLKPresentationHandler,
        dismissalHandler: @escaping PLKDismissalHandler
    ) {
        session.open(using: .custom(presentationHandler, dismissalHandler))
    }

    internal struct SwiftPLKSubmissionData: SubmissionData {
        var phoneNumber: String?
        var dateOfBirth: String?
        var params: [String: String]?

        init(data: PLKSubmissionData) {
            phoneNumber = data.phoneNumber
            dateOfBirth = data.dateOfBirth
            params = data.params
        }
    }

    private let session: LayerSessionProtocol
}
