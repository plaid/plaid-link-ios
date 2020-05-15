//
//  AppDelegate+OAuthSupport.swift
//  LinkDemo-Swift
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

import UIKit

extension AppDelegate {

    // MARK: Re-initialize Plaid Link for iOS to complete OAuth authentication flow
    // <!-- SMARTDOWN_OAUTH_SUPPORT -->
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb, let webpageURL = userActivity.webpageURL else {
            return false
        }

        #warning("Replace the example oauthRedirectUri below with your oauthRedirectUri, which should be configured as a universal link and must be whitelisted through Plaid's developer dashboard")
        let oauthRedirectUri = URL(string: "https://example.net/plaid-oauth")!
        if webpageURL.host == oauthRedirectUri.host && webpageURL.path == oauthRedirectUri.path {
            // Pass the webpageURL to your code responsible for re-initalizing Plaid Link for iOS
        }

        return true
    }
    // <!-- SMARTDOWN_OAUTH_SUPPORT -->

}
