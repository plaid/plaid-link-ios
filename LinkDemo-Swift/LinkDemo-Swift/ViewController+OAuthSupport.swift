//
//  ViewController+OAuthSupport.swift
//  LinkDemo-Swift
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

import LinkKit

extension ViewController {

    // MARK: Using OAuth in Plaid Link
    // For details about OAuth support please see https://plaid.com/docs/link/ios/#oauth-support and https://plaid.com/docs/#oauth
    func presentPlaidLinkWithOAuthSupport(oauthStateId: String?) {

        // <!-- SMARTDOWN_PRESENT_OAUTH -->
        // With custom configuration using OAuth

        // Plaid Link OAuth works in two steps, the first step is to initiate the OAuth authentication flow,
        // the second to complete the OAuth authentication flow. On each step Plaid Link must be initialized
        // as follows:

        // When re-initializing Link to complete the authentication flow ensure that the same oauthNonce is used.
        let oauthNonce = UUID().uuidString
        
        
        if self.presentedViewController is PLKPlaidLinkViewController {
            self.dismiss(animated: true, completion: nil)
        }
        
        let linkConfiguration = PLKConfiguration(key: PlaidConfiguration.PublicKey, env: .sandbox, product: .auth)
        linkConfiguration.clientName = "Link Demo"
        linkConfiguration.countryCodes = PlaidConfiguration.CountryCodes
        linkConfiguration.oauthNonce = oauthNonce
        linkConfiguration.oauthRedirectUri = URL(string: PlaidConfiguration.OAuthRedirectUri)
        
        let linkViewDelegate = self
        let linkViewController = PLKPlaidLinkViewController(oAuthStateId: oauth, configuration: configuration, delegate: linkViewDelegate)
        if (UI_USER_INTERFACE_IDIOM() == .pad) {
            linkViewController.modalPresentationStyle = .formSheet
        }
        self.present(linkViewController, animated: true)
        // <!-- SMARTDOWN_PRESENT_OAUTH -->

    }

}
