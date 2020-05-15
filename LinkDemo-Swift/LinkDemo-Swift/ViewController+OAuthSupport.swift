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
    func presentPlaidLinkWithOAuthSupport() {

        #warning("Replace <#YOUR_PLAID_PUBLIC_KEY#> and <#COUNTRY_CODE#> below with your public_key and supported country codes")
        // <!-- SMARTDOWN_PRESENT_OAUTH -->
        // With custom configuration using OAuth

        // Plaid Link OAuth works in two steps, the first step is to initiate the OAuth authentication flow,
        // the second to complete the OAuth authentication flow. On each step Plaid Link must be initialized
        // as follows:

        // When re-initializing Link to complete the authentication flow ensure that the same oauthNonce is used.
        let oauthNonce = UUID().uuidString

        #warning("Replace the example oauthRedirectUri below with your oauthRedirectUri, which should be configured as a universal link and must be whitelisted through Plaid's developer dashboard")
        let oauthRedirectUri = URL(string: "https://example.net/plaid-oauth")

        // Replace the example userActivityWebpageURL below with code that takes the userActivity.webpageURL from
        // UIApplicationDelegate.application:continueUserActivity:restorationHandler:
        guard let userActivityWebpageURL = URL(string: "https://example.net/plaid-oauth?oauth_state_id=f81d4fae-7dec-11d0-a765-00a0c91e6bf6"),
            let oauthStateId = PLKOAuthStateIdFromURL(userActivityWebpageURL) else {
                return
        }

        let linkConfiguration = PLKConfiguration(key: "<#YOUR_PLAID_PUBLIC_KEY#>", env: .sandbox, product: .auth)
        linkConfiguration.clientName = "Link Demo"
        linkConfiguration.countryCodes = ["<#COUNTRY_CODE#>"]
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
