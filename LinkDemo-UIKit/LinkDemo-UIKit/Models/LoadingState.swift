//
//  LoadingState.swift
//  LinkDemo-UIKit
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

import Foundation

enum LoadingState {
    case loading
    case ready
    case error(String)

    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }

    var isReady: Bool {
        if case .ready = self { return true }
        return false
    }
}
