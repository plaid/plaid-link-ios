//
//  ViewController+ItemAddToken.swift
//  LinkDemo-Swift
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

import LinkKit

extension ViewController {

    // MARK: Start Plaid Link with custom configuration using an item-add token
    // For details please see https://plaid.com/docs/link-token-migration-guide/
    func presentPlaidLinkUsingItemAddToken() {

        #warning("Replace <#GENERATED_ITEM_ADD_TOKEN#> below with your update mode public_token")
        // <!-- SMARTDOWN_PRESENT_ITEMADD -->
        // With custom configuration using an item-add token
        let linkConfiguration = PLKConfiguration(key: kPLKUseItemAddTokenInsteadOfPublicKey, env: .sandbox, product: .auth)
        linkConfiguration.clientName = "Link Demo"

        // In your production application replace the hardcoded itemAddToken below with code that fetches an item-add token
        // from your backend server which in turn retrieves it securely from Plaid, for details please refer to
        // https://plaid.com/docs/link-token-migration-guide/
        let itemAddToken = "<#GENERATED_ITEM_ADD_TOKEN#>"
        let linkViewDelegate = self
        let linkViewController = PLKPlaidLinkViewController(itemAddToken: itemAddToken, configuration: linkConfiguration, delegate: linkViewDelegate)
        if (UI_USER_INTERFACE_IDIOM() == .pad) {
            linkViewController.modalPresentationStyle = .formSheet
        }
        present(linkViewController, animated: true)
        // <!-- SMARTDOWN_PRESENT_ITEMADD -->

    }

}
