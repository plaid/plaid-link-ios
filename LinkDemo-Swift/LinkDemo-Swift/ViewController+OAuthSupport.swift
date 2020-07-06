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

        #warning("Replace <#YOUR_PLAID_PUBLIC_KEY#>, and <#COUNTRY_CODE#> below with your public_key and supported country codes")
        // <!-- SMARTDOWN_PRESENT_OAUTH -->
        // With custom configuration using OAuth

        // Plaid Link OAuth works in two steps, the first step is to initiate the OAuth authentication flow,
        // the second to complete the OAuth authentication flow. On each step Plaid Link must be initialized
        // as follows:

        // When re-initializing Link to complete the authentication flow ensure that the PLKPlaidLinkViewController,
        // that initiated the flow is dismissed.
        if presentedViewController is PLKPlaidLinkViewController {
            dismiss(animated: true, completion: nil)
        }

        let linkConfiguration = PLKConfiguration(key: "<#YOUR_PLAID_PUBLIC_KEY#>", env: .sandbox, product: .auth)
        linkConfiguration.clientName = "Link Demo"
        linkConfiguration.countryCodes = ["<#COUNTRY_CODE#>"]
        // When re-initializing Link to complete the authentication flow ensure that the same oauthNonce is used.
        linkConfiguration.oauthNonce = oauthNonce
        linkConfiguration.oauthRedirectUri = oauthRedirectUri
        let linkViewDelegate = self

        let linkViewController = PLKPlaidLinkViewController(oAuthStateId: oauthStateId, configuration: linkConfiguration, delegate: linkViewDelegate)
        if (UI_USER_INTERFACE_IDIOM() == .pad) {
            linkViewController.modalPresentationStyle = .formSheet
        }
        present(linkViewController, animated: true)
        // <!-- SMARTDOWN_PRESENT_OAUTH -->

    }

}
