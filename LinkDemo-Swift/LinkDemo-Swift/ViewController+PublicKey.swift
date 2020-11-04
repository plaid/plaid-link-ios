//
//  ViewController+PublicKey.swift
//  LinkDemo-Swift
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

import LinkKit

extension ViewController {

    // MARK: Start Plaid Link using a public key for compatibility with previous version of LinkKit
    // For details please see https://plaid.com/docs/
    func presentPlaidLinkUsingPublicKey() {

        #warning("Replace <#PUBLIC_KEY#> below with your public_key")

        // <!-- SMARTDOWN_PRESENT_PUBLICKEY -->
        // With custom configuration using a link_token
        var linkConfiguration = LinkPublicKeyConfiguration(
            clientName: "<#APPLICATION_NAME#>",
            environment: .sandbox,
            products: [.transactions],
            language: "en",
            // For public key Link flows use:
            token: .publicKey("<#PUBLIC_KEY#>"),
            // For payment initiation Link flows replace the line above with the following line:
            //token: .payment("<#PAYMENT_TOKEN#>", "<#PUBLIC_KEY#>")
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
            linkHandler = handler
            handler.open(presentUsing: .viewController(self))
        }

        // <!-- SMARTDOWN_PRESENT_PUBLICKEY -->
    }

}
