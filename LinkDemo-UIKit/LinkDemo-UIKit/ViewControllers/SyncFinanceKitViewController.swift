//
//  SyncFinanceKitViewController.swift
//  LinkDemo-UIKit
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

import LinkKit
import UIKit

class SyncFinanceKitViewController: UIViewController {

    init(linkToken: String) {
        self.linkToken = linkToken
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sync FinanceKit"
        view.backgroundColor = .systemBackground

        setupUI()
    }

    // MARK: - Sync FinanceKit

    @objc private func syncButtonTapped() {
        if #available(iOS 17.4, *) {
            syncFinanceKit()
        } else {
            showStatus("❌ FinanceKit requires iOS 17.4 or later", isError: true)
        }
    }

    @available(iOS 17.4, *)
    private func syncFinanceKit() {
        isSyncing = true
        statusMessage = nil
        statusLabel.isHidden = true

        PlaidFinanceKit.sync(
            token: linkToken,
            requestAuthorizationIfNeeded: true,
            syncBehavior: .live,
            completion: { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self?.showStatus("✅ Sync completed successfully", isError: false)
                        self?.isSyncing = false

                    case .failure(let error):
                        self?.showStatus("❌ Sync failed: \(error.localizedDescription)", isError: true)
                        self?.isSyncing = false
                    }
                }
            }
        )
    }

    // MARK: - UI

    private let linkToken: String
    private var isSyncing: Bool = false {
        didSet {
            updateUI()
        }
    }
    private var statusMessage: String?
    private var statusIsError: Bool = false

    private let scrollView = UIScrollView()
    private let titleLabel = UILabel()
    private let versionLabel = UILabel()
    private let warningLabel = UILabel()
    private let requirementsLabel = UILabel()
    private let statusLabel = UILabel()
    private let syncButton = UIButton(type: .system)
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    private func showStatus(_ message: String, isError: Bool) {
        statusMessage = message
        statusIsError = isError
        statusLabel.text = message
        statusLabel.textColor = isError ? .systemRed : .systemGreen
        statusLabel.isHidden = false
    }

    private func updateUI() {
        if isSyncing {
            activityIndicator.startAnimating()
            syncButton.isEnabled = false
            syncButton.backgroundColor = .systemGray
        } else {
            activityIndicator.stopAnimating()
            syncButton.isEnabled = true
            syncButton.backgroundColor = .systemBlue
        }
    }

    private func setupUI() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)

        titleLabel.text = "Sync FinanceKit Example"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        stackView.addArrangedSubview(titleLabel)

        versionLabel.text = "LinkKit"
        versionLabel.font = .systemFont(ofSize: 14)
        versionLabel.textColor = .secondaryLabel
        versionLabel.textAlignment = .center
        stackView.addArrangedSubview(versionLabel)

        warningLabel.text = "⚠️ IMPORTANT"
        warningLabel.font = .boldSystemFont(ofSize: 16)
        warningLabel.textColor = .systemOrange
        warningLabel.textAlignment = .center
        stackView.addArrangedSubview(warningLabel)

        requirementsLabel.text = """
            Requirements:

            1. You MUST have a FinanceKit entitlement from Apple (or the app will crash)

            2. The link token must be associated with an access token from a previous session where the user linked their Apple Card

            3. iOS 17.4 or later is required
            """
        requirementsLabel.font = .systemFont(ofSize: 14)
        requirementsLabel.textColor = .label
        requirementsLabel.numberOfLines = 0
        requirementsLabel.textAlignment = .left

        let requirementsContainer = UIView()
        requirementsContainer.backgroundColor = UIColor.secondarySystemBackground
        requirementsContainer.layer.cornerRadius = 10
        requirementsContainer.translatesAutoresizingMaskIntoConstraints = false
        requirementsContainer.addSubview(requirementsLabel)
        requirementsLabel.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(requirementsContainer)

        statusLabel.font = .systemFont(ofSize: 14)
        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0
        statusLabel.isHidden = true
        stackView.addArrangedSubview(statusLabel)

        syncButton.setTitle("Sync FinanceKit", for: .normal)
        syncButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        syncButton.setTitleColor(.white, for: .normal)
        syncButton.backgroundColor = .systemBlue
        syncButton.layer.cornerRadius = 10
        syncButton.addTarget(self, action: #selector(syncButtonTapped), for: .touchUpInside)
        syncButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(syncButton)

        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        syncButton.addSubview(activityIndicator)

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

            requirementsLabel.topAnchor.constraint(equalTo: requirementsContainer.topAnchor, constant: 12),
            requirementsLabel.leadingAnchor.constraint(equalTo: requirementsContainer.leadingAnchor, constant: 12),
            requirementsLabel.trailingAnchor.constraint(equalTo: requirementsContainer.trailingAnchor, constant: -12),
            requirementsLabel.bottomAnchor.constraint(equalTo: requirementsContainer.bottomAnchor, constant: -12),

            syncButton.heightAnchor.constraint(equalToConstant: 56),

            activityIndicator.leadingAnchor.constraint(equalTo: syncButton.leadingAnchor, constant: 16),
            activityIndicator.centerYAnchor.constraint(equalTo: syncButton.centerYAnchor),
        ])
    }
}
