//
//  ExampleListViewController.swift
//  LinkDemo-UIKit
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

import UIKit

class ExampleListViewController: UITableViewController {

    private let linkToken: String
    private let examples = ExampleViewType.allCases

    init(linkToken: String) {
        self.linkToken = linkToken
        super.init(style: .plain)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "LinkKit Examples"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ExampleCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examples.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleCell", for: indexPath)
        let example = examples[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = example.title
        content.secondaryText = example.description
        content.textProperties.font = .boldSystemFont(ofSize: 17)
        content.secondaryTextProperties.font = .systemFont(ofSize: 14)
        content.secondaryTextProperties.numberOfLines = 0

        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let example = examples[indexPath.row]
        let viewController = viewController(for: example)

        navigationController?.pushViewController(viewController, animated: true)
    }

    private func viewController(for type: ExampleViewType) -> UIViewController {
        switch type {
        case .plaidLinkSession:
            return PlaidLinkSessionViewController(linkToken: linkToken)
        case .plaidLinkHeadlessSession:
            return PlaidLinkHeadlessSessionViewController(linkToken: linkToken)
        case .plaidLayerSession:
            return PlaidLayerSessionViewController(linkToken: linkToken)
        case .plaidEmbeddedLink:
            return PlaidEmbeddedLinkViewController(linkToken: linkToken)
        case .syncFinanceKit:
            return SyncFinanceKitViewController(linkToken: linkToken)
        }
    }
}
