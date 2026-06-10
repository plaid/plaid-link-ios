# Plaid Integration Migration Guide: LinkKit 4.x to 5.x


## Overview

The upgrade from LinkKit 4.x to 5.x introduces a few breaking changes that you should be aware of. This guide outlines these changes to facilitate a seamless migration process.

### Changes from SDK 4.x to 5.0

#### 1. iOS Version Support
**BREAKING**: Dropped support for iOS 11, 12, & 13.

If your application still supports iOS 11, 12, or 13, you must either continue using SDK 4.x or update your app to support newer iOS versions compatible with SDK 5.x.

#### 2. Authentication Method Changes
**BREAKING**: Removed deprecated support for public key authentication.

If your integration is using public key authentication, it's essential to migrate to Link Tokens. This change does not affect you if you've already made this transition. For detailed instructions, refer to Plaid's [migration guide](https://plaid.com/docs/link-token-migration-guide).

#### 3. OAuth Redirect Handling
**BREAKING**: Removed deprecated `continue(from:)` method (no longer required for OAuth redirects).

If your code calls the deprecated `continue(from:)` method for OAuth redirects, you can safely remove this call. It is no longer needed.

#### 4. Open Options Configuration
**BREAKING**: Removed deprecated OpenOptions parameter from `func open(presentUsing method: PresentationMethod, _ options: OpenOptions)`

If your integration relies on `OpenOptions`, you must now configure these parameters while creating your [Link Tokens](https://plaid.com/docs/api/tokens/). Update your implementation accordingly.

#### 5. Privacy Manifest
In accordance with Apple's updated privacy practices in iOS 17, we have added a Privacy Manifest to LinkKit 5.0 that discloses our approved usage of Apple's UserDefaults API (which falls under the "required reasons API" category). This addition should not impact your apps at this time and will ensure LinkKit does not cause any privacy transparency issues in customer apps in the future. For further information regarding Privacy Manifest files, see [Apple's Documentation](https://developer.apple.com/documentation/bundleresources/privacy_manifest_files). For more information on Apple's required reason APIs, see [Describing use of required reason API](https://developer.apple.com/documentation/bundleresources/privacy_manifest_files/describing_use_of_required_reason_api).
