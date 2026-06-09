//
//  LinkKitSwiftUISupport.swift
//  LinkDemo-SwiftUI
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

import SwiftUI

@main
struct LinkDemoSwiftuiApp: App {
    /// Wrapper view for options related to LinkKit SDK.
    var body: some Scene {
        WindowGroup {
            ExampleListView(linkToken: linkToken)
        }
    }

    // MARK: Private

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
}
