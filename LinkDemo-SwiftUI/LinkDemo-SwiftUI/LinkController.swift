//
//  LinkKitSwiftUISupport.swift
//  LinkDemo-Swift
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

import LinkKit
import SwiftUI

// The Controller that bridges from SwiftUI to UIKit.
struct LinkController: UIViewControllerRepresentable {

    // Result from the attempt to create a Handler.
    // This only results in an error if the token is malformed.
    private let createResult: Result<Handler, Plaid.CreateError>

    init(configuration: LinkTokenConfiguration) {
        createResult = Plaid.create(configuration)
    }

    final class Coordinator: NSObject {
        private let parent: LinkController
        private let createResult: Result<Handler, Plaid.CreateError>

        fileprivate init(parent: LinkController, createResult: Result<Handler, Plaid.CreateError>) {
            self.parent = parent
            self.createResult = createResult
        }

        fileprivate func present(_ handler: Handler, in viewController: UIViewController) {
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
        Coordinator(parent: self, createResult: createResult)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        switch createResult {
        case .success(let handler):
            let viewController = UIViewController()
            context.coordinator.present(handler, in: viewController)
            return viewController
        case .failure(let createError):
            return CreateErrorViewController(error: createError)
        }
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Empty implementation
    }

    final class CreateErrorViewController: UIViewController {
        init(error: Plaid.CreateError) {
            self.error = error
            super.init(nibName: nil, bundle: nil)
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewDidLoad() {
            super.viewDidLoad()

            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 17)
            label.text = "Link Creation Error: \(error)"
            label.numberOfLines = 0
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false

            view.addSubview(label)
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
                label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        }

        private let error: Plaid.CreateError
    }
}
