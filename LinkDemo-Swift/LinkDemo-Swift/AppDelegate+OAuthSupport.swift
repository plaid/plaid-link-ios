//
//  AppDelegate+OAuthSupport.swift
//  LinkDemo-Swift
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

import UIKit
import LinkKit

extension AppDelegate {

#warning("Ensure your oauthRedirectUri is a valid universal link and is configured in the Plaid developer dashboard")
#warning("Ensure to also replace YOUR_OAUTH_REDIRECT_URI in the Associated Domains Capability or in the LinkDemo-Swift.entitlements")
#warning("Remember to change the application Bundle Identifier to match a URI you have configured for universal links")
#warning("For more information on configuring your oauthRedirectUri, see https://plaid.com/docs/link/oauth")

    // MARK: Continue Plaid Link for iOS to complete an OAuth authentication flow
    // <!-- SMARTDOWN_OAUTH_SUPPORT -->
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb, let webpageURL = userActivity.webpageURL else {
            return false
        }

        // The Plaid Link SDK ignores unexpected URLs passed to `continue(from:)` as
        // per Apple’s recommendations, so there is no need to filter out unrelated URLs.
        // Doing so may prevent a valid URL from being passed to `continue(from:)` and
        // OAuth may not continue as expected.
        // For details see https://plaid.com/docs/link/ios/#set-up-universal-links
        guard let linkOAuthHandler = window?.rootViewController as? LinkOAuthHandling,
            let handler = linkOAuthHandler.linkHandler
        else {
            return false
        }

        // Continue the Link flow
        handler.continue(from: webpageURL)
        return true
    }
    // <!-- SMARTDOWN_OAUTH_SUPPORT -->

}
