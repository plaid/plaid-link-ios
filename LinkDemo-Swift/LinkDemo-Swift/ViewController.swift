//
//  ViewController.swift
//  LinkDemo-Swift
//
//  Copyright © 2019 Plaid Inc. All rights reserved.
//

import UIKit

// <!-- SMARTDOWN_IMPORT_LINKKIT -->
import LinkKit
// <!-- SMARTDOWN_IMPORT_LINKKIT -->

protocol LinkOAuthHandling {
    var linkHandler: Handler? { get }
    var oauthRedirectUri: URL? { get }
}

class ViewController: UIViewController, LinkOAuthHandling {

    @IBOutlet var button: UIButton!
    @IBOutlet var label: UILabel!
    @IBOutlet var buttonContainerView: UIView!
    var linkHandler: Handler?

    // When re-initializing Link to complete the OAuth flows ensure that the same oauthNonce is used per session.
    // This is a simplified example for demonstaration purposes only.
    let oauthNonce: String = { return UUID().uuidString }()

    #warning("Replace <#YOUR_OAUTH_REDIRECT_URI#> below with your oauthRedirectUri, which should be a universal link and must be configured in the Plaid developer dashboard")
    #warning("Ensure to also replace YOUR_OAUTH_REDIRECT_URI in the Associated Domains Capability or in the LinkDemo-Swift.entitlements")
    #warning("Remember to change the application Bundle Identifier to match one you have configured for universal links")
    var oauthRedirectUri: URL? = { URL(string: "<#YOUR_OAUTH_REDIRECT_URI#>") }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let linkKitBundle  = Bundle(for: PLKPlaid.self)
        let linkKitVersion = linkKitBundle.object(forInfoDictionaryKey: "CFBundleShortVersionString")!
        let linkKitBuild   = linkKitBundle.object(forInfoDictionaryKey: kCFBundleVersionKey as String)!
        let linkKitName    = linkKitBundle.object(forInfoDictionaryKey: kCFBundleNameKey as String)!
        label.text         = "Swift 5 — \(linkKitName) \(linkKitVersion)+\(linkKitBuild)"

        let shadowColor    = #colorLiteral(red: 0.01176470588, green: 0.1921568627, blue: 0.337254902, alpha: 0.1)
        buttonContainerView.layer.shadowColor   = shadowColor.cgColor
        buttonContainerView.layer.shadowOffset  = CGSize(width: 0, height: -1)
        buttonContainerView.layer.shadowRadius  = 2
        buttonContainerView.layer.shadowOpacity = 1
    }

    @IBAction func didTapButton(_ sender: Any?) {
        enum PlaidLinkUILayer {
            case UIKit
            case swiftUI
        }
        enum PlaidLinkSampleFlow {
            case linkToken
            case linkPublicKey // for compatability with LinkKit v1
        }
        #warning("Select your desired Plaid Link sample flow and UI layer")
        let tuple: (PlaidLinkSampleFlow, PlaidLinkUILayer) = (flow: .linkToken, ui: .UIKit)
        switch tuple {
            case (.linkToken, .UIKit):
                presentPlaidLinkUsingLinkToken()
            case (.linkToken, .swiftUI):
                presentSwiftUILinkToken()
            case (.linkPublicKey, .UIKit):
                presentPlaidLinkUsingPublicKey()
            case (.linkPublicKey, .swiftUI):
                presentSwiftUIPublicKey()
        }
    }
}
