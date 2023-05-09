//
//  AppDelegate+Preflight.swift
//  LinkDemo-Swift
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

import LinkKit

extension AppDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // NOTE: Below there are Plaid setup examples for a preflight check, yet with recent changes to
        // Plaid's API and LinkKit this is no longer a necessity.
//        setupPlaidWithCustomConfiguration()
//        setupPlaidLinkWithSharedConfiguration()
        return true
    }

    // MARK: Plaid Link setup with shared configuration from Info.plist
    func setupPlaidLinkWithSharedConfiguration() {

        // <!-- SMARTDOWN_SETUP_SHARED -->
        // With shared configuration from Info.plist
        PLKPlaidLink.setup { (success, error) in
            if (success) {
                // Handle success here, e.g. by posting a notification
                NSLog("Plaid Link setup was successful")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PLDPlaidLinkSetupFinished"), object: self)
            }
            else if let error = error {
                NSLog("Unable to setup Plaid Link due to: \(error.localizedDescription)")
            }
            else {
                NSLog("Unable to setup Plaid Link")
            }
        }
        // <!-- SMARTDOWN_SETUP_SHARED -->

    }

    // MARK: Plaid Link setup with custom configuration
    func setupPlaidWithCustomConfiguration() {

        #warning("Replace <#YOUR_PLAID_PUBLIC_KEY#> below with your public_key")
        // <!-- SMARTDOWN_SETUP_CUSTOM -->
        // With custom configuration
        let linkConfiguration = PLKConfiguration(key: "<#YOUR_PLAID_PUBLIC_KEY#>", env: .development, product: .auth)
        linkConfiguration.clientName = "Link Demo"
        PLKPlaidLink.setup(with: linkConfiguration) { (success, error) in
            if (success) {
                // Handle success here, e.g. by posting a notification
                NSLog("Plaid Link setup was successful")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PLDPlaidLinkSetupFinished"), object: self)
            }
            else if let error = error {
                NSLog("Unable to setup Plaid Link due to: \(error.localizedDescription)")
            }
            else {
                NSLog("Unable to setup Plaid Link")
            }
        }
        // <!-- SMARTDOWN_SETUP_CUSTOM -->

    }

}
