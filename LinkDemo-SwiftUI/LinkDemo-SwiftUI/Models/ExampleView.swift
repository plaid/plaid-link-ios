//
//  ExampleView.swift
//  LinkDemo-SwiftUI
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

import Foundation

/// Possible examples that can be opened.
enum ExampleView: String, CaseIterable, Identifiable {

    case plaidLink
    case plaidLinkSession
    case plaidLinkUIViewControllerRepresentable
    case plaidLinkHeadlessSession
    case plaidLayerSession
    case plaidEmbeddedSearch
    case syncFinanceKit

    var id: String { self.rawValue }

    var title: String {
        switch self {
        case .plaidLink: "PlaidLinkView"
        case .plaidLinkSession: "PlaidLinkSession"
        case .plaidLinkUIViewControllerRepresentable: "PlaidLinkUIViewControllerRepresentable"
        case .plaidLinkHeadlessSession: "PlaidLinkHeadlessSession"
        case .plaidLayerSession: "PlaidLayerSession"
        case .plaidEmbeddedSearch: "PlaidEmbeddedSearch"
        case .syncFinanceKit: "Sync FinanceKit"
        }
    }

    var description: String {
        switch self {
        case .plaidLink:
            return """
                Shows how to use the PlaidLinkView view. This is the most simple integration method, but it does not provide the best UX.
                """
        case .plaidLinkSession:
            return """
                Shows how create a PlaidLinkSession and use the sheet() feature.
                """
        case .plaidLinkUIViewControllerRepresentable:
            return """
                Shows how to create a PlaidLinkUIViewControllerRepresentable with a PlaidLinkSession.
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
