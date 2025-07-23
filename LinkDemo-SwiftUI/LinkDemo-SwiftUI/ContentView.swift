//
//  ContentView.swift
//  LinkDemo-SwiftUI
//
//  Copyright © 2023 Plaid Inc. All rights reserved.
//

import LinkKit
import SwiftUI

/// An enum representing different ways to present Plaid Link in a SwiftUI app.
enum LinkPresentationType: Int, Identifiable, CustomStringConvertible {
    case sheet = 1  // Uses handler.makePlaidLinkSheet()
    case modifierHandler = 2  // Uses .plaidLink() modifier with handler
    case modifierToken = 3  // Uses .plaidLink() modifier with token
    case controller = 4  // Uses UIKit-based LinkController

    var id: Int { rawValue }

    /// Used to display tab icons.
    var imageName: String { "\(rawValue).circle" }

    /// A human-readable label for each presentation type.
    var description: String {
        switch self {
        case .sheet: return "Make Plaid Link Sheet"
        case .modifierHandler: return ".plaidLink modifier"
        case .modifierToken: return ".plaidLink modifier with token"
        case .controller: return "Link Controller (UIViewController representable)"
        }
    }
}

struct ContentView: View {

    /// Keeps track of which demo tab is active and whether it should be presented
    @State private var activePresentationType: LinkPresentationType?

    /// Flag to track if Link is still loading
    /// - Note: You can open Link while it's still loading.
    @State private var isLoadingLink = true

    /// Required Plaid Handler for launching Link
    /// - Note: Not all methods require the handler be created.
    @State private var handler: Handler?

    /// UIViewControllerRepresentable see `LinkController.swift` for more information.
    @State private var linkController: LinkController?

    /// Error that can occur when creating a Plaid Handler.
    @State private var error: Plaid.CreateError?

    // Steps to acquire a Link Token:
    //
    // 1. Sign up for a Plaid account to get an API key.
    //      Ref - https://dashboard.plaid.com/signup
    //
    // 2. Make a request to our API using your API key.
    //      Ref - https://plaid.com/docs/quickstart/#introduction
    //      Ref - https://plaid.com/docs/api/tokens/#linktokencreate
    // In your production application replace the hardcoded linkToken above with code that fetches a linkToken
    // from your backend server which in turn retrieves it securely from Plaid, for details please refer to
    // https://plaid.com/docs/api/tokens/#linktokencreate
    #warning("Replace <#GENERATED_LINK_TOKEN#> below with your link_token")
    private let linkToken: String = "<#GENERATED_LINK_TOKEN#>"

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Top section: title, SDK version, instructions
            headerView()

