//
//  ViewController.swift
//  LinkDemo-Swift-UIKit
//
//  Copyright © 2023 Plaid Inc. All rights reserved.
//

import UIKit
import LinkKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a Handler right away so Link can begin loading prior to the user pressing the button.
        createLinkHandler()

        setupUI()
    }

    private let vStack = UIStackView()
    private let welcomeLabel = UILabel()
    private let titleLabel = UILabel()
    private let demoInfoLabel = UILabel()
    private let openButton = UIButton()
    private let plaidBlue = UIColor(red: 0.039, green: 0.522, blue: 0.918, alpha: 1.0)

    // Link Handler
    private var handler: Handler?

    @objc private func openButtonPressed() {
        openLink()
    }

    private func createLinkHandler() {
        let configuration = createLinkTokenConfiguration()

        let result = Plaid.create(configuration)
        switch result {
        case .failure(let error):
            print("Unable to create Plaid handler due to: \(error)")
        case .success(let handler):
            self.handler = handler
        }
    }

    private func openLink() {
        handler?.open(presentUsing: .viewController(self))
    }

    private func createLinkTokenConfiguration() -> LinkTokenConfiguration {
        // Steps to acquire a Link Token:
        //
        // 1. Sign up for a Plaid account to get an API key.
        //      Ref - https://dashboard.plaid.com/signup
        // 2. Make a request to our API using your API key.
        //      Ref - https://plaid.com/docs/quickstart/#introduction
        //      Ref - https://plaid.com/docs/api/tokens/#linktokencreate

        #warning("Replace <#GENERATED_LINK_TOKEN#> below with your link_token")
        let linkToken = "<#GENERATED_LINK_TOKEN#>"

        // In your production application replace the hardcoded linkToken above with code that fetches a linkToken
        // from your backend server which in turn retrieves it securely from Plaid, for details please refer to
        // https://plaid.com/docs/api/tokens/#linktokencreate

        var linkConfiguration = LinkTokenConfiguration(token: linkToken) { success in
            // Closure is called when a user successfully links an Item. It should take a single LinkSuccess argument,
            // containing the publicToken String and a metadata of type SuccessMetadata.
            // Ref - https://plaid.com/docs/link/ios/#onsuccess
            print("public-token: \(success.publicToken) metadata: \(success.metadata)")
        }

        // Optional closure is called when a user exits Link without successfully linking an Item,
        // or when an error occurs during Link initialization. It should take a single LinkExit argument,
        // containing an optional error and a metadata of type ExitMetadata.
        // Ref - https://plaid.com/docs/link/ios/#onexit
        linkConfiguration.onExit = { exit in
            if let error = exit.error {
                print("exit with \(error)\n\(exit.metadata)")
            } else {
                // User exited the flow without an error.
                print("exit with \(exit.metadata)")
            }
        }

        // Optional closure is called when certain events in the Plaid Link flow have occurred, for example,
        // when the user selected an institution. This enables your application to gain further insight into
        // what is going on as the user goes through the Plaid Link flow.
        // Ref - https://plaid.com/docs/link/ios/#onevent
        linkConfiguration.onEvent = { event in
            print("Link Event: \(event)")
        }

        return linkConfiguration
    }
}

// MARK: UI Layout

extension ViewController {

    private func setupUI() {
        view.backgroundColor = .white

        setupLabels()
        setupButton()
    }

    private func setupLabels() {
        welcomeLabel.numberOfLines = 1
        welcomeLabel.text = "WELCOME"
        welcomeLabel.font = .boldSystemFont(ofSize: 12)
        welcomeLabel.textColor = plaidBlue

        titleLabel.numberOfLines = 0
        titleLabel.text = "Plaid Link SDK\nUIKit Example"
        titleLabel.font = .systemFont(ofSize: 32, weight: .light)

        let linkKitBundle  = Bundle(for: PLKPlaid.self)
        let linkKitVersion = linkKitBundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? ""
        let linkKitBuild   = linkKitBundle.object(forInfoDictionaryKey: kCFBundleVersionKey as String) ?? ""
        let linkKitName    = linkKitBundle.object(forInfoDictionaryKey: kCFBundleNameKey as String) ?? ""

        demoInfoLabel.numberOfLines = 1
        demoInfoLabel.text = "\(linkKitName) \(linkKitVersion)+\(linkKitBuild)"
        demoInfoLabel.font = .systemFont(ofSize: 12)
        demoInfoLabel.textColor = UIColor.lightGray

        vStack.axis = .vertical
        vStack.spacing = 4
        vStack.distribution = .fill
        vStack.addArrangedSubview(welcomeLabel)
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(demoInfoLabel)
        vStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(vStack)
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
    }

    private func setupButton() {
        openButton.backgroundColor = plaidBlue
        openButton.addTarget(self, action: #selector(openButtonPressed), for: .touchUpInside)
        openButton.layer.cornerRadius = 8
        openButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        openButton.setTitle("Open Plaid Link", for: .normal)
        openButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(openButton)
        NSLayoutConstraint.activate([
            openButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            openButton.leadingAnchor.constraint(equalTo: vStack.leadingAnchor),
            openButton.trailingAnchor.constraint(equalTo: vStack.trailingAnchor),
            openButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
}
