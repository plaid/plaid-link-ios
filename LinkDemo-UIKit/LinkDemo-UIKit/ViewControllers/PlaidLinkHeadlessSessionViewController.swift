//
//  PlaidLinkHeadlessSessionViewController.swift
//  LinkDemo-UIKit
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

import LinkKit
import UIKit

class PlaidLinkHeadlessSessionViewController: UIViewController {

    init(linkToken: String) {
        self.linkToken = linkToken
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "PlaidLinkHeadlessSession"
        view.backgroundColor = .systemBackground

        setupUI()
        updateUI()
        createSession()
    }

    // MARK: - Link Setup

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
            let session = try Plaid.createHeadlessSession(configuration: configuration)
            self.headlessSession = session
        } catch {
            self.state = .error(error.localizedDescription)
        }
    }

    // MARK: - Launch Headless Session

    @objc private func launchButtonTapped() {
        guard let headlessSession = headlessSession else { return }
        headlessSession.start()
    }

    // MARK: - UI

    private let linkToken: String
    private var headlessSession: PlaidHeadlessSession?
    private var state: LoadingState = .loading {
        didSet {
            updateUI()
        }
    }

    private let titleLabel = UILabel()
    private let versionLabel = UILabel()
    private let warningLabel = UILabel()
    private let errorLabel = UILabel()
    private let launchButton = UIButton(type: .system)
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    private func updateUI() {
        switch state {
        case .loading:
            activityIndicator.startAnimating()
            launchButton.isEnabled = false
            launchButton.backgroundColor = .systemGray
            errorLabel.isHidden = true
        case .ready:
            activityIndicator.stopAnimating()
            launchButton.isEnabled = true
            launchButton.backgroundColor = .systemBlue
            errorLabel.isHidden = true
        case .error(let message):
            activityIndicator.stopAnimating()
            launchButton.isEnabled = false
            launchButton.backgroundColor = .systemGray
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

        titleLabel.text = "Plaid Link Headless Session Example"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        stackView.addArrangedSubview(titleLabel)

        versionLabel.text = "LinkKit"
        versionLabel.font = .systemFont(ofSize: 14)
        versionLabel.textColor = .secondaryLabel
        versionLabel.textAlignment = .center
        stackView.addArrangedSubview(versionLabel)

        warningLabel.text =
            "⚠️ Important: The link token must be a payment token that triggers a \"headless\" flow, otherwise the flow will consistently error out."
        warningLabel.font = .systemFont(ofSize: 14)
        warningLabel.textColor = .systemOrange
        warningLabel.textAlignment = .center
        warningLabel.numberOfLines = 0
        stackView.addArrangedSubview(warningLabel)

        errorLabel.font = .systemFont(ofSize: 14)
        errorLabel.textColor = .systemRed
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true
        stackView.addArrangedSubview(errorLabel)

        launchButton.setTitle("Launch Payment Flow", for: .normal)
        launchButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        launchButton.setTitleColor(.white, for: .normal)
        launchButton.backgroundColor = .systemBlue
        launchButton.layer.cornerRadius = 10
        launchButton.addTarget(self, action: #selector(launchButtonTapped), for: .touchUpInside)
        launchButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(launchButton)

        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        launchButton.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            launchButton.heightAnchor.constraint(equalToConstant: 56),

            activityIndicator.leadingAnchor.constraint(equalTo: launchButton.leadingAnchor, constant: 16),
            activityIndicator.centerYAnchor.constraint(equalTo: launchButton.centerYAnchor),
        ])
    }
}
