//
//  PlaidEmbeddedLinkView.swift
//  LinkDemo-SwiftUI
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

import LinkKit
import SwiftUI

struct PlaidEmbeddedLinkView: View {

    init(linkToken: String) {
        self.linkToken = linkToken
    }

    var body: some View {
        VStack(spacing: 16) {
            Text("Plaid Embedded Link View Example")
            LinkKitVersionInfoView()

            // Error Display (if applicable)
            if case .error(let message) = state {
                PlaidErrorView(message: message)
            }

            if let embeddedSearchView {
                embeddedSearchView
                    // Optionally set a frame size for the view
                    .frame(width: embeddedSearchView.expectedWidth, height: embeddedSearchView.expectedHeight)
                    .padding()
            }
        }
        .onAppear(perform: createEmbeddedView)
    }

    private let linkToken: String
    @State private var state: LoadingState = .loading
    @State private var embeddedSearchView: EmbeddedSearchView?
    @State private var isPresentingLink: Bool = false

    private func createEmbeddedView() {
        let configuration = EmbeddedLinkTokenConfiguration(
            token: linkToken,
            onSuccess: { linkSuccess in
                // Closure is called when a user successfully links an Item. It should take a single LinkSuccess argument,
                // containing the publicToken String and a metadata of type SuccessMetadata.
                // Ref - https://plaid.com/docs/link/ios/#onsuccess
                print("public-token: \(linkSuccess.publicToken) metadata: \(linkSuccess.metadata)")
                isPresentingLink = false
            },
            onExit: { linkExit in
                // Optional closure is called when a user exits Link without successfully linking an Item,
                // or when an error occurs during Link initialization. It should take a single LinkExit argument,
                // containing an optional error and a metadata of type ExitMetadata.
                // Ref - https://plaid.com/docs/link/ios/#onexit
                isPresentingLink = false

                if let error = linkExit.error {
                    print("exit with \(error)\n\(linkExit.metadata)")
                    self.state = .error(error.displayMessage ?? "Exited with error")
                } else {
                    // User exited the flow without an error.
                    print("exit with \(linkExit.metadata)")
                }
            },
            onEvent: { linkEvent in
                // Optional closure is called when certain events in the Plaid Link flow have occurred, for example,
                // when the user selected an institution. This enables your application to gain further insight into
                // what is going on as the user goes through the Plaid Link flow.
                // Ref - https://plaid.com/docs/link/ios/#onevent
                print("Link Event: \(linkEvent)")
            }
        )

        do {
            let view = try Plaid.createEmbeddedLinkView(configuration: configuration)
            self.embeddedSearchView = view
        } catch {
            self.state = .error(error.localizedDescription)
        }
    }
}
