//
//  PlaidLayerSessionExampleView.swift
//  LinkDemo-SwiftUI
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

import LinkKit
import SwiftUI

struct LayerSubmissionData: SubmissionData {
    var phoneNumber: String?
    var dateOfBirth: String?
    var params: [String: String]?
}

struct PlaidLayerSessionExampleView: View {

    init(linkToken: String) {
        self.linkToken = linkToken
    }

    var body: some View {
        VStack(spacing: 16) {
            Text("Plaid Layer Session Example")
            LinkKitVersionInfoView()

            // Error Display (if applicable)
            if case .error(let message) = state {
                PlaidErrorView(message: message)
            }

            VStack(spacing: 20) {
                LabeledTextInputView(
                    title: "User Phone Number",
                    text: $phoneNumber,
                    placeholder: "+1 415-555-0011",
                    keyboardType: .phonePad
                )

                LabeledTextInputView(
                    title: "User Date of Birth",
                    text: $dob,
                    placeholder: "YYYY-MM-DD",
                    keyboardType: .numbersAndPunctuation
                )

                Button(action: {
                    let submissionData = LayerSubmissionData(phoneNumber: phoneNumber, dateOfBirth: dob)
                    layerSession?.submit(data: submissionData)
                }) {
                    Text("Submit User Data")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(layerSession != nil ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()

            Button(action: {
                isPresentingLayer = true
            }) {
                HStack(spacing: 12) {
                    if state.isLoading {
                        ProgressView()
                            .tint(.white)
                    }

                    Text("Launch Layer")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(state.isReady ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .disabled(!state.isReady)
            .padding(.horizontal)
        }
        .onAppear(perform: createSession)
        .fullScreenCover(isPresented: $isPresentingLayer) {
            if let session = layerSession {
                session.sheet()
            }
        }
    }

    private let linkToken: String
    @State private var state: LoadingState = .loading
    @State private var layerSession: PlaidLayerSession?
    @State private var phoneNumber: String = "+1 415-555-0011"
    @State private var dob: String = "1975-01-18"
    @State private var isPresentingLayer: Bool = false

    private func createSession() {
        let configuration = LayerTokenConfiguration(
            token: linkToken,
            onSuccess: { linkSuccess in
                // Closure is called when a user successfully links an Item. It should take a single LinkSuccess argument,
                // containing the publicToken String and a metadata of type SuccessMetadata.
                // Ref - https://plaid.com/docs/link/ios/#onsuccess
                print("public-token: \(linkSuccess.publicToken) metadata: \(linkSuccess.metadata)")
                isPresentingLayer = false
            },
            onExit: { linkExit in
                // Optional closure is called when a user exits Link without successfully linking an Item,
                // or when an error occurs during Link initialization. It should take a single LinkExit argument,
                // containing an optional error and a metadata of type ExitMetadata.
                // Ref - https://plaid.com/docs/link/ios/#onexit
                isPresentingLayer = false

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

                // Wait for the Layer ready event.
                if linkEvent.eventName == .layerReady {
                    self.state = .ready
                } else if linkEvent.eventName == .layerNotAvailable {
                    self.state = .error("Layer not available")
                }
            }
        )

        do {
            let session = try Plaid.createPlaidLayerSession(configuration: configuration)
            self.layerSession = session
        } catch {
            self.state = .error(error.localizedDescription)
        }
    }
}
