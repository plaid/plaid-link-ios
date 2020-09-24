//
//  ViewController+PublicKey.swift
//  LinkDemo-Swift
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

import LinkKit

extension ViewController {

    // MARK: Start Plaid Link with custom configuration using a Link token
    // For details please see https://plaid.com/docs/#create-link-token
    func presentPlaidLinkUsingPublicKey() {

        #warning("Replace <#PUBLIC_KEY#> below with your public_key")

        // <!-- SMARTDOWN_PRESENT_LINKTOKEN -->
        // With custom configuration using a link_token
        var linkConfiguration = LinkPublicKeyConfiguration(
            clientName: "<#APPLICATION_NAME#>",
            environment: <#.sandbox#>,
            products: [<#.transactions#>],
            language: "en",
            token: .publicKey("<#PUBLIC_KEY#>"),
            countryCodes: ["US"]
        ) { success in
            print("public-token: \(success.publicToken) metadata: \(success.metadata)")
        }
        linkConfiguration.onExit = { exit in
            if let error = exit.error {
                print("exit with \(error)\n\(exit.metadata)")
            } else {
                print("exit with \(exit.metadata)")
            }
        }

        let result = Plaid.create(linkConfiguration)
        switch result {
        case .failure(let error):
            print("Unable to create Plaid handler due to: \(error)")
        case .success(let handler):
            handler.open(presentUsing: .viewController(self))
            linkHandler = handler
        }

        // <!-- SMARTDOWN_PRESENT_LINKTOKEN -->
    }

}
