//
//  PlaidLinkViewExample.swift
//  LinkDemo-SwiftUI
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

import LinkKit
import SwiftUI

/// Simple and quick was to test out a see the Plaid Link flow. UX customization is not possible when using
/// `PlaidLinkView` for more customization and UX improvements see other examples.
struct PlaidLinkViewExample: View {

    init(linkToken: String) {
        self.linkToken = linkToken
    }

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("Plaid Link View Example")
            LinkKitVersionInfoView()

            Button("Connect Account") {
                isPresentingLink = true
            }
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $isPresentingLink) {
                PlaidLinkView(token: linkToken) { linkSuccess in
                    // Closure is called when a user successfully links an Item. It should take a single LinkSuccess argument,
                    // containing the publicToken String and a metadata of type SuccessMetadata.
                    // Ref - https://plaid.com/docs/link/ios/#onsuccess
                    print("public-token: \(linkSuccess.publicToken) metadata: \(linkSuccess.metadata)")
                    isPresentingLink = false
                } onExit: { linkExit in
                    // Optional closure is called when a user exits Link without successfully linking an Item,
                    // or when an error occurs during Link initialization. It should take a single LinkExit argument,
                    // containing an optional error and a metadata of type ExitMetadata.
                    // Ref - https://plaid.com/docs/link/ios/#onexit
                    if let error = linkExit.error {
                        print("exit with \(error)\n\(linkExit.metadata)")
                    } else {
                        // User exited the flow without an error.
                        print("exit with \(linkExit.metadata)")
                    }
                    isPresentingLink = false
                } onEvent: { linkEvent in
                    // Optional closure is called when certain events in the Plaid Link flow have occurred, for example,
                    // when the user selected an institution. This enables your application to gain further insight into
                    // what is going on as the user goes through the Plaid Link flow.
                    // Ref - https://plaid.com/docs/link/ios/#onevent
                    print("Link Event: \(linkEvent)")
                } errorView: { error in
                    // View to display in the event there is an error loading Link. This will only occur if there
                    // is a problem with your token.
                    Text("Failed to load Plaid")
                    Text("Error: \(error.localizedDescription)")
                    Button("Dismiss") { isPresentingLink = false }
                }
            }
        }
    }

    @State private var isPresentingLink = false
    private let linkToken: String
}
