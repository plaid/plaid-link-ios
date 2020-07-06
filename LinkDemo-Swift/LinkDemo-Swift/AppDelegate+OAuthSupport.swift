//
//  AppDelegate+OAuthSupport.swift
//  LinkDemo-Swift
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

import UIKit
import LinkKit

extension AppDelegate {

    // MARK: Re-initialize Plaid Link for iOS to complete OAuth authentication flow
    // <!-- SMARTDOWN_OAUTH_SUPPORT -->
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {

        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb, let webpageURL = userActivity.webpageURL else {
            return false
        }

        guard let viewController = window?.rootViewController as? ViewController else {
            return false
        }

        // Check that the userActivity.webpageURL is the oauthRedirectUri we have
        // configured in the Plaid dashboard.
        guard let oauthRedirectUri = viewController.oauthRedirectUri,
            webpageURL.host == oauthRedirectUri.host, webpageURL.path == oauthRedirectUri.path
            else {
            return false
        }

        // Extract oauthStateId from userActivity.webpageURL
        guard let oauthStateId = PLKOAuthStateIdFromURL(webpageURL) else {
            NSLog("Unable to extract oauthStateId from URL: \(webpageURL)")
            return false
        }

        // Re-initialize Link with the oauthStateId
        viewController.presentPlaidLinkWithOAuthSupport(oauthStateId: oauthStateId)
        // for the payment initiation flow use:
        //viewController.presentPlaidLinkWithPaymentInitation(oauthStateId: oauthStateId)

        return true
    }
    // <!-- SMARTDOWN_OAUTH_SUPPORT -->

}
