//
//  SyncFinanceKitExampleView.swift
//  LinkDemo-SwiftUI
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

import LinkKit
import SwiftUI

struct SyncFinanceKitExampleView: View {

    init(linkToken: String) {
        self.linkToken = linkToken
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Sync FinanceKit Example")
                    .font(.title2)
                    .bold()

                LinkKitVersionInfoView()

                Text("⚠️ IMPORTANT")
                    .font(.headline)
                    .foregroundColor(.orange)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Requirements:")
                        .font(.headline)

                    Text("1. You MUST have a FinanceKit entitlement from Apple (or the app will crash)")
                    Text(
                        "2. The link token must be associated with an access token from a previous session where the user linked their Apple Card"
                    )
                    Text("3. iOS 17.4 or later is required")
                }
                .font(.subheadline)
                .foregroundColor(.primary)
                .padding()
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)

                if let statusMessage = statusMessage {
                    Text(statusMessage)
                        .font(.subheadline)
                        .foregroundColor(statusIsError ? .red : .green)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                if #available(iOS 17.4, *) {
                    Button(action: syncFinanceKit) {
                        HStack(spacing: 12) {
                            if isSyncing {
                                ProgressView()
                                    .tint(.white)
                            }
                            
                            Text("Sync FinanceKit")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isSyncing ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .disabled(isSyncing)
                    .padding(.horizontal)
                } else {
                    Text("iOS >= 17.4 is required for FinanceKit")
                }
            }
            .padding(.vertical)
        }
    }

    private let linkToken: String
    @State private var isSyncing: Bool = false
    @State private var statusMessage: String?
    @State private var statusIsError: Bool = false

    @available(iOS 17.4, *)
    private func syncFinanceKit() {
        isSyncing = true
        statusMessage = nil

        PlaidFinanceKit.sync(
            token: linkToken,
            requestAuthorizationIfNeeded: true,
            syncBehavior: .live,
            completion: { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        statusMessage = "✅ Sync completed successfully"
                        statusIsError = false
                        isSyncing = false

                    case .failure(let error):
                        statusMessage = "❌ Sync failed: \(error.localizedDescription)"
                        statusIsError = true
                        isSyncing = false
                    }
                }
            }
        )
    }
}
