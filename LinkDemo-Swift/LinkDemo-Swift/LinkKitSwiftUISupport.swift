import LinkKit
import SwiftUI

// The Controller that bridges from SwiftUI to UIKit
struct LinkController {
    // A wrapper enum for either a public key or link token based configuration
    enum LinkConfigurationType {
        case publicKey(LinkPublicKeyConfiguration)
        case linkToken(LinkTokenConfiguration)
    }
    
    // The `configuration` to start Link with
    let configuration: LinkConfigurationType
    
    // The `openOptions` passed to LinkKit.Plaid.Handler.open
    let openOptions: LinkKit.OpenOptions
    
    // The closure to invoke if there is an error creating the LinkKit.Plaid.Handler
    let onCreateError: ((LinkKit.Plaid.CreateError) -> Void)?
    init(configuration: LinkConfigurationType, openOptions: LinkKit.OpenOptions = [:], onCreateError: ((LinkKit.Plaid.CreateError) -> Void)? = nil) {
        self.configuration = configuration
        self.openOptions = openOptions
        self.onCreateError = onCreateError
    }
}

// MARK: LinkController SwiftUI <-> UIKit bridge
extension LinkController: UIViewControllerRepresentable {
    
    class Coordinator: NSObject {
        var parent: LinkController
        var handler: LinkKit.Handler?
        
        init(_ parent: LinkController) {
            self.parent = parent
        }
        
        func createHandler() -> Result<LinkKit.Handler, LinkKit.Plaid.CreateError> {
            switch parent.configuration {
            case .publicKey(let configuration):
                return Plaid.create(configuration)
            case .linkToken(let configuration):
                return Plaid.create(configuration)
            }
        }
        
        func present(_ handler: LinkKit.Handler, in viewController: UIViewController) -> Void {
            guard self.handler == nil else {
                // Already presented a handler!
                return
            }

            handler.open(presentUsing: .viewController(viewController), parent.openOptions)
            self.handler = handler
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController(nibName: nil, bundle: nil)
        
        let handler = context.coordinator.createHandler()
        let present: (LinkKit.Handler) -> LinkKit.Handler = { handler in
            context.coordinator.present(handler, in: viewController)
            return handler
        }
        let handleError: (LinkKit.Plaid.CreateError) -> LinkKit.Plaid.CreateError = { error in
            onCreateError?(error)
            return error
        }
        
        let _ = handler.map(present)
        let _ = handler.mapError(handleError)
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
