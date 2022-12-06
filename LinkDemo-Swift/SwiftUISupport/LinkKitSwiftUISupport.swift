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

    // The closure to invoke if there is an error creating the Handler
    let onCreateError: ((Plaid.CreateError) -> Void)?

    // A reference to the `Handler`, if one has been created.
    @State private(set) var linkHandler: Handler?

    init(
        configuration: LinkConfigurationType,
        onCreateError: ((Plaid.CreateError) -> Void)? = nil
    ) {
        self.configuration = configuration
        self.onCreateError = onCreateError
    }
}

// MARK: LinkController SwiftUI <-> UIKit bridge
extension LinkController: UIViewControllerRepresentable {

    final class Coordinator: NSObject {
        private(set) var parent: LinkController
        private(set) var handler: Handler?

        fileprivate init(_ parent: LinkController) {
            self.parent = parent
        }

        fileprivate func createHandler() -> Result<Handler, Plaid.CreateError> {
            switch parent.configuration {
            case .publicKey(let configuration):
                return Plaid.create(configuration)
            case .linkToken(let configuration):
                return Plaid.create(configuration)
            }
        }

        fileprivate func present(_ handler: Handler, in viewController: UIViewController) -> Void {
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
            }))
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()

        let handlerResult = context.coordinator.createHandler()
        switch handlerResult {
        case .success(let handler):
            context.coordinator.present(handler, in: viewController)
            linkHandler = handler
        case .failure(let createError):
            onCreateError?(createError)
        }

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Empty implementation
    }
}

