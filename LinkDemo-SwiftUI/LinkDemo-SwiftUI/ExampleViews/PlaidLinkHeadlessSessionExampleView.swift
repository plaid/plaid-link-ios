//
//  PlaidLinkHeadlessSessionExampleView.swift
//  LinkDemo-SwiftUI
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

import LinkKit
import SwiftUI

struct PlaidLinkHeadlessSessionExampleView: View {

    /// Important the token used here must be a payment token that triggers a "headless" flow
    /// otherwise the flow will consistently error out.
    init(linkToken: String) {
        self.linkToken = linkToken
    }

    var body: some View {
        VStack(spacing: 16) {
            Text("Plaid Link Headless Session Example")
            LinkKitVersionInfoView()

            // Error Display (if applicable)
            if case .error(let message) = state {
                PlaidErrorView(message: message)
            }

            Button(action: {
                if let headlessSession {
                    headlessSession.start()
                }
            }) {
                HStack(spacing: 12) {
                    if state.isLoading {
                        ProgressView()
                            .tint(.white)
                    }

                    Text("Launch Payment Flow")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(state.isLoading ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .disabled(!state.isReady)  // Disable until Headless Session is ready.
            .padding(.horizontal)
        }
        .onAppear(perform: createSession)
    }

    private let linkToken: String
    @State private var state: LoadingState = .loading
    @State private var headlessSession: PlaidHeadlessSession?

    private func createSession() {
        let configuration = LinkTokenConfiguration(
            token: linkToken,
            onSuccess: { linkSuccess in
                // Closure is called when a user successfully links an Item. It should take a single LinkSuccess argument,
                // containing the publicToken String and a metadata of type SuccessMetadata.
                // Ref - https://plaid.com/docs/link/ios/#onsuccess
                print("public-token: \(linkSuccess.publicToken) metadata: \(linkSuccess.metadata)")
            },
            onExit: { linkExit in
                // Optional closure is called when a user exits Link without successfully linking an Item,
                // or when an error occurs during Link initialization. It should take a single LinkExit argument,
                // containing an optional error and a metadata of type ExitMetadata.
                // Ref - https://plaid.com/docs/link/ios/#onexit
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
            },
            onLoad: {
                /// An optional callback invoked when Plaid Link has finished loading and is ready to be presented.
                ///
                /// You can use this callback to automatically open Link or to enable UI elements that depend on
                /// Link being fully initialized. Waiting for Link to load will provide a better UX to your users.
                withAnimation {
                    // Link is loaded allow the user to Link their account now.
                    self.state = .ready
                }
            }
        )

        do {
            let session = try Plaid.createHeadlessSession(configuration: configuration)
            self.headlessSession = session
        } catch {
            self.state = .error(error.localizedDescription)
        }
    }
}
