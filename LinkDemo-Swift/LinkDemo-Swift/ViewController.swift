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

class ViewController: UIViewController {

    @IBOutlet var button: UIButton!
    @IBOutlet var label: UILabel!
    @IBOutlet var buttonContainerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.didReceiveNotification(_:)), name: NSNotification.Name(rawValue: "PLDPlaidLinkSetupFinished"), object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        button.isEnabled = false
        let linkKitBundle  = Bundle(for: PLKPlaidLinkViewController.self)
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

    @objc func didReceiveNotification(_ notification: NSNotification) {
        if notification.name.rawValue == "PLDPlaidLinkSetupFinished" {
            NotificationCenter.default.removeObserver(self, name: notification.name, object: nil)
            button.isEnabled = true
        }
    }

    @IBAction func didTapButton(_ sender: Any?) {
        enum PlaidLinkSampleFlow {
            case customConfiguration;
            case sharedConfiguration;
            case updateMode;
            case oauthSupport;
            case paymentInitiation;
        }
        #warning("Select your desired Plaid Link sample flow")
        let sampleFlow : PlaidLinkSampleFlow = .customConfiguration
        switch sampleFlow {
        case .sharedConfiguration:
            presentPlaidLinkWithSharedConfiguration()
        case .updateMode:
            presentPlaidLinkInUpdateMode()
        case .oauthSupport:
            presentPlaidLinkWithOAuthSupport()
        case .paymentInitiation:
            presentPlaidLinkWithPaymentInitation()
        case .customConfiguration:
            fallthrough
        default:
            presentPlaidLinkWithCustomConfiguration()
        }
    }

}
