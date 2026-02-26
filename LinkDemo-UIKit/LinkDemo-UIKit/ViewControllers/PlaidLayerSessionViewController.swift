//
//  PlaidLayerSessionViewController.swift
//  LinkDemo-UIKit
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

import LinkKit
import UIKit

struct LayerSubmissionData: SubmissionData {
    var phoneNumber: String?
    var dateOfBirth: String?
    var params: [String: String]?
}

class PlaidLayerSessionViewController: UIViewController {

    init(linkToken: String) {
        self.linkToken = linkToken
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "PlaidLayerSession"
        view.backgroundColor = .systemBackground

        setupUI()
        updateUI()
        createSession()
    }

    // MARK: - Link Setup

    private func createSession() {
        let configuration = LayerTokenConfiguration(
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
            onEvent: { [weak self] linkEvent in
                print("Link Event: \(linkEvent)")

                if linkEvent.eventName == .layerReady {
                    DispatchQueue.main.async {
                        self?.state = .ready
                    }
                } else if linkEvent.eventName == .layerNotAvailable {
                    DispatchQueue.main.async {
                        self?.state = .error("Layer not available")
                    }
                }
            }
        )

        do {
            let session = try Plaid.createPlaidLayerSession(configuration: configuration)
            self.layerSession = session
            updateUI()
        } catch {
            self.state = .error(error.localizedDescription)
        }
    }

    // MARK: - Submit User Data

    @objc private func submitButtonTapped() {
        guard let layerSession = layerSession else { return }

        let submissionData = LayerSubmissionData(
            phoneNumber: phoneTextField.text,
            dateOfBirth: dobTextField.text
        )
        layerSession.submit(data: submissionData)
    }

    // MARK: - Launch Layer

    @objc private func launchButtonTapped() {
        guard let layerSession = layerSession else { return }
        layerSession.open(using: .viewController(self))
    }

    // MARK: - UI

    private let linkToken: String
    private var layerSession: PlaidLayerSession?
    private var state: LoadingState = .loading {
        didSet {
            updateUI()
        }
    }

    private let titleLabel = UILabel()
    private let versionLabel = UILabel()
    private let errorLabel = UILabel()
    private let phoneTextField = UITextField()
    private let dobTextField = UITextField()
    private let submitButton = UIButton(type: .system)
    private let launchButton = UIButton(type: .system)
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    private func updateUI() {
        let hasSession = layerSession != nil

        switch state {
        case .loading:
            activityIndicator.startAnimating()
            launchButton.isEnabled = false
            launchButton.backgroundColor = .systemGray
            submitButton.isEnabled = hasSession
            submitButton.backgroundColor = hasSession ? .systemBlue : .systemGray
            errorLabel.isHidden = true
        case .ready:
            activityIndicator.stopAnimating()
            launchButton.isEnabled = true
            launchButton.backgroundColor = .systemBlue
            submitButton.isEnabled = hasSession
            submitButton.backgroundColor = hasSession ? .systemBlue : .systemGray
            errorLabel.isHidden = true
        case .error(let message):
            activityIndicator.stopAnimating()
            launchButton.isEnabled = false
            launchButton.backgroundColor = .systemGray
            submitButton.isEnabled = false
            submitButton.backgroundColor = .systemGray
            errorLabel.text = message
            errorLabel.isHidden = false
        }
    }

    private func setupUI() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)

        titleLabel.text = "Plaid Layer Session Example"
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

        let phoneLabel = UILabel()
        phoneLabel.text = "User Phone Number"
        phoneLabel.font = .systemFont(ofSize: 14)
        phoneLabel.textColor = .secondaryLabel
        stackView.addArrangedSubview(phoneLabel)

        phoneTextField.placeholder = "+1 415-555-0011"
        phoneTextField.text = "+1 415-555-0011"
        phoneTextField.keyboardType = .phonePad
        phoneTextField.borderStyle = .roundedRect
        stackView.addArrangedSubview(phoneTextField)

        let dobLabel = UILabel()
        dobLabel.text = "User Date of Birth"
        dobLabel.font = .systemFont(ofSize: 14)
        dobLabel.textColor = .secondaryLabel
        stackView.addArrangedSubview(dobLabel)

        dobTextField.placeholder = "YYYY-MM-DD"
        dobTextField.text = "1975-01-18"
        dobTextField.keyboardType = .numbersAndPunctuation
        dobTextField.borderStyle = .roundedRect
        stackView.addArrangedSubview(dobTextField)

        submitButton.setTitle("Submit User Data", for: .normal)
        submitButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = .systemBlue
        submitButton.layer.cornerRadius = 10
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(submitButton)

        launchButton.setTitle("Launch Layer", for: .normal)
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
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),

            submitButton.heightAnchor.constraint(equalToConstant: 56),
            launchButton.heightAnchor.constraint(equalToConstant: 56),

            activityIndicator.leadingAnchor.constraint(equalTo: launchButton.leadingAnchor, constant: 16),
            activityIndicator.centerYAnchor.constraint(equalTo: launchButton.centerYAnchor),
        ])
    }
}
