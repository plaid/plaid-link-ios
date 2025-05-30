//
//  ContentView.swift
//  LinkDemo-SwiftUI
//
//  Copyright © 2023 Plaid Inc. All rights reserved.
//

import LinkKit
import SwiftUI

struct ContentView: View {

    @State private var isPresentingLink = false
    @State private var isLoadingLink = true
    @State private var linkController: LinkController?

    var body: some View {
        ZStack(alignment: .leading) {
            backgroundColor.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 12) {

                Text("WELCOME")
                    .foregroundColor(plaidBlue)
                    .font(.system(size: 12, weight: .bold))

                Text("Plaid Link SDK\nSwiftUI Example")
                    .font(.system(size: 32, weight: .light))

                versionInformation()

                Spacer()

                VStack(alignment: .center) {

                    Button(action: {
                        isPresentingLink = true
                    }, label:  {
                        if isLoadingLink {
                            HStack(spacing: 8) {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                Text("Loading...")
                                    .font(.system(size: 17, weight: .medium))
                            }
                            .frame(width: 312)
                        } else {
                            Text("Open Plaid Link")
                                .font(.system(size: 17, weight: .medium))
                                .frame(width: 312)
                        }
                    })
                    .padding()
                    .foregroundColor(.white)
                    .background(plaidBlue)
                    .cornerRadius(4)
                    .disabled(isLoadingLink) // Disable while loading
                }
                .frame(height: 56)
            }
            .padding(EdgeInsets(top: 16, leading: 32, bottom: 0, trailing: 32))
        }
        .fullScreenCover(
            isPresented: $isPresentingLink,
            onDismiss: { isPresentingLink = false },
            content: {
                if let linkController {
                    linkController
                        .ignoresSafeArea(.all)
                } else {
                    Text("Error: LinkController not initialized")
                }
            }
        )
        .onAppear {
            // Create a Handler right away so Link can begin loading prior to the user pressing the button.
            let createResult = createHandler()
            switch createResult {
            case .failure(let createError):
                print("Link Creation Error: \(createError.localizedDescription)")
            case .success(let handler):
                linkController = LinkController(handler: handler)
            }
        }
    }

    private let backgroundColor: Color = Color(
        red: 247 / 256,
        green: 249 / 256,
        blue: 251 / 256,
        opacity: 1
    )

    private let plaidBlue: Color = Color(
        red: 0,
        green: 191 / 256,
        blue: 250 / 256,
        opacity: 1
    )

    private func versionInformation() -> some View {
        let linkKitBundle  = Bundle(for: PLKPlaid.self)
        let linkKitVersion = linkKitBundle.object(forInfoDictionaryKey: "CFBundleShortVersionString")!
        let linkKitBuild   = linkKitBundle.object(forInfoDictionaryKey: kCFBundleVersionKey as String)!
        let linkKitName    = linkKitBundle.object(forInfoDictionaryKey: kCFBundleNameKey as String)!
        let versionText = "\(linkKitName) \(linkKitVersion)+\(linkKitBuild)"

        return Text(versionText)
            .foregroundColor(.gray)
            .font(.system(size: 12))
    }

    private func createHandler() -> Result<Handler, Plaid.CreateError> {
        let configuration = createLinkTokenConfiguration()

        // This only results in an error if the token is malformed.
        return Plaid.create(
            configuration,
            onLoad: {
                // Optional callback that is invoked once Plaid Link has finished loading and is ready to be presented.
                // You could use your own loading UI and automatically launch Link when this callback fires.
                //
                // Ex: self?.isPresentingLink = true

                // Enable the button once Link has loaded
                self.isLoadingLink = false
            }
        )
    }

    private func createLinkTokenConfiguration() -> LinkTokenConfiguration {
        // Steps to acquire a Link Token:
        //
        // 1. Sign up for a Plaid account to get an API key.
        //      Ref - https://dashboard.plaid.com/signup
        //
        // 2. Make a request to our API using your API key.
        //      Ref - https://plaid.com/docs/quickstart/#introduction
        //      Ref - https://plaid.com/docs/api/tokens/#linktokencreate
        #warning("Replace <#GENERATED_LINK_TOKEN#> below with your link_token")
        let linkToken = "<#GENERATED_LINK_TOKEN#>"

        // In your production application replace the hardcoded linkToken above with code that fetches a linkToken
        // from your backend server which in turn retrieves it securely from Plaid, for details please refer to
        // https://plaid.com/docs/api/tokens/#linktokencreate

        var linkConfiguration = LinkTokenConfiguration(token: linkToken) { success in
            // Closure is called when a user successfully links an Item. It should take a single LinkSuccess argument,
            // containing the publicToken String and a metadata of type SuccessMetadata.
            // Ref - https://plaid.com/docs/link/ios/#onsuccess
            print("public-token: \(success.publicToken) metadata: \(success.metadata)")
            isPresentingLink = false
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
            isPresentingLink = false
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
}

struct LinkView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
