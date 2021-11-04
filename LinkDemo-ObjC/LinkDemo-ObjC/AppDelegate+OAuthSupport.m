//
//  AppDelegate+OAuthSupport.m
//  LinkDemo-ObjC
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

#import <LinkKit/LinkKit.h>
#import "ViewController.h"

#import "AppDelegate+OAuthSupport.h"

@implementation AppDelegate (OAuthSupport)

#warning Ensure your oauthRedirectUri is a valid universal link and is configured in the Plaid developer dashboard
#warning Replace YOUR_OAUTH_REDIRECT_URI in the Associated Domains Capability or in the LinkDemo-ObjC.entitlements
#warning Remember to change the application Bundle Identifier to match a URI you have configured for universal links
#warning For more information on configuring your oauthRedirectUri, see https://plaid.com/docs/link/oauth

// MARK: Continue Plaid Link for iOS to complete an OAuth authentication flow
// <!-- SMARTDOWN_OAUTH_SUPPORT -->
- (BOOL)application:(UIApplication *)application
continueUserActivity:(NSUserActivity *)userActivity
 restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    NSURL* webpageURL = userActivity.webpageURL;
    if (!([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb] && webpageURL != nil)) {
        return NO;
    }

    UIViewController* rootViewController = self.window.rootViewController;
    if (![rootViewController conformsToProtocol:@protocol(LinkOAuthHandling)]) {
        return NO;
    }
    id<LinkOAuthHandling> linkOAuthHandler = (id<LinkOAuthHandling>)rootViewController;
    id<PLKHandler> handler = linkOAuthHandler.linkHandler;

    // The Plaid Link SDK ignores unexpected URLs passed to `- (void)continueWithRedirectUri:(NSURL *)redirectUri`
    // as per Apple’s recommendations, so there is no need to filter out unrelated URLs.
    // Doing so may prevent a valid URL from being passed to `continue(from:)` and
    // OAuth may not continue as expected.
    // For details see https://plaid.com/docs/link/ios/#set-up-universal-links
    if (!handler) {
        return NO;
    }

    // Continue the Link flow
    [handler continueWithRedirectUri:webpageURL];
    return YES;
}
// <!-- SMARTDOWN_OAUTH_SUPPORT -->

@end
