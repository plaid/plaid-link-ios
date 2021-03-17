# RELEASES

## LinkKit 2.1.0 — 2021-03-16
### Requirements

| Name | Version |
|------|---------|
| Xcode | >= 11.5 |
| iOS | >= 11.0 |

### Changes

- Improve performance of `LinkKit.Handler.open(...)`
- Replace `continueFrom(redirectUri:)` with `continue(from:)`, and deprecate the former
- Fix issue where the accounts array could sometimes be missing accounts
- Add ability to control the dismissal of Link


## LinkKit 2.0.11 — 2021-02-16
### Requirements

| Name | Version |
|------|---------|
| Xcode | >= 11.5 |
| iOS | >= 11.0 |

### Changes

- Fix spelling of PLKSuccessMetadata.institution


## LinkKit 2.0.10 — 2021-02-05
### Requirements

| Name | Version |
|------|---------|
| Xcode | >= 11.5 |
| iOS | >= 11.0 |

### Changes

- Fix the Objective-C -> Swift bridge's handling of PLKLinkPublicKeyConfiguration


## LinkKit 2.0.9 — 2020-12-15
### Requirements

| Name | Version |
|------|---------|
| Xcode | >= 11.5 |
| iOS | >= 11.0 |

### Changes

- Rename static SwiftProto dependency to avoid conflicting symbols at run time


## LinkKit 2.0.8 — 2020-11-18
### Requirements

| Name | Version |
|------|---------|
| Xcode | >= 11.5 |
| iOS | >= 11.0 |

### Changes

- Add deposit switch product


## LinkKit 2.0.7 — 2020-11-17
### Requirements

| Name | Version |
|------|---------|
| Xcode | >= 11.5 |
| iOS | >= 11.0 |

### Changes

- Provide full raw json error metadata in onExit


## LinkKit 2.0.6 — 2020-11-04
### Requirements

| Name | Version |
|------|---------|
| Xcode | >= 11.5 |
| iOS | >= 11.0 |

### Changes

- Correctly handle redirect URIs with no path component
- Improve error messaging on configuration validation


## LinkKit 2.0.5 — 2020-10-20
### Requirements

| Name | Version |
|------|---------|
| Xcode | >= 11.5 |
| iOS | >= 11.0 |

### Changes

- Correctly set errorCode in metadata
- Correctly set accountMask in metadata


## LinkKit 2.0.4 — 2020-10-19
### Requirements

| Name | Version |
|------|---------|
| Xcode | >= 11.5 |
| iOS | >= 11.0 |

### Changes

- Fix resetting the password from the credential pane
- Fix links in privacy policy


## LinkKit 2.0.3 — 2020-10-08
### Requirements

| Name | Version |
|------|---------|
| Xcode | >= 11.5 |
| iOS | >= 11.0 |

### Changes

- Fix missing symbols error when using the Objective-C bridge, e.g. through React Native.
- Correctly sent `OPEN` event. Due to an internal issue the `HANDOFF` event was sent instead.


## LinkKit 2.0.2 — 2020-10-07
### :warning: Known Issues


:information_source: The following issues exist in this version and will be addressed with the next release.

- When integrating with using React-Native Release builds will show missing symbols.

### Requirements

| Name | Version |
|------|---------|
| Xcode | >= 11.5 |
| iOS | >= 11.0 |


## LinkKit 2.0.1 — 2020-10-01
### :warning: Known Issues


:information_source: The following issues exist in this version and will be addressed with the next release.

- Resetting the password from the credential pane is currently non-functional.

- Link token based flows that do not have the `redirect_uri` set correctly upon creation will not redirect back to Link to complete the flow.

### Requirements

| Name | Version |
|------|---------|
| Xcode | >= 11.5 |
| iOS | >= 11.0 |

### Notes


