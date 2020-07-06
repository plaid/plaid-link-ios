//
//  ViewController+PaymentInitiation.swift
//  LinkDemo-Swift
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

import LinkKit

extension ViewController {

    // MARK: Start Plaid Link in payment initation mode
    // For details about Payment Initation support please see https://plaid.com/docs/#payment-initiation and
    // https://plaid.com/docs/link/ios/#oauth-support and https://plaid.com/docs/#oauth
    func presentPlaidLinkWithPaymentInitation(oauthStateId: String?) {

        #warning("Replace <#YOUR_PLAID_PUBLIC_KEY#>, <#COUNTRY_CODE#>, and <#GENERATED_PAYMENT_TOKEN#> below with your public_key, supported country codes and the generated payment_token")
        // <!-- SMARTDOWN_PAYMENT_MODE -->
        // With custom configuration for payment initation

        // Plaid Link Payment Initiation leverages OAuth, which works in two steps, the first step is to initiate the OAuth authentication flow,
        // the second to complete the OAuth authentication flow. On each step Plaid Link must be initialized
        // as follows:

        // When re-initializing Link to complete the authentication flow ensure that the PLKPlaidLinkViewController,
        // that initiated the flow is dismissed.
        if presentedViewController is PLKPlaidLinkViewController {
            dismiss(animated: true, completion: nil)
        }

        let linkConfiguration = PLKConfiguration(key: "<#YOUR_PLAID_PUBLIC_KEY#>", env: .sandbox, product: .paymentInitiation)
        linkConfiguration.clientName = "Link Demo"
        linkConfiguration.countryCodes = ["<#COUNTRY_CODE#>"]
        // When re-initializing Link to complete the authentication flow ensure that the same oauthNonce is used.
        linkConfiguration.oauthNonce = oauthNonce
        linkConfiguration.oauthRedirectUri = oauthRedirectUri
        let linkViewDelegate = self

        let paymentToken = "<#GENERATED_PAYMENT_TOKEN#>"
        let linkViewController = PLKPlaidLinkViewController(paymentToken: paymentToken, oauthStateId: oauthStateId, configuration: linkConfiguration, delegate: linkViewDelegate)
        if (UI_USER_INTERFACE_IDIOM() == .pad) {
            linkViewController.modalPresentationStyle = .formSheet
        }
        present(linkViewController, animated: true)
        // <!-- SMARTDOWN_PAYMENT_MODE -->

    }

}
