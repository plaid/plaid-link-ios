//
//  PlaidLinkSessionViewController.swift
//  LinkDemo-UIKit
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

import LinkKit
import UIKit

class PlaidLinkSessionViewController: UIViewController {

    init(linkToken: String) {
        self.linkToken = linkToken
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "PlaidLinkSession"
        view.backgroundColor = .systemBackground

        setupUI()
        updateUI()
        createSession()
    }

    // MARK: Link Setup

    private func createSession() {
        let configuration = LinkTokenConfiguration(
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
            },
            onLoad: { [weak self] in
                DispatchQueue.main.async {
                    self?.state = .ready
                }
            }
        )

        do {
            let session = try Plaid.createPlaidLinkSession(configuration: configuration)
            self.linkSession = session
        } catch {
            self.state = .error(error.localizedDescription)
        }
    }

    // MARK: Open Link

    @objc private func connectButtonTapped() {
        guard let linkSession = linkSession else { return }
        linkSession.open(using: .viewController(self))
    }

    // MARK: UI

    private let linkToken: String
    private var linkSession: PlaidLinkSession?
    private var state: LoadingState = .loading {
        didSet {
            updateUI()
        }
    }

    private let titleLabel = UILabel()
    private let versionLabel = UILabel()
    private let errorLabel = UILabel()
    private let connectButton = UIButton(type: .system)
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    private func updateUI() {
        switch state {
        case .loading:
            activityIndicator.startAnimating()
            connectButton.isEnabled = false
            connectButton.backgroundColor = .systemGray
            errorLabel.isHidden = true
        case .ready:
            activityIndicator.stopAnimating()
            connectButton.isEnabled = true
            connectButton.backgroundColor = .systemBlue
            errorLabel.isHidden = true
        case .error(let message):
            activityIndicator.stopAnimating()
            connectButton.isEnabled = false
            connectButton.backgroundColor = .systemGray
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

        titleLabel.text = "Plaid Link Session Example"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        stackView.addArrangedSubview(titleLabel)

        versionLabel.text = "LinkKit \(Plaid.version)"
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

        connectButton.setTitle("Connect Bank Account", for: .normal)
        connectButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        connectButton.setTitleColor(.white, for: .normal)
        connectButton.backgroundColor = .systemBlue
        connectButton.layer.cornerRadius = 10
        connectButton.addTarget(self, action: #selector(connectButtonTapped), for: .touchUpInside)
        connectButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(connectButton)

        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        connectButton.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            connectButton.heightAnchor.constraint(equalToConstant: 56),

            activityIndicator.leadingAnchor.constraint(equalTo: connectButton.leadingAnchor, constant: 16),
            activityIndicator.centerYAnchor.constraint(equalTo: connectButton.centerYAnchor),
        ])
    }
}