For details about migrating from LinkKit 1.x to 2.x please see [the migration guide](https://plaid.com/docs/link/ios/ios-v2-migration/).


## LinkKit 2.0.0 — 2020-09-24
### :warning: Known Issues


:information_source: Unfortunately a wrong LinkKit binary was released as 2.0.0, please use version 2.0.1 as the following issues exist in this version and will be addressed with the next release.

- LinkKit may crash in certain scenarios like link-token based payment initiation.

### Notes


LinkKit 2.x marks the next generation of the Plaid Link for iOS SDK. It brings support for new features such as Link token based Payment Initation and unifies the Plaid Link mobile APIs across platforms while taking advantage of features available to iOS 11 and up.

Please see known issues below and use version 2.0.6 instead.


## LinkKit 1.1.39 — 2020-12-07
### Changes

- Fix issue with null account data in handoff metadata when linking with account numbers
- Fix issue with null error info and `request_id` in handoff metadata


## LinkKit 1.1.38 — 2020-11-13
### Changes

- Fix issue with null account_id in returned metadata


## LinkKit 1.1.37 — 2020-09-24
### Changes

- Fix issue with OAuth redirect during the patch flow


## LinkKit 1.1.36 — 2020-09-04
### Changes

- Bug fix to allow using institutionId and oauth together when initializing Link with a Link token.


## LinkKit 1.1.35 — 2020-08-21
### Changes

- Bug fixes and stability.


## LinkKit 1.1.34 — 2020-07-17
### Additions

- Add events for OAuth flow

### Changes

- Update language used in the manual microdeposit flow
- Fix issue with the OAuth flow when re-using the same PLKConfiguration instance
- Improve Link Token flow


## LinkKit 1.1.33 — 2020-06-15
### Changes

- Improve Plaid Link flow event reporting for certain flows
- Fix issue with institution search when using account filtering and only the auth product.
- Fix crash when some users are presented with a recaptcha challenge
- Fix issue with copy customizations for non-English languages


## LinkKit 1.1.32 — 2020-05-18
### Changes

- Fix a critical issue for certain rare use cases


## LinkKit 1.1.31 — 2020-05-15
### Additions

- Added a name pane after the introductory pane to prompt the user to enter their name in the manual microdeposit flow.
- Added a class type pane after the name pane for the user to select the account class type in the manual microdeposit flow.
- Added an authorization pane at the end of the manual microdeposits flow to present the legal policy for crediting and debiting an end-user's account asking to authorize these credits and debits.

### Changes

- Fix crash when the `UINavigationController.topViewController` was accessed from a background thread.
- Out-of-process webviews now open to https://secure.plaid.com rather than https://cdn.plaid.com.
- Open institution's account setup url when necessary.
- Updated the automated microdeposits workflow to now include the name pane and class type pane.
- Manual microdeposits no longer require the user legal name or email address from the end-user.

### Removals

- Removed the legal policy from the microdeposits introductory pane.


## LinkKit 1.1.30 — 2020-04-21
### Changes

- Bug fixes and stability.
- Additional lines of text are now allowed for customized empty search help text.


## LinkKit 1.1.29 — 2020-03-26
### Changes

- Fixed crash in some cases where a client name was not specified in the configuration.
- The select account pane no longer erroneously shows up in credential update flows.


## LinkKit 1.1.28 — 2020-03-19
### Changes

- Fix for some institutions not showing up in non-english builds.
- Updated links to privacy policies.
- New text clarifying EU app-to-app flows.


## LinkKit 1.1.27 — 2020-02-12
### Additions

- When configured with a non-production environment Plaid Link for iOS will now show an alert and a log message when the SDK is considered to be outdated.

### Changes

- Fix cases where certain microdeposits would fail to verify.


## LinkKit 1.1.26 — 2020-01-15
### Additions

- Added CONSENT as a possible `view_name` metadata value for the `OPEN` event. Details here https://plaid.com/docs/#metadata-view_name

### Changes

- Fix issue with manual microdeposits, where the flow failed when users went back and changed the amount entered first
- Fix account select UI for regular flow regression, where the available account options were not properly visible
- Fix issue with OAuth flow when invoked using custom initializer, where the LinkKit would crash when federated authentication was cancelled and retried
- Fix issue where the OPEN event would not be sent in some cases.
- Added "warning" and "force" Alert for deprecated SDK versions. Also added a warning "log" for deprecation notices.
- Fix issue where the OPEN event would not be sent in some cases.


## LinkKit 1.1.25 — 2019-12-04
### :warning: Known Issues


:information_source: As of this version LinkKit requires Xcode 11

### Additions

- Better user messaging for financial institutions experiencing connectivity issues.

### Changes

- Fix account select UI for Open Banking flows, where the available account options were not properly visible
- Fix issues with account linking after recaptcha validation


## LinkKit 1.1.24 — 2019-10-23
### Additions

- Add external events `SUBMIT_CREDENTIALS` and `SUBMIT_MFA` (for details see https://plaid.com/docs/#onevent-callback)
- Add balance localization support for the Select Account pane.

### Changes

- Fix issue with account linking in Europe after recaptcha validation
- Fixes crash in some cases when the back button is tapped in quick succession.
- Override LinkKit user interface style with light style until support dark mode is complete


## LinkKit 1.1.23 — 2019-09-12
### Changes

- Fix AppStore validation errors by exchanging use of deprecated UIWebView with WKWebView in third-party password manager integration code


## LinkKit 1.1.22 — 2019-08-28
### :warning: Known Issues


:information_source: The following issues currently exist in LinkKit and will be addressed with the next release planned for the mid-September 2019

- Applications integrating LinkKit may get rejected by the App Store due to use of deprecated API (`UIWebView`) in third-party password manager integration code

### Changes

- Improve account link flow for non-US institutions


## LinkKit 1.1.21 — 2019-07-22
### Changes

- Fix crash during account select flow


## LinkKit 1.1.20 — 2019-06-25
### Changes

- Fix displaying external links from within the privacy policy pane


## LinkKit 1.1.19 — 2019-05-29
### Additions

- Add new optional configuration property `language`, to specify the language in which the UI will be displayed.

### Changes

- Fix issue with `countryCodes` when using shared configuration via Info.plist
- Improve institution search results when searching for institutions supporting transactions


## LinkKit 1.1.18 — 2019-04-15
### Changes

- Fix issue where the end-user was not taken back to enter their credentials when providing an invalid username during the patch flow.
- Disable pinch to zoom when viewing the privacy policy.

### Removals

- Support for APIv1 is now officially deprecated and unavailable. When Linkkit is configured with APIv1 it returns an error.


## LinkKit 1.1.17 — 2019-03-15
### Additions

- Add new optional configuration property `countryCodes` to limit selectable institutions and institution search results to institutions available in the given countries

### Changes

- Fix issue with automated microdeposits, which were only enabled when the configured product was `auth`
- Fix issue where institutions were displayed on the institutionSelect- and institutionSearchPane that did not support the configured products
- Allow opt-in of account linking via microdeposits by configuring `userLegalName` and `userEmailAddress`; before public keys enabled for the latest auth features were required to provide `userLegalName` and `userEmailAddress`


## LinkKit 1.1.16 — 2019-02-27
### Changes

- Fix issue with account verification via manual microdeposits
- Fix issue with multiple institution logos displayed when blurring views with sensitive information once the app switcher is activated


## LinkKit 1.1.15 — 2019-02-05
### :warning: Known Issues


:information_source: The following issues currently exist in LinkKit and will be addressed with the next release planned for the end of February 2019

- When verifying an account via manual microdeposits Plaid Link for iOS stalls after confirming the account number

### Additions

- Add support for the latest [Auth features](https://blog.plaid.com/new-auth). Read the [blog post](https://blog.plaid.com/new-auth), and reach out to integrations@plaid.com to enable your account and begin testing
- Add haptic feedback for selection changes and validation errors
- Add account number confirmation step when asking the end-user to enter their account and routing number
- Add retry for account routing number entry

### Changes

- Improve account routing number messaging on validation errors
- Improve VoiceOver support
- Fix unknown account subtype in metadata in the `PLKPlaidLinkViewDelegate` calls ([#294](https://github.com/plaid/link/issues/294))
- Fix multiple account selection indicator
- Fix grammar and spelling mistakes in header comments


## LinkKit 1.1.14 — 2018-12-17
### Changes

- Fix access for optional `webhook` and `clientName` configuration properties ([#284](https://github.com/plaid/link/issues/284))
- Improve compatibility with iOS 8


## LinkKit 1.1.13 — 2018-10-30
### Changes

- Improve VoiceOver accessibility by focussing on primary element when views appear, setting more specific accessibility labels, hints, and traits for existing elements, and hiding irrelevant elements.
- Improve handling of blur effect on application suspend / resume when other modal view controllers as for the Reset password flow are presented / dismissed.
- Include all available accounts metadata in the `linkViewController:didSucceedWithPublicToken:metadata` delegate calls ([#239](https://github.com/plaid/link/issues/239))


## LinkKit 1.1.12 — 2018-09-17
### :warning: Known Issues


:information_source: The following issues currently exist in LinkKit and will be addressed with the next release planned for the middle of October 2018.

- If the Reset password button on the credentials pane is tapped at the same time that the application goes into the background, the blur effect, which hides sensitive information from views, is not removed once the application becomes active again.

### Additions

- Add support for iOS 12 security code auto-fill

### Changes

- Fix issue where customizing the copy of button on the consent pane did not update the copy of the text below accordingly
- The metadata in the `linkViewController:didHandleEvent:metadata` callback method now includes data of the selected institution in every event if present
- Allow the `dismissViewControllerAnimated:completion:` to be called on the `PLKPlaidLinkViewController` object (addresses [#254](https://github.com/plaid/link/issues/254)). Yet we recommend calling `dismissViewControllerAnimated:completion:` on the object that presented the `PLKPlaidLinkViewController` or on the `presentingViewController` property of the `linkViewController` object passed to the `PLKPlaidLinkViewDelegate` methods.


## LinkKit 1.1.11 — 2018-08-15
### :warning: Known Issues


:information_source: The following issues currently exist in LinkKit and will be addressed with the next release planned for the middle of September 2018.

- When customizing the copy of button on the consent pane the copy of the text below is not updated accordingly

### Additions

- Add support for customization of the headline, submit button, and highlight color on the initial consentPane
- Add support for alphanumeric MFA codes
- Add support for react native
- Remove sensitive information from views before moving to the background

### Changes

- Fix issue where the `Restart` action on the result pane exited the flow instead of going back to the institution select pane. (addresses [#256](https://github.com/plaid/link/issues/256)).
- Fix issue where LinkKit can crash during device based mfa (addresses [#252](https://github.com/plaid/link/issues/252)).
- Improve animation of blur effect during application suspend / resume


## LinkKit 1.1.10 — 2018-07-02
### :warning: Known Issues


:information_source: The following issues currently exist in LinkKit 1.1.10 and older and are fixed in LinkKit [1.1.11](https://github.com/plaid/link/releases/ios%2F1.1.11)

- LinkKit can crash during device based mfa. For further details see [#252](https://github.com/plaid/link/issues/252).

### Additions

- Plaid Link for iOS now asks end users for their consent to Plaid's privacy policy

### Changes

- Fix issue that could crash LinkKit in sandbox mode when viewing the development mode information
- Fix issue where the last active pane instead of the institution select pane would be shown when the same instance of `PLKPlaidLinkViewController` was re-used
- Present institution website after "Unlock account" is tapped on the result pane for a locked item


## LinkKit 1.1.9 — 2018-05-17
### Changes

- Improve compatability with iOS 8
- Fix issue where the search pane would be shown instead of the institution select pane when going back from the credentials pane
- Visual user interface modification to create more similarity between Plaid Link for [web](https://plaid.com/docs/quickstart/) and iOS


## LinkKit 1.1.8 — 2018-04-16
### Changes

- Fix issue with credentials validation that requires a PIN code when using a third-party password manager
- Fix status bar style for applications that disable view controller-based status bar appearance
- All delegate methods of the `PLKPlaidLinkViewDelegate` protocol are now called on the main thread
- Visual user interface modification to create more similarity between Plaid Link for [web](https://plaid.com/docs/quickstart/) and iOS
- Move the third-party password manager button from the username field to the password field

### Removals

- Remove back bar button item on credential pane when retrying credentials using custom initializer flow


## LinkKit 1.1.7 — 2018-03-20
### Additions

- Add customizable exit button below search results (addresses [#228](https://github.com/plaid/link/issues/228)).
- For the select account flow the account mask, type, and subtype are now returned in the metadata of the `linkViewController:didSucceedWithPublicToken:metadata` handler.

### Changes

- Deprecate `kPLKMetadataInstitutionType` constant in favor of `kPLKMetadataType` and `kPLKMetadataInstitution_Type` in favor of `kPLKAPIv1MetadataInstitutionType`

### Removals

- Remove the Success view when Select Accout is enabled in the Plaid Dashboard, to match the behaviour in Link Web


## LinkKit 1.1.6 — 2018-03-01
### Additions

- Add warning log message when third-party password manager support is not setup properly

### Changes

- Values for `PLKPLAIDLINK_DIAGNOSTICS` log level to accommodate for newly added warning log level
- Fix sandbox only crash when submitting credentials after having viewed the development mode info view ([#234](https://github.com/plaid/link/issues/234))
- Fix crash when customized institution select pane contained certain institutions ([#235](https://github.com/plaid/link/issues/235))


## LinkKit 1.1.5 — 2018-02-15
### :warning: Known Issues


:information_source: The following issues currently exist in LinkKit and will be addressed with the next release planned for beginning of March 2018.

- LinkKit can crash when the Institution Select pane has been customized with certain longtail institutions with long names. Unfortunately this is a production issue and we recommend removing these institutions from the customized Institution Select pane until the next version of LinkKit has been integrated in your application. For further details see [`plaid/link#235`](https://github.com/plaid/link/issues/235)

- LinkKit crashes when using custom initializers and navigating back from the development mode info pane to the credentials pane and then submitting credentials. This is a sandbox / development only related issue and cannot occur in production context where the development mode info page is not available. For further details see [`plaid/link#234`](https://github.com/plaid/link/issues/234)

### Additions

- Improve error handling when initializing LinkKit
- When retrying a login the previously entered username will remain in the username input field.

### Changes

- Fix bug where password manager action sheet could be invoked even though password manager button in credential field was invisible
- Visual user interface modification to create more similarity between Plaid Link for [web](https://plaid.com/docs/quickstart/) and iOS.


## LinkKit 1.1.4 — 2018-01-11
### Additions

- Add support for password managers to allow users to use application extensions provided by password manager applications to fill in the account credentials. Please note that the application integrating LinkKit must add `org-appextension-feature-password-management` to `LSApplicationQueriesSchemes` in its `Info.plist`

### Changes

- Visual user interface modification to create more similarity between Plaid Link for [web](https://plaid.com/docs/quickstart/) and iOS.
- Fix issue that prevented bank accounts to be successfully linked when using non-sandbox keys in the Tartan environment with the legacy API.


## LinkKit 1.1.3 — 2017-12-11
### Additions

- Allow customization of "top" institutions if the corresponding option is enabled in the [Dashboard](https://dashboard.plaid.com/link/institution-select)

### Changes

- Add consistency to visual appearance of buttons in highlighted state


## LinkKit 1.1.2 — 2017-11-02
### Changes

- Fix single account pre-selection, where `didExitWithError:metadata:` was called instead of `didSucceedWithPublicToken:metadata:` when the pre-selected was not tapped despite of already being selected
- Add support for alphanumeric mfa codes
- Deprecate `selectAccount` parameter on `PLKConfiguration` in favour of the Select Account view customization available from the Dashboard https://dashboard.plaid.com/link/account-select or the `kPLKCustomizationEnabledKey` customization for `kPLKAccountSelectPaneKey` when using `PLKConfiguration.customizeWithDictionary:`. The `selectAccount` parameter will be removed in a future release.


## LinkKit 1.1.1 — 2017-10-23
### Changes

- Fix Apple review rejections of applications using Plaid Link iOS due to LinkKit.framework containing GCC and LLVM Instrumentation (see [Technical Q&A QA1964](https://developer.apple.com/library/content/qa/qa1964/_index.html)).
- Fix view controller animation transition when the `backBarButtonItem` was tapped.


## LinkKit 1.1.0 — 2017-10-02
### Additions

- Add support for iPhone X
- Allow selecting multiple accounts if the corresponding option is enabled in the [Dashboard](https://dashboard.plaid.com/)
- Add `kPLKMetadataAccountsKey` to `metadata` returned in the `PLKPlaidLinkViewDelegate` methods
- Add `kPLKMetadataLinkSessionIdKey` to `metadata` returned in the `PLKPlaidLinkViewDelegate` methods
- Add APIv2 error codes to the `NSError.userInfo` passed to the `linkViewController:didExitWithError:metadata:` `PLKPlaidLinkViewDelegate` method ([#208](https://github.com/plaid/link/issues/208))
- Extend `PLKPlaidLinkViewDelegate` protocol with `linkViewController:didHandleEvent:metadata`, see https://www.plaid.com/docs/api/#onevent-callback for details.

### Changes

- Automatically select an account if there is only one available
- Replace `kPLKMetadataRequestIdKey` with `kPLKMetadataLinkRequestIdKey` in `metadata` returned in the `PLKPlaidLinkViewDelegate` methods when using APIv1

### Removals

- Remove right `×` exit button from navigation bar on connected pane and select account pane


## LinkKit 1.0.10 — 2017-09-04
### Changes

- Fix issue where an empty select account pane was shown instead of an error message stating that no eligible ACH accounts were available


## LinkKit 1.0.9 — 2017-08-25
### Changes

- Improve search results when using APIv1


## LinkKit 1.0.8 — 2017-08-18
### Additions

- Add support for three or more MFA selection options
- Tapping on sample credentials in the development mode view copies them to the pasteboard

### Changes

- Immediately notify users when attempting to patch an item without any errors
- Correctly pass errors to the `PLKPlaidLinkViewDelegate` after recaptcha validation ([#191](https://github.com/plaid/link/issues/191))
- Enable scrolling for long questions on MFA view.
- Correctly set `metadata.status` to `kPLKStatusInstitutionNotFound` when the user tapped the exit button shown when the institution search yielded no results ([#190](https://github.com/plaid/link/issues/190))
- Use application name as set in Info.plist (`kCFBundleNameKey`) when `clientName` is not configured [#189](https://github.com/plaid/link/issues/189))
- Correctly set returned institution metadata to `null` when Link exits from institution selection [#185](https://github.com/plaid/link/issues/185#issuecomment-319513872))
- Improve animation when dismissing `PLKPlaidLinkViewController` with a subview being the `firstResponder`
- Improve accessibility on back button
- Prefix method names on UIKit and Foundation categories with `plk_` to prevent method name clashes ([#195](https://github.com/plaid/link/issues/195))


## LinkKit 1.0.7 — 2017-07-26
### Changes

- Fix interactive area of exit button ([#185](https://github.com/plaid/link/issues/185))
- Fix issue where the logo for certain institutions was not shown in the search results


## LinkKit 1.0.6 — 2017-07-11
### Additions

- Add [copy customization](https://blog.plaid.com/link-copy-customization/) which allows to change the text of certain user interface elements in the Link flow
- Add exit button when searching for an institution yielded no results so people can directly exit out of Link iOS
- Add time-out message when searching for an institution takes too long

### Changes

- Fix issue with configured webhook when using APIv2


## LinkKit 1.0.5 — 2017-06-12
### Additions

- Add phone MFA type

### Changes

- Fix APIv1 select account flow in which users were incorrectly asked to select their account ([#169](https://github.com/plaid/link/issues/169))
- Gracefully handle Link internal issues that previously could lead to crashes ([#169](https://github.com/plaid/link/issues/169))
- Return `institution_id` in metadata when using APIv2 ([#172](https://github.com/plaid/link/issues/172))
- Show institution name in title bar ([#173](https://github.com/plaid/link/issues/173))
- Improve iOS 9 compatibility ([#169](https://github.com/plaid/link/issues/169))
- Show placeholders in the select account view when additional account information is unavailable
- Return to the institution select view when an instituion's mfa method is not supported
- Improve positioning of institution logo


## LinkKit 1.0.4 — 2017-04-14
### Additions

- [`LICENSE`](LICENSE)

### Changes

- Call exit handler `linkViewController:didExitWithError:metadata:` instead of success handler `linkViewController:didSucceedWithPublicToken:metadata` when exiting update mode from the credentials view ([#148](https://github.com/plaid/link/issues/148)).
- Correct header documentation regarding pre-selecting an institution; `initWithInstitution:delegate:` and `initWithInstitution:configuration:delegate` ([#154](https://github.com/plaid/link/issues/154)).
- Show alphanumeric keyboard for PIN entry when in development mode.
- Improve wording of `NSInvalidArgumentException` which is thrown when an `env` incompatible with the `apiVersion` is configured (see [README.md](README.md#environment--api-version-compatibility) for details).


## LinkKit 1.0.3 — 2017-03-31
### Additions

- Institution `huntington`

### Changes

- Fix issue with credentials authentication when an institution requires a PIN
- Use default api version when none specified
- Fix compiler warnings in LinkDemo-Swift project


## LinkKit 1.0.2 — 2017-03-17
### Additions

- Institutions `citizens` and `regions`
- Sandbox environment for APIv2
- Tartan environment for APIv1
- CHANGELOG.md

### Changes

- Update documentation regarding environments (see [README.md](README.md#environment--api-version-compatibility) for details)
- Update development mode information regarding selections MFA
- `LINK_ENV` build settings in Xcode demo projects
- Redesign demo application welcome view
- User interface font size

### Removals

- Testing environment for APIv1 and APIv2
- Development environment for APIv1 (NOTE: configuring the `Development` environment for `APIv1` will result in an exception)


## LinkKit 1.0.1 — 2017-03-10
### Changes

- Development mode information


## LinkKit 1.0.0 — 2017-03-09
### Additions

- LinkKit.framework
- Xcode demo projects ([LinkDemo-ObjC](LinkDemo-ObjC), [LinkDemo-Swift](LinkDemo-Swift), [LinkDemo-Swift2](LinkDemo-Swift2))
 
