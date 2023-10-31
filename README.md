# Plaid Link for iOS [![version][link-sdk-version]][link-sdk-pod-url] [![swift compatibility][link-sdk-swift-compat]][link-sdk-spi-url]

📱 This repository contains multiple sample applications (requiring Xcode 11) that demonstrate integration and use of Plaid Link for iOS.
* [Swift+UIKit](LinkDemo-Swift)
* [Swift+SwiftUI](LinkDemo-SwiftUI)
* [Objective-C](LinkDemo-ObjC)

📚 Detailed instructions on how to integrate with Plaid Link for iOS can be found in our main documentation at [plaid.com/docs/link/ios][link-ios-docs]. 

1️⃣  The previous major version of LinkKit can be found on the [main-v1][link-main-v1] branch.

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
[link-1-2-migration]: https://plaid.com/docs/link/ios/ios-v2-migration
[link-main-v1]: https://github.com/plaid/plaid-link-ios/tree/main-v1
