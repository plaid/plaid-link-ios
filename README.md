# Plaid Link for iOS [![version][link-sdk-version]][link-sdk-pod-url] [![swift compatibility][link-sdk-swift-compat]][link-sdk-spi-url]

### Swift Package Manager

To install Plaid Link using [Swift Package Manager](https://github.com/apple/swift-package-manager) you can follow the [tutorial published by Apple](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app) using the URL for this repository with the current version:

1. In Xcode, select “File” → “Add Packages...”
2. Enter `https://github.com/plaid/plaid-link-ios-spm.git`

Alternatively, you can add the following dependency to your `Package.swift` file:

```swift
.package(url: "https://github.com/plaid/plaid-link-ios-spm.git", from: "5.6.0")
```

When using Swift Package Manager we recommend using the [plaid-link-spm](https://github.com/plaid/plaid-link-ios-spm) repo instead of the main plaid-link-ios repo. The main git repository for [plaid-link-ios](https://github.com/plaid/plaid-link-ios) is very large (~1 GB), and Swift Package Manager always downloads the full repository with all git history. This [plaid-link-ios-spm](https://github.com/plaid/plaid-link-ios-spm) repository is much smaller (less than 500kb), so can be downloaded much more quickly.

Instead of downloading the full git history of Plaid Link iOS and building it from source, this repository just contains a pointer to the precompiled XCFramework included in the [latest plaid-link-ios release](https://github.com/plaid/plaid-link-ios/releases/latest) (typically ~20MB). Since [plaid-link-ios](https://github.com/plaid/plaid-link-ios) doesn't provide source code it's strongly recommended that users depend on [plaid-link-ios-spm](https://github.com/plaid/plaid-link-ios-spm) instead.

When using plaid-link-ios-spm, the downloaded `LinkKit.xframework` isn't visible in the project navigator. To validate the authenticity of a plaid-link-ios-spm package, you can confirm that the `Package.swift` file references a binary XCFramework from https://github.com/plaid/plaid-link-ios/releases. 

📱 This repository contains multiple sample applications (requiring Xcode 14) that demonstrate integration and use of Plaid Link for iOS.
* [Swift+UIKit](LinkDemo-Swift)
* [Swift+SwiftUI](LinkDemo-SwiftUI)
* [Objective-C](LinkDemo-ObjC)

📚 Detailed instructions on how to integrate with Plaid Link for iOS can be found in our main documentation at [plaid.com/docs/link/ios][link-ios-docs]. 

5️⃣ If you're updating from version 4.x to 5.x please read our [migration guide](v5-migration-guide.md).

:warning: All integrations must upgrade to version 4.1.0 of the SDK (released January 2023) by January 1, 2024, to maintain support for Chase OAuth connections.

## About the LinkDemo Xcode projects

Plaid Link can be used for different use cases and the sample applications demonstrate how to use Plaid Link for iOS for each use case.
For clarity between the different use cases, each use case specific example showing how to integrate Plaid Link for iOS is implemented in a Swift extension.

Before building and running the sample application replace any Xcode placeholder strings (like `<#GENERATED_LINK_TOKEN#>`) in the code with the appropriate value so that Plaid Link is configured properly. For convenience the Xcode placeholder strings are also marked as compile-time warnings.

### Steps to acquire a Link token

- [Sign up for a Plaid account](https://dashboard.plaid.com/signup) to get an API key.
- Make a request to [our API](https://plaid.com/docs/quickstart/#introduction) using your API key.

Build and run the demo application to experience the Link flow for yourself.

[link-ios-docs]: https://plaid.com/docs/link/ios
[link-sdk-version]: https://img.shields.io/cocoapods/v/Plaid
[link-sdk-pod-url]: https://cocoapods.org/pods/Plaid
[link-sdk-spi-url]: https://swiftpackageindex.com/plaid/plaid-link-ios
[link-sdk-swift-compat]: https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fplaid%2Fplaid-link-ios%2Fbadge%3Ftype%3Dswift-versions

