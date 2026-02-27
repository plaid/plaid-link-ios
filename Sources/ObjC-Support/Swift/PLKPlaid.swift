import Foundation
import LinkKit
import LinkKitObjCInternal

@objc public class PLKPlaid: NSObject {

    /// The version of the Plaid Link iOS SDK.
    @objc public static var sdkVersion: String { Plaid.version }

    @objc public static func createPlaidLinkSession(
        configuration: PLKLinkTokenConfiguration
    ) throws -> PLKPlaidLinkSession {
        let config = configuration.toSwift
        let session = try Plaid.createPlaidLinkSession(configuration: config)
        return PLKPlaidLinkSessionShim(session: session)
    }

    @objc public static func createPlaidLayerSession(
        configuration: PLKLayerTokenConfiguration
    ) throws -> PLKPlaidLayerSession {
        let config = configuration.toSwift
        let session = try Plaid.createPlaidLayerSession(configuration: config)
        return PLKPlaidLayerSessionShim(session: session)
    }

    @objc public static func createHeadlessSession(
        configuration: PLKLinkTokenConfiguration
    ) throws -> PLKPlaidHeadlessSession {
        let config = configuration.toSwift
        let session = try Plaid.createHeadlessSession(configuration: config)
        return PLKPlaidHeadlessSessionShim(session: session)
    }

    @objc public static func createEmbeddedLinkUIView(
        configuration: PLKEmbeddedLinkTokenConfiguration,
        presentationHandler: @escaping PLKPresentationHandler,
        dismissalHandler: @escaping PLKDismissalHandler
    ) throws -> UIView {
        let config = configuration.toSwift
        let view = try Plaid.createEmbeddedLinkUIView(
            configuration: config,
            presentationMethod: .custom(presentationHandler, dismissalHandler)
        )
        return view
    }
}
