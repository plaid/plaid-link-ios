//
//  ViewController+UpdateMode.swift
//  LinkDemo-Swift
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

import LinkKit

extension ViewController {

    // MARK: Start Plaid Link in update mode
    // For details about update mode please see https://plaid.com/docs/link/ios/#update-mode
    func presentPlaidLinkInUpdateMode() {

        // <!-- SMARTDOWN_UPDATE_MODE -->
        // With public_token for update mode
        let linkConfiguration = PLKConfiguration(key: PlaidConfiguration.PublicKey, env: .sandbox, product: .auth)
        linkConfiguration.clientName = "Link Demo"
        let linkViewDelegate = self
        let linkViewController = PLKPlaidLinkViewController(publicToken: PlaidConfiguration.GeneratedPublicToken, configuration: linkConfiguration, delegate: linkViewDelegate)
        if (UI_USER_INTERFACE_IDIOM() == .pad) {
            linkViewController.modalPresentationStyle = .formSheet
        }
        present(linkViewController, animated: true)
        // <!-- SMARTDOWN_UPDATE_MODE -->

    }

}