            switch (error, handler) {
            case (.some(let error), .none):
                // If there was an error creating the handler, show it
                Spacer()
                Text("Error creating handler: \(String(describing: error))")
                    .padding()

            case (.none, .some(let handler)):
                // If there was an error creating the handler, show it.
                TabView {
                    // MARK: 1. Sheet-based Link
                    linkDemoButton(type: .sheet)
                        .fullScreenCover(isPresented: binding(for: .sheet)) {
                            handler.makePlaidLinkSheet()
                        }
                        .tabItem {
                            Label("", systemImage: LinkPresentationType.sheet.imageName)
                        }

                    // MARK: 2. .plaidLink modifier with Handler
                    linkDemoButton(type: .modifierHandler)
                        .plaidLink(isPresented: binding(for: .modifierHandler), handler: handler)
                        .tabItem {
                            Label("", systemImage: LinkPresentationType.modifierHandler.imageName)
                        }

                    // MARK: 3. .plaidLink modifier with token (Handler creation is not required).
                    linkDemoButton(type: .modifierToken)
                        .plaidLink(
                            isPresented: binding(for: .modifierToken),
                            token: linkToken,
                            onSuccess: { print("✅", $0.publicToken) },
                            onExit: { print("🚪", $0) },
                            onEvent: { print("📣", $0.eventName) },
                            onLoad: { print("Link loaded") },
                            errorView: AnyView(
                                VStack {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                    Text("Link failed to create handler due to invalid token")
                                    Button("Dismiss") {
                                        self.activePresentationType = nil
                                    }
                                }
                                .padding()
                            )
                        )
                        .tabItem {
                            Label("", systemImage: LinkPresentationType.modifierToken.imageName)
                        }

                    // MARK: 4. UIKit-based controller
                    linkDemoButton(type: .controller)
                        .disabled(isLoadingLink)  // Example - Disable while loading
                        .fullScreenCover(
                            isPresented: binding(for: .controller),
                            onDismiss: { activePresentationType = nil },
                            content: {
                                if let linkController {
                                    linkController
                                        .ignoresSafeArea(.all)
                                } else {
                                    Text("Error: LinkController not initialized")
                                }
                            }
                        )
                        .tabItem {
                            Label("", systemImage: LinkPresentationType.controller.imageName)
                        }
                }

            default:
                // Defensive fallback (shouldn't happen in practice)
                EmptyView()
            }
        }
        .onAppear(perform: { createHandler() })
    }

    /// Creates a LinkTokenConfiguration, including success and exit callbacks.
    private func createLinkTokenConfiguration() -> LinkTokenConfiguration {
        var linkConfiguration = LinkTokenConfiguration(token: linkToken) { success in
            // Closure is called when a user successfully links an Item. It should take a single LinkSuccess argument,
            // containing the publicToken String and a metadata of type SuccessMetadata.
            // Ref - https://plaid.com/docs/link/ios/#onsuccess
            print("public-token: \(success.publicToken) metadata: \(success.metadata)")
            activePresentationType = nil  // Dismiss Link
        }

        // Optional closure is called when a user exits Link without successfully linking an Item,
        // or when an error occurs during Link initialization. It should take a single LinkExit argument,
        // containing an optional error and a metadata of type ExitMetadata.
        // Ref - https://plaid.com/docs/link/ios/#onexit
        linkConfiguration.onExit = { exit in
            if let error = exit.error {
                print("exit with \(error)\n\(exit.metadata)")
            } else {
                // User exited the flow without an error.
                print("exit with \(exit.metadata)")
            }
            activePresentationType = nil  // Dismiss Link
        }

        // Optional closure is called when certain events in the Plaid Link flow have occurred, for example,
        // when the user selected an institution. This enables your application to gain further insight into
        // what is going on as the user goes through the Plaid Link flow.
        // Ref - https://plaid.com/docs/link/ios/#onevent
        linkConfiguration.onEvent = { event in
            print("Link Event: \(event)")
        }

        // Set to `true` to skip the initial native loading spinner shown when Link launches.
        // This can be useful if your app provides its own custom loading indicator.
        linkConfiguration.noLoadingState = false

        // Controls whether a transparent gradient background is displayed behind the Link view.
        // Set to `false` to disable the default gradient background.
        linkConfiguration.showGradientBackground = true

        return linkConfiguration
    }

    /// Attempts to builds a Link `Handler`.
    private func createHandler() {
        let configuration = createLinkTokenConfiguration()
        // This only results in an error if the token is malformed.
        let result = Plaid.create(
            configuration,
            onLoad: {
                // Optional callback that is invoked once Plaid Link has finished loading and is ready to be presented.
                // You could use your own loading UI and automatically launch Link when this callback fires.

                // Flip flag once Link has finished loading.
                self.isLoadingLink = false
            }
        )

        switch result {
        case .success(let h):
            self.handler = h
            self.linkController = LinkController(handler: h)
        case .failure(let error):
            self.error = error
        }
    }

    /// Returns a binding that determines whether a given tab is actively presenting Link.
    private func binding(for type: LinkPresentationType) -> Binding<Bool> {
        Binding(
            get: { activePresentationType == type },
            set: { if !$0 { activePresentationType = nil } }
        )
    }

    /// Renders a reusable launch button for each demo tab.
    private func linkDemoButton(type: LinkPresentationType) -> some View {
        if #available(iOS 15, *) {
            return Button(type.description) { activePresentationType = type }
                .buttonStyle(.borderedProminent)
                .padding()
        } else {
            return Button(type.description) { activePresentationType = type }
                .padding()
        }
    }

    /// Returns a tiny SwiftUI view that shows the LinkKit SDK version,
    /// e.g. **“LinkKit 6.2.1”**.
    private func versionInformationView() -> some View {
        // ------------------------------------------------------------------
        // 1. Locate the bundle that contains the LinkKit framework.
        //    We ask for the bundle “that defines the PLKPlaid class.”
        // ------------------------------------------------------------------
        let bundle = Bundle(for: PLKPlaid.self)

        // ------------------------------------------------------------------
        // 2. Read the bundle’s display name and short version string
        //    from its Info.plist.  Provide safe defaults if anything
        //    is missing (e.g. in a test-host).
        // ------------------------------------------------------------------
        let name =
            bundle.object(
                forInfoDictionaryKey: kCFBundleNameKey as String
            ) as? String ?? "LinkKit"

        let version =
            bundle.object(
                forInfoDictionaryKey: "CFBundleShortVersionString"
            ) as? String ?? "Unknown"

        // ------------------------------------------------------------------
        // 3. Create the final “LinkKit 4.5.0” text and style it.
        // ------------------------------------------------------------------
        return Text("\(name) \(version)")
            .foregroundColor(.gray)
            .font(.system(size: 12))
    }

    /// Renders the top welcome message and version info.
    private func headerView() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("WELCOME")
                .foregroundColor(Color(red: 0, green: 191 / 256, blue: 250 / 256, opacity: 1))  // Plaid blue.
                .font(.system(size: 12, weight: .bold))

            Text("Plaid Link SDK\nSwiftUI Example")
                .font(.system(size: 32, weight: .light))

            versionInformationView()

            Text("Select a tab to try a different Link presentation method.")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 32)
        .padding(.top, 16)
    }
}

struct LinkView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
