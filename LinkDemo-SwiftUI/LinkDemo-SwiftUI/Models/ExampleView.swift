//
//  ExampleView.swift
//  LinkDemo-SwiftUI
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

import Foundation

/// Possible examples that can be opened.
enum ExampleView: String, CaseIterable, Identifiable {

    case plaidLinkSession
    case plaidLinkHeadlessSession
    case plaidLayerSession
    case plaidEmbeddedSearch
    case syncFinanceKit

    var id: String { self.rawValue }

    var title: String {
        switch self {
        case .plaidLinkSession: "PlaidLinkSession"
        case .plaidLinkHeadlessSession: "PlaidLinkHeadlessSession"
        case .plaidLayerSession: "PlaidLayerSession"
        case .plaidEmbeddedSearch: "PlaidEmbeddedSearch"
        case .syncFinanceKit: "Sync FinanceKit"
        }
    }

    var description: String {
        switch self {
        case .plaidLinkSession:
            return """
                Shows how create a PlaidLinkSession and use the sheet() feature.
                """
        case .plaidLinkHeadlessSession:
            return """
                Shows how to create a PlaidHeadlessSession and start a payment flow.
                """
        case .plaidLayerSession:
            return """
                Shows how to create a PlaidLayerSession and start a Layer flow using the sheet() feature.
                """
        case .plaidEmbeddedSearch:
            return """
                Shows how to create a EmbeddedSearchView and start a Link flow from it.
                """
        case .syncFinanceKit:
            return """
                Shows how to sync the latest transactions from Apple Card using FinanceKit.
                """
        }
    }
}
