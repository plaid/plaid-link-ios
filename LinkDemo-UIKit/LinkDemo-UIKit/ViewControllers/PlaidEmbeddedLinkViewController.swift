//
//  PlaidEmbeddedLinkViewController.swift
//  LinkDemo-UIKit
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

import LinkKit
import UIKit

class PlaidEmbeddedLinkViewController: UIViewController {

    init(linkToken: String) {
        self.linkToken = linkToken
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "PlaidEmbeddedLink"
        view.backgroundColor = .systemBackground

        setupUI()
        updateUI()
        createEmbeddedView()
    }

    // MARK: - Link Setup

    private func createEmbeddedView() {
        let configuration = EmbeddedLinkTokenConfiguration(
            token: linkToken,
            onSuccess: { linkSuccess in
                print("public-token: \(linkSuccess.publicToken) metadata: \(linkSuccess.metadata)")
            },
            onExit: { [weak self] linkExit in
                if let error = linkExit.error {
                    print("exit with \(error)\n\(linkExit.metadata)")
                    DispatchQueue.main.async {
                        self?.state = .error(error.displayMessage ?? "Exited with error")
                    }
                } else {
                    print("exit with \(linkExit.metadata)")
                }
            },
            onEvent: { linkEvent in
                print("Link Event: \(linkEvent)")
            }
        )

        do {
            let embeddedView = try Plaid.createEmbeddedLinkUIView(
                configuration: configuration,
                presentationMethod: .viewController(self)
            )

            self.embeddedSearchView = embeddedView
            self.state = .ready

            embeddedView.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(embeddedView)

            NSLayoutConstraint.activate([
                embeddedView.topAnchor.constraint(equalTo: containerView.topAnchor),
                embeddedView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                embeddedView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                embeddedView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                embeddedView.heightAnchor.constraint(equalToConstant: 400),
            ])

        } catch {
            self.state = .error(error.localizedDescription)
        }
    }

    // MARK: - UI

    private let linkToken: String
    private var embeddedSearchView: UIView?
    private var state: LoadingState = .loading {
        didSet {
            updateUI()
        }
    }

    private let titleLabel = UILabel()
    private let versionLabel = UILabel()
    private let errorLabel = UILabel()
    private let containerView = UIView()

    private func updateUI() {
        switch state {
        case .loading:
            errorLabel.isHidden = true
        case .ready:
            errorLabel.isHidden = true
        case .error(let message):
            errorLabel.text = message
            errorLabel.isHidden = false
        }
    }

    private func setupUI() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        titleLabel.text = "Plaid Embedded Link View Example"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        stackView.addArrangedSubview(titleLabel)

        versionLabel.text = "LinkKit"
        versionLabel.font = .systemFont(ofSize: 14)
        versionLabel.textColor = .secondaryLabel
        versionLabel.textAlignment = .center
        stackView.addArrangedSubview(versionLabel)

        errorLabel.font = .systemFont(ofSize: 14)
        errorLabel.textColor = .systemRed
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true
        stackView.addArrangedSubview(errorLabel)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(containerView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
}
