//
//  LabeledTextInputView.swift
//  LinkDemo-SwiftUI
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

import SwiftUI

internal struct LabeledTextInputView: View {
    internal let title: String
    @Binding internal var text: String
    internal let placeholder: String
    internal var keyboardType: UIKeyboardType = .default

    internal var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.secondary)

            TextField(placeholder, text: $text)
                .font(.system(size: 16))
                .padding(.horizontal, 12)
                .padding(.vertical, 14)
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                .keyboardType(keyboardType)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.none)
        }
    }
}
