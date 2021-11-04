//
//  ViewController+PublicKey.swift
//  LinkDemo-Swift
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

import LinkKit

extension ViewController {
    
    func createPublicKeyConfiguration() -> LinkPublicKeyConfiguration {
        #warning("Replace <#PUBLIC_KEY#> below with your public_key")
        // With custom configuration using a public_key
        var linkConfiguration = LinkPublicKeyConfiguration(
            clientName: "<#APPLICATION_NAME#>",
            environment: /*@START_MENU_TOKEN@*/.sandbox/*[[".sandbox",".development",".production"],[[[-1,0],[-1,1],[-1,2]]],[0]]@END_MENU_TOKEN@*/,
            products: [/*@START_MENU_TOKEN@*/.transactions/*[[".transactions",".auth",".identity",".income",".paymentInitation",".assets",".investments",".liabilities",".liabilitesReport"],[[[-1,0],[-1,1],[-1,2],[-1,3],[-1,4],[-1,5],[-1,6],[-1,7],[-1,8]]],[0]]@END_MENU_TOKEN@*/],
            language:  /*@START_MENU_TOKEN@*/"en"/*[["\"en\"","\"es\"","\"fr\"","\"nl\""],[[[-1,0],[-1,1],[-1,2],[-1,3]]],[0]]@END_MENU_TOKEN@*/,
            // For public key Link flows use:
            token: .publicKey("<#PUBLIC_KEY#>"),
            // For payment initiation Link flows replace the line above with the following line:
            //token: .payment("<#PAYMENT_TOKEN#>", "<#PUBLIC_KEY#>")
            countryCodes: [/*@START_MENU_TOKEN@*/"US"/*[["\"US\"","\"CA\"","\"GB\"","\"NL\""],[[[-1,0],[-1,1],[-1,2],[-1,3]]],[0]]@END_MENU_TOKEN@*/]
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

        if let oauthRedirectURI = self.oauthRedirectURI {
            linkConfiguration.oauthConfiguration = OAuthNonceConfiguration(
                nonce: self.oauthNonce,
                redirectUri: oauthRedirectURI
            )
        }


        return linkConfiguration
    }

    // MARK: Start Plaid Link using a public key for compatibility with previous version of LinkKit
    // For details please see https://plaid.com/docs/
    func presentPlaidLinkUsingPublicKey() {
        let linkConfiguration = createPublicKeyConfiguration()
        let result = Plaid.create(linkConfiguration)
        switch result {
        case .failure(let error):
            print("Unable to create Plaid handler due to: \(error)")
        case .success(let handler):
            linkHandler = handler
            handler.open(presentUsing: .viewController(self))
        }
    }
}
