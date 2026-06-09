//
//  ExampleListView.swift
//  LinkDemo-SwiftUI
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

import LinkKit
import SwiftUI

struct ExampleListView: View {

    init(linkToken: String) {
        self.linkToken = linkToken
    }

    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section {
                    ForEach(ExampleView.allCases) { screen in
                        NavigationLink(value: screen) {
                            VStack(alignment: .leading) {
                                Text(screen.title)
                                    .font(.headline)
                                Text(screen.description)
                                    .font(.subheadline)
                            }
                        }
                    }
                } footer: {
                    LinkKitVersionInfoView()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 8)
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .navigationTitle("LinkKit Examples")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, 16)
            .navigationDestination(for: ExampleView.self) { screen in
                switch screen {
                case .plaidLink:
                    PlaidLinkViewExample(linkToken: linkToken)
                case .plaidLinkSession:
                    PlaidLinkSessionExampleView(linkToken: linkToken)
                case .plaidLinkUIViewControllerRepresentable:
                    PlaidLinkUIViewControllerRepresentableExampleView(linkToken: linkToken)
                case .plaidLinkHeadlessSession:
                    PlaidLinkHeadlessSessionExampleView(linkToken: linkToken)
                case .plaidLayerSession:
                    PlaidLayerSessionExampleView(linkToken: linkToken)
                case .plaidEmbeddedSearch:
                    PlaidEmbeddedLinkView(linkToken: linkToken)
                case .syncFinanceKit:
                    SyncFinanceKitExampleView(linkToken: linkToken)
                }
            }
        }
    }

    private let linkToken: String
    @State private var path = NavigationPath()
}

#Preview {
    ExampleListView(linkToken: "")
}
