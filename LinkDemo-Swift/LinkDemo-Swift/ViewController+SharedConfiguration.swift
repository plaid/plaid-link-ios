//
//  ViewController+SharedConfiguration.swift
//  LinkDemo-Swift
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

import LinkKit

extension ViewController {

    // MARK: Plaid Link setup with shared configuration from Info.plist
    func presentPlaidLinkWithSharedConfiguration() {

        #warning("Replace <#YOUR_PLAID_PUBLIC_KEY#> for the LINK_KEY with your public_key in the Build Settings or or set key directly in this application's Info.plist")
        // <!-- SMARTDOWN_PRESENT_SHARED -->
        // With shared configuration from Info.plist
        let linkViewDelegate = self
        let linkViewController = PLKPlaidLinkViewController(delegate: linkViewDelegate)
        if (UI_USER_INTERFACE_IDIOM() == .pad) {
            linkViewController.modalPresentationStyle = .formSheet
        }
        present(linkViewController, animated: true)
        // <!-- SMARTDOWN_PRESENT_SHARED -->

    }

}
