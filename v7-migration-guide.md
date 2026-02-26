# Plaid Integration Migration Guide: LinkKit 5.x/6.x to 7.x

## 🧭 Quick Links
- [Standard Link Migration](#standard-link-changes)
- [Plaid Layer Migration](#plaid-layer-changes)
- [Headless Link Migration](#headless-link-changes)
- [Embedded Link Migration](#embedded-link-changes)
- [FinanceKit Sync Migration](#financekit-sync-changes)

## Why Upgrade

> ### 📦 CocoaPods Distribution Deprecated
> Starting with LinkKit 7.x, **CocoaPods is no longer a supported distribution method**. This aligns with the official CocoaPods "Retirement Plan," which will see the trunk become permanently read-only on **December 2nd, 2026**.
> 
> After this date, no new Podspecs or updates can be submitted to the central repository. To ensure your project remains secure and up-to-date, you must migrate to **Swift Package Manager (SPM)**.
> 
> **Official Resources:**
> 
> - **[CocoaPods Trunk Read-only Plan](https://blog.cocoapods.org/CocoaPods-Specs-Repo/)**
> - **[Plaid Link iOS SPM Repository](https://github.com/plaid/plaid-link-ios-spm)**

Upgrading to LinkKit 7.x optimizes your app's performance and aligns with modern iOS development standards. Key benefits include:

**Significant SDK Footprint Reduction**: The SDK size of the LinkKit executable has been reduced from ~6.4MB to just 2.5MB.

**Built-in SwiftUI Support**: Version 7.x introduces native modifiers like `.plaidLink(isPresented:token:...)` and `.sheet()`, eliminating the need for `UIViewControllerRepresentable` wrappers.

**Enhanced Debugging & Reliability**:
- Improved internal logging to help diagnose session failures more effectively.
- Higher reliability for LinkEvent delivery, ensuring your analytics and funnel tracking are accurate.

**Superior UX Control**: LinkKit 7.x allows you to know exactly when Link is ready to be presented. You can now pre-initialize Link in the background and only show your "Connect" button or Link once it's fully loaded, eliminating jarring loading indicators.

## Overview

The upgrade from LinkKit 5.x or 6.x includes breaking changes. Most notable is the migration from a `Handler` to a session based API. 

Plaid iOS SDK Migration Guide: Handler to Session-based API

This guide provides the necessary steps to migrate your iOS integration from the legacy **Handler-based** API to the modern **Session-based** API.

> ### 🏛️ Objective-C Compatibility Bridge
> If your project requires Objective-C support, you must explicitly import the **`LinkKitObjC`** module. The core `LinkKit` module is now Swift-only to optimize performance.
> 
> The code for this compatibility bridge is now fully open-source and visible within the public repository for your reference. Additionally, there is an updated Objective-C example app.

### New Session Based Models

The new architecture moves away from a single "catch-all" Handler in favor of specialized Session objects. By requiring explicit initialization for each Plaid flow, the SDK offers improved code clarity and stricter boundaries between standard Link, Headless, Layer, and Embedded implementations.

> ### ⚠️ Important: Token-to-Session Compatibility
> Each session type requires a specific **link-token** generated for that exact product. You cannot use a standard Link token to initialize a Layer or Headless session. 
>
> If there is a mismatch (e.g., passing a standard Link token into `createPlaidLayerSession`), the session will fail immediately, and you will receive an **ExitError**. Ensure your backend is generating the correct token type for your intended implementation.

#### Standard Link Changes

##### LinkTokenConfiguration

**Old Way**: You set `onSuccess`, `onExit`, and `onEvent` on the `LinkTokenConfiguration`, but onLoad was a separate piece you passed into `Plaid.create`.

**New Way**: Everything is in the configuration. `onLoad` is now a standard part of the `LinkTokenConfiguration` struct.

| ❌ Legacy Implementation (Old Way) | ✅ Modern Implementation (New Way) |
| :--- | :--- |
| <pre>var configuration = LinkTokenConfiguration(<br>  token: "link-sandbox-123",<br>  onSuccess: { success in ... }<br>)<br><br>// Properties set separately<br>configuration.onExit = { exit in ... }<br>configuration.onEvent = { event in ... }<br><br>// onLoad was passed into Plaid.create()</pre> | <pre>let configuration = LinkTokenConfiguration(<br>  token: "link-sandbox-123",<br>  onSuccess: { success in ... },<br>  onExit: { exit in ... },<br>  onEvent: { event in ... },<br>  onLoad: { <br>    // Move "ready" logic here!<br>    self.state = .ready <br>  }<br>)</pre> |

##### Session vs Handler Implementation

**Old Way**: You called `Plaid.create` which returned a Result containing a `Handler`. You then had to keep that handler alive and call `.open(from:)`.

**New Way**: You call `Plaid.createPlaidLinkSession` which throws an error if setup fails. You receive a Session object and call `.open(using:)` or use the native SwiftUI `.sheet()`.

| ❌ Legacy Implementation (Old Way) | ✅ Modern Implementation (New Way) |
| :--- | :--- |
| <pre> let result = Plaid.create(configuration) <br> switch result {<br>  case .success(let handler):<br>    // Must retain handler!<br>    self.linkHandler = handler<br>    handler.open(from: .viewController(self))<br>  case .failure(let error):<br>    print(error)<br>  }<br>}</pre> | <pre>do {<br>  let session = try Plaid.createPlaidLinkSession(<br>    configuration: configuration<br>  )<br>  // Must retain session!<br>  self.linkSession = session<br>  session.open(using: .viewController(self))<br>} catch {<br>  print(error)<br>}</pre> |

Full SwiftUI Example

```swift
import LinkKit
import SwiftUI

struct PlaidLinkSessionExampleView: View {
    let linkToken: String
    @State private var linkSession: PlaidLinkSession?
    @State private var isPresentingLink = false
    @State private var isReady = false

    var body: some View {
        Button("Connect Bank Account") {
            isPresentingLink = true
        }
        .disabled(!isReady)
        .onAppear(perform: createSession)
        .sheet(isPresented: $isPresentingLink) {
            linkSession?.sheet()
        }
    }

    private func createSession() {
        // Prevent redundant session initializations if one already exists.
        guard linkSession == nil else { return }        
		 
        let config = LinkTokenConfiguration(
            token: linkToken,
            onSuccess: { print("Success: \($0.publicToken)") },
            onExit: { print("Exit: \($0.error?.localizedDescription ?? "No error")") },
            onLoad: { 
                print("Ready")
                isReady = true 
            }
        )

        do {
            linkSession = try Plaid.createPlaidLinkSession(configuration: config)
        } catch {
            print("Setup Error: \(error)")
        }
    }
}
```

For more implementation examples including UIKit, Objective-C, and advanced use cases explore the example apps included in this repository.

#### Plaid Layer Changes

##### LayerTokenConfiguration

**Old Way**: Layer was handled by passing a standard `LinkTokenConfiguration` to create a handler.

**New Way**: Layer now has its own dedicated `LayerTokenConfiguration` and `PlaidLayerSession`. Readiness is explicitly determined by listening for the `.layerReady` event within the `onEvent` closure.

| ❌ Legacy Implementation (Old Way) | ✅ Modern Implementation (New Way) |
| :--- | :--- |
| <pre>var config = LinkTokenConfiguration(<br>  token: "link-sandbox-123",<br>  onSuccess: { success in ... }<br>)<br><br>config.onEvent = { event in<br>  if event.eventName == "ready" {<br>    self.handler?.open(from: .viewController(self))<br>  }<br>}<br><br>Plaid.create(config) { result in<br>  if case .success(let handler) = result {<br>    self.handler = handler<br>  }<br>}</pre> | <pre>let config = LayerTokenConfiguration(<br>  token: "link-sandbox-123",<br>  onSuccess: { success in ... },<br>  onEvent: { event in<br>    if event.eventName == .layerReady {<br>      // Option A: UIKit Presentation<br>      self.session?.open(using: .viewController(self))<br><br>      // Option B: SwiftUI Flag<br>      // self.isSessionReady = true<br>    }<br>  }<br>)<br><br>do {<br>  self.session = try Plaid.createPlaidLayerSession(<br>    configuration: config<br>  )<br>} catch {<br>  print(error)<br>}</pre> |

##### Plaid Layer SwiftUI Example

In Layer sessions, use the `.submit(data:)` method to pass user-provided information (like phone number or date of birth) directly to the active session.

```swift
import LinkKit
import SwiftUI

struct PlaidLayerSessionExampleView: View {
    let linkToken: String
    @State private var layerSession: PlaidLayerSession?
    @State private var isPresentingLayer = false
    @State private var isReady = false
    @State private var phoneNumber: String = "+1 415-555-0011"
    @State private var dob: String = "1975-01-18"

    var body: some View {
        VStack(spacing: 20) {
            // Submit data to Layer after the session is created.
            Button("Submit User Data") {
                let data = LayerSubmissionData(phoneNumber: phoneNumber, dateOfBirth: dob)
                layerSession?.submit(data: data)
            }
            .disabled(layerSession == nil)

            Button("Launch Layer") {
                isPresentingLayer = true
            }
            .disabled(!isReady)
        }
        .onAppear(perform: createSession)
        .fullScreenCover(isPresented: $isPresentingLayer) {
            layerSession?.sheet()
        }
    }

    private func createSession() {
        // Prevent redundant session initializations if one already exists.
        guard layerSession == nil else { return }
        
        let config = LayerTokenConfiguration(
            token: linkToken,
            onSuccess: { _ in isPresentingLayer = false },
            onExit: { _ in isPresentingLayer = false },
            onEvent: { event in
                if event.eventName == .layerReady {
                    isReady = true
                }
            }
        )

        do {
            layerSession = try Plaid.createPlaidLayerSession(configuration: config)
        } catch {
            print("Layer Setup Error: \(error)")
        }
    }
}

struct LayerSubmissionData: SubmissionData {
    var phoneNumber: String?
    var dateOfBirth: String?
    var params: [String: String]?
}
```

For more implementation examples including UIKit, Objective-C, and advanced use cases explore the example apps included in this repository.


#### Headless Link Changes

##### Plaid Headless Session

**Old Way**: Headless was handled by passing a standard `LinkTokenConfiguration` to create a handler.

**New Way**: Headless still uses a `LinkTokenConfiguration ` However, there is no longer a need for `noLoadingState` since you'll create a `PlaidHeadlessSession` which never has a loading state. This session object only has one method `.start()` which you can call once the `onLoad` callback is triggered.

| ❌ Legacy Implementation (Old Way) | ✅ Modern Implementation (New Way) |
| :--- | :--- |
| <pre>let config = LinkTokenConfiguration(<br>  token: "link-headless-token",<br>  onSuccess: { success in ... }<br>)<br><br>Plaid.create(config) { result in<br>  switch result {<br>  case .success(let handler):<br>    self.handler = handler<br>    handler.open(from: .viewController(self))<br>  case .failure(let error):<br>    print(error)<br>  }<br>}</pre> | <pre>let config = LinkTokenConfiguration(<br>  token: "link-headless-token",<br>  onSuccess: { success in ... },<br>  onLoad: { self.session?.start() }<br>)<br><br>do {<br>  let session = try Plaid.createHeadlessSession(<br>    configuration: config<br>  )<br>  self.session = session  <br>} catch {<br>  print(error)<br>}</pre> |

##### Plaid Headless SwiftUI Example

Headless sessions are ideal for flows where you want to maintain your own UI while Plaid handles the background processing. Note that the `linkToken` used here must be specifically generated for headless-compatible flows.

```swift
import LinkKit
import SwiftUI

struct PlaidLinkHeadlessSessionExampleView: View {
    let linkToken: String
    @State private var headlessSession: PlaidHeadlessSession?
    @State private var isReady = false

    var body: some View {
        Button("Launch Payment Flow") {
            // Headless flows are triggered programmatically, not via sheet
            headlessSession?.start()
        }
        .disabled(!isReady)
        .onAppear(perform: createSession)
    }

    private func createSession() {
        // Prevent redundant session initializations if one already exists.
        guard headlessSession == nil else { return }
        
        let config = LinkTokenConfiguration(
            token: linkToken,
            onSuccess: { print("Success: \($0.publicToken)") },
            onExit: { print("Exit: \($0.error?.localizedDescription ?? "No error")") },
            onLoad: { 
                print("Headless Ready")
                isReady = true 
            }
        )

        do {
            // Create the specialized headless session
            headlessSession = try Plaid.createHeadlessSession(configuration: config)
        } catch {
            print("Headless Setup Error: \(error)")
        }
    }
}
```

For more implementation examples including UIKit, Objective-C, and advanced use cases explore the example apps included in this repository.

#### Embedded Link Changes

##### EmbeddedLinkTokenConfiguration

**Old Way**: You had to create a standard `LinkTokenConfiguration`, a `Handler`, and then manually wrap the resulting `UIView` in a `UIViewRepresentable` (for SwiftUI).

**New Way**: Embedded Link now has a dedicated `EmbeddedLinkTokenConfiguration`. You can create a native SwiftUI `EmbeddedSearchView` or a UIKit `EmbeddedSearchUIView` directly. These views handle their own internal presentation of the Link flow automatically when a user selects an institution.

| ❌ Legacy Implementation (Old Way) | ✅ Modern Implementation (New Way) |
| :--- | :--- |
| <pre>var config = LinkTokenConfiguration(<br>  token: "link-sandbox-123",<br>  onSuccess: { success in ... }<br>)<br><br>let result = Plaid.create(config)<br>if case .success(let handler) = result {<br>  // Manual UIViewRepresentable wrapping<br>  let view = handler.createEmbeddedView(...)<br>}</pre> | <pre>let config = EmbeddedLinkTokenConfiguration(<br>  token: "link-sandbox-123",<br>  onSuccess: { success in ... }<br>)<br><br>do {<br>  // SwiftUI: No wrapper needed!<br>  self.view = try Plaid.createEmbeddedLinkView(<br>    configuration: config<br>  )<br>} catch { ... }</pre> |

##### Embedded Link SwiftUI Example

The modern SwiftUI implementation is "Search-First." Simply place the `EmbeddedSearchView` in your hierarchy, and it will handle institutional search and the subsequent Link flow transition natively.

```swift
import LinkKit
import SwiftUI

struct PlaidEmbeddedLinkView: View {
    let linkToken: String
    @State private var embeddedSearchView: EmbeddedSearchView?

    var body: some View {
        VStack {
            if let embeddedSearchView {
                embeddedSearchView
                    // Use built-in size hints for perfect layout
                    .frame(
                        width: embeddedSearchView.expectedWidth, 
                        height: embeddedSearchView.expectedHeight
                    )
            }
        }
        .onAppear(perform: createEmbeddedView)
    }

    private func createEmbeddedView() {
        // Prevent redundant view initializations if one already exists.
        guard self.embeddedSearchView == nil else { return }
        
        let config = EmbeddedLinkTokenConfiguration(
            token: linkToken,
            onSuccess: { print("Success: \($0.publicToken)") },
            onExit: { print("Exit: \($0.metadata)") }
        )

        do {
            self.embeddedSearchView = try Plaid.createEmbeddedLinkView(configuration: config)
        } catch {
            print("Embedded Setup Error: \(error)")
        }
    }
}
```

#### FinanceKit Sync Changes

##### PlaidFinanceKit Sync API

**Old Way**: You called `Plaid.syncFinanceKit` and passed a `Bool` for `simulatedBehavior`. The method was part of the main `Plaid` struct.

**New Way**: Sync functionality has been moved to its own dedicated struct: `PlaidFinanceKit`. The `simulatedBehavior` boolean has been replaced by a more explicit `SyncBehavior` enum (`.live` or `.simulated`). Additionally, a modern **async/await** version of the sync method is now available.

> ### ⚠️ FinanceKit Requirements & Entitlements
> * **Entitlements Required**: To use `SyncBehavior.live`, your app **must** be granted the FinanceKit entitlement by Apple. Calling this method without the proper entitlement will cause your app to **crash**.
> * **Token Association**: The `link-token` used for this sync must be associated with an `access_token` for an Item (Apple Card) that the user has previously linked.
> * **iOS Version**: This feature requires **iOS 17.4 or later**.

| ❌ Legacy Implementation (Old Way) | ✅ Modern Implementation (New Way) |
| :--- | :--- |
| <pre>Plaid.syncFinanceKit(<br>  token: linkToken,<br>  requestAuthorizationIfNeeded: true,<br>  simulatedBehavior: true,<br>  completion: { result in<br>    // Handle Result<br>  }<br>)</pre> | <pre>PlaidFinanceKit.sync(<br>  token: linkToken,<br>  requestAuthorizationIfNeeded: true,<br>  syncBehavior: .simulated,<br>  completion: { result in<br>    // Handle Result<br>  }<br>)</pre> |

##### FinanceKit Implementation Example

The new API provides both closure-based and async/await support. Below is the standard completion handler implementation:

```swift
@available(iOS 17.4, *)
private func syncFinanceKit() {
    isSyncing = true

    PlaidFinanceKit.sync(
        token: linkToken,
        requestAuthorizationIfNeeded: true,
        syncBehavior: .live
    ) { [weak self] result in
        DispatchQueue.main.async {
            self?.isSyncing = false
            switch result {
            case .success:
                print("✅ Sync completed successfully")
            case .failure(let error):
                print("❌ Sync failed: \(error.localizedDescription)")
            }
        }
    }
}

@available(iOS 17.4, *)
func syncFinanceKit() async {
    do {
        try await PlaidFinanceKit.sync(
            token: linkToken,
            requestAuthorizationIfNeeded: true,
            syncBehavior: .live
        )
        print("✅ Sync completed successfully")
    } catch {
        print("❌ Sync failed: \(error.localizedDescription)")
    }
}
```
