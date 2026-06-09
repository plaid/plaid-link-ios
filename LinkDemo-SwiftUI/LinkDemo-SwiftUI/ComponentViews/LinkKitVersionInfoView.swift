//
//  PlaidLinkUIViewControllerRepresentableExampleView.swift
//  LinkDemo-SwiftUI
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

import LinkKit
import SwiftUI

/// Returns a tiny SwiftUI view that shows the LinkKit SDK version,
/// e.g. **“LinkKit 7.0.0”**.
struct LinkKitVersionInfoView: View {
    var body: some View {
        return Text("LinkKit \(Plaid.version)")
            .foregroundColor(.gray)
            .font(.system(size: 12))
    }
}
