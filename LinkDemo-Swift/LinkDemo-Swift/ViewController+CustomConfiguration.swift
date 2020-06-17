//
//  ViewController+CustomConfiguration.swift
//  LinkDemo-Swift
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

import LinkKit

extension ViewController {

    // MARK: Plaid Link setup with custom configuration
    func presentPlaidLinkWithCustomConfiguration() {

        // <!-- SMARTDOWN_PRESENT_CUSTOM -->
        // With custom configuration
        let linkConfiguration = PLKConfiguration(key: PlaidConfiguration.PublicKey, env: .sandbox, product: .auth)
        linkConfiguration.clientName = "Link Demo"
        let linkViewDelegate = self
        let linkViewController = PLKPlaidLinkViewController(configuration: linkConfiguration, delegate: linkViewDelegate)
        if (UI_USER_INTERFACE_IDIOM() == .pad) {
            linkViewController.modalPresentationStyle = .formSheet
        }
        present(linkViewController, animated: true)
        // <!-- SMARTDOWN_PRESENT_CUSTOM -->

    }

}
