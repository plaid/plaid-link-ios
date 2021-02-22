//
//  LinkKitSwiftUISupport.swift
//  LinkDemo-Swift
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//
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
    
    // The `openOptions` passed to Handler.open
    let openOptions: OpenOptions
    
    // The closure to invoke if there is an error creating the Handler
    let onCreateError: ((Plaid.CreateError) -> Void)?

    init(
        configuration: LinkConfigurationType,
        openOptions: OpenOptions = [:],
        onCreateError: ((Plaid.CreateError) -> Void)? = nil
    ) {
        self.configuration = configuration
        self.openOptions = openOptions
        self.onCreateError = onCreateError
    }
}

// MARK: LinkController SwiftUI <-> UIKit bridge
extension LinkController: UIViewControllerRepresentable {
    
    class Coordinator: NSObject {
        var parent: LinkController
        var handler: Handler?
        
        init(_ parent: LinkController) {
            self.parent = parent
        }
        
        func createHandler() -> Result<Handler, Plaid.CreateError> {
            switch parent.configuration {
            case .publicKey(let configuration):
                return Plaid.create(configuration)
            case .linkToken(let configuration):
                return Plaid.create(configuration)
            }
        }
        
        func present(_ handler: Handler, in viewController: UIViewController) -> Void {
            guard self.handler == nil else {
                // Already presented a handler!
                return
            }
            self.handler = handler

            handler.open(presentUsing: .custom({ linkViewController in
                viewController.addChild(linkViewController)
                viewController.view.addSubview(linkViewController.view)
                linkViewController.view.translatesAutoresizingMaskIntoConstraints = false
                linkViewController.view.frame = viewController.view.bounds
                NSLayoutConstraint.activate([
                    linkViewController.view.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
                    linkViewController.view.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor),
                    linkViewController.view.widthAnchor.constraint(equalTo: viewController.view.widthAnchor),
                    linkViewController.view.heightAnchor.constraint(equalTo: viewController.view.heightAnchor),
                ])
                linkViewController.didMove(toParent: viewController)
            }), parent.openOptions)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController(nibName: nil, bundle: nil)
        
        let handler = context.coordinator.createHandler()
        let present: (Handler) -> Handler = { handler in
            context.coordinator.present(handler, in: viewController)
            return handler
        }
        let handleError: (Plaid.CreateError) -> Plaid.CreateError = { error in
            onCreateError?(error)
            return error
        }
        
        _ = handler.map(present)
        _ = handler.mapError(handleError)
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
