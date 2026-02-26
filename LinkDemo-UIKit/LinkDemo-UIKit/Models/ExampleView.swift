//
//  ExampleView.swift
//  LinkDemo-UIKit
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

import Foundation

enum ExampleViewType: CaseIterable {
    case plaidLinkSession
    case plaidLinkHeadlessSession
    case plaidLayerSession
    case plaidEmbeddedLink
    case syncFinanceKit

    var title: String {
        switch self {
        case .plaidLinkSession:
            return "PlaidLinkSession"
        case .plaidLinkHeadlessSession:
            return "PlaidLinkHeadlessSession"
        case .plaidLayerSession:
            return "PlaidLayerSession"
        case .plaidEmbeddedLink:
            return "PlaidEmbeddedLink"
        case .syncFinanceKit:
            return "Sync FinanceKit"
        }
    }

    var description: String {
        switch self {
        case .plaidLinkSession:
            return "Shows how create a PlaidLinkSession and present it using a ViewController."
        case .plaidLinkHeadlessSession:
            return "Shows how to create a PlaidHeadlessSession and start a payment flow."
        case .plaidLayerSession:
            return "Shows how to create a PlaidLayerSession and start a Layer flow."
        case .plaidEmbeddedLink:
            return "Shows how to create an embedded Link view."
        case .syncFinanceKit:
            return "Shows how to sync the latest transactions from Apple Card using FinanceKit."
        }
    }
}
