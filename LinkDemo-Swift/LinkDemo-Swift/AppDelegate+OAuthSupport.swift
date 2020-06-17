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
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let webpageURL = userActivity.webpageURL else {
                return false
        }
        
       let oauthRedirectUri = URL(string: PlaidConfiguration.OAuthRedirectUri)!
       if let rootViewController = window?.rootViewController as? ViewController,
           webpageURL.host == oauthRedirectUri.host,
           webpageURL.path == oauthRedirectUri.path,
           let oauthStateId = PLKOAuthStateIdFromURL(webpageURL) {
           rootViewController.presentPlaidLinkWithOAuthSupport(oauthStateId: oauthStateId)
       }

        return true
    }
    // <!-- SMARTDOWN_OAUTH_SUPPORT -->

}
