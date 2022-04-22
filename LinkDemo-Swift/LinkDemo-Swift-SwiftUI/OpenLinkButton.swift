//
//  LinkKitSwiftUISupport.swift
//  LinkDemo-Swift
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//
import LinkKit
import SwiftUI

struct OpenLinkButton: View {
    static let color = Color(
        red: 0,
        green: 191 / 256,
        blue: 250 / 256,
        opacity: 1
    )

    @State private var showLink = false

    #warning("Replace <#GENERATED_LINK_TOKEN#> below with your link_token")
    private let linkToken = "<#GENERATED_LINK_TOKEN#>"

    var body: some View {
        Button(action: {
            self.showLink = true
        }) {
            Text("Open Plaid Link")
                .font(.system(size: 17, weight: .medium))
        }
        .padding()
        .foregroundColor(.white)
        .background(
            Self.color
                .frame(width: 1000, height: 1000)
        )
        .fill(alignment: .center)
        .cornerRadius(4)
        .sheet(isPresented: self.$showLink,
            onDismiss: {
                self.showLink = false
            }, content: {
                PlaidLinkFlow(
                    linkTokenConfiguration: createLinkTokenConfiguration(),
                    showLink: $showLink
                )
            }
        )
    }

    private func createLinkTokenConfiguration() -> LinkTokenConfiguration {
        var configuration = LinkTokenConfiguration(
            token: linkToken,
            onSuccess: { success in
                print("public-token: \(success.publicToken) metadata: \(success.metadata)")
                showLink = false
            }
        )

        configuration.onEvent = { event in
            print("Link Event: \(event)")
        }

        configuration.onExit = { exit in
            if let error = exit.error {
                print("exit with \(error)\n\(exit.metadata)")
            } else {
                print("exit with \(exit.metadata)")
            }
            
            showLink = false
        }

        return configuration
    }
}

private struct PlaidLinkFlow: View {
    @Binding var showLink: Bool
    private let linkTokenConfiguration: LinkTokenConfiguration

    init(linkTokenConfiguration: LinkTokenConfiguration, showLink: Binding<Bool>) {
        self.linkTokenConfiguration = linkTokenConfiguration
        self._showLink = showLink
    }

    var body: some View {
        let linkController = LinkController(
            configuration: .linkToken(linkTokenConfiguration)
        ) { createError in
            print("Link Creation Error: \(createError)")
            self.showLink = false
        }

        return linkController
            .onOpenURL { url in
                linkController.linkHandler?.continue(from: url)
            }
    }
}

struct OpenLinkButton_Previews: PreviewProvider {
    static var previews: some View {
        OpenLinkButton()
            .frame(width: 312, height: 56)
    }
}
