//
//  ViewController+OAuthSupport.swift
//  LinkDemo-Swift
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

import LinkKit

// TODO: better way to manage state?
var oauthNonce: String? = nil

extension ViewController {

    // MARK: Using OAuth in Plaid Link
    // For details about OAuth support please see https://plaid.com/docs/link/ios/#oauth-support and https://plaid.com/docs/#oauth
    func presentPlaidLinkWithOAuthSupport(oauthStateId: String?) {

        // <!-- SMARTDOWN_PRESENT_OAUTH -->
        // With custom configuration using OAuth

        // Plaid Link OAuth works in two steps, the first step is to initiate the OAuth authentication flow,
        // the second to complete the OAuth authentication flow.
        //
        // On the second step, we will expect for oauthStateId to be non-null. We must
        // ensure the same oauthNonce is used.
        
        if oauthStateId == nil {
            // We are starting a new oauth session, generate a new nonce.
            oauthNonce = UUID().uuidString
        } else {
            
            assert(oauthNonce != nil, "unexpected condition - expected non-nil oauthNonce")
        }
        
        // If Link is already presented, dismiss it before we attempt to reinitialize.
        if self.presentedViewController is PLKPlaidLinkViewController {
            self.dismiss(animated: true, completion: nil)
        }
        
        let linkConfiguration = PLKConfiguration(key: PlaidConfiguration.PublicKey, env: .sandbox, product: .auth)
        linkConfiguration.clientName = "Link Demo"
        linkConfiguration.countryCodes = PlaidConfiguration.CountryCodes
        linkConfiguration.oauthNonce = oauthNonce
        linkConfiguration.oauthRedirectUri = URL(string: PlaidConfiguration.OAuthRedirectUri)
        
        let linkViewDelegate = self
        let linkViewController = PLKPlaidLinkViewController(oAuthStateId: oauthStateId, configuration: linkConfiguration, delegate: linkViewDelegate)
        if (UI_USER_INTERFACE_IDIOM() == .pad) {
            linkViewController.modalPresentationStyle = .formSheet
        }
        self.present(linkViewController, animated: true)
        // <!-- SMARTDOWN_PRESENT_OAUTH -->

    }

}
