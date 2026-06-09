//
//  PlaidLinkUIViewControllerRepresentableExampleView.swift
//  LinkDemo-SwiftUI
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

import SwiftUI

struct PlaidErrorView: View {
    let message: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.red)
                .font(.title)

            Text(message)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}

// Preview provider for quick design checks
#Preview {
    PlaidErrorView(message: "The link token has expired. Please try again.")
}
