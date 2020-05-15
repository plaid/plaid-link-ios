//
//  AppDelegate+OAuthSupport.m
//  LinkDemo-ObjC
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

#import "AppDelegate+OAuthSupport.h"

@implementation AppDelegate (OAuthSupport)

// MARK: Re-initialize Plaid Link for iOS to complete OAuth authentication flow
// <!-- SMARTDOWN_OAUTH_SUPPORT -->
- (BOOL)application:(UIApplication *)application
continueUserActivity:(NSUserActivity *)userActivity
 restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    if (![userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        return NO;
    }

    #warning Replace the example oauthRedirectUri below with your oauthRedirectUri, which should be configured as a universal link and must be whitelisted through Plaid's developer dashboard
    NSURL* oauthRedirectUri = [NSURL URLWithString:@"https://example.net/plaid-oauth"];
    // Perform checks that work best for your oauthRedirectUri to determine whether the userActivity is related to Plaid Link OAuth
    if ([[userActivity.webpageURL host] isEqualToString:[oauthRedirectUri host]]
        && [[userActivity.webpageURL path] isEqualToString:[oauthRedirectUri path]]) {
        // Pass the userActivity.webpageURL to your code responsible for re-initalizing Plaid Link for iOS
    }

    return YES;
}
// <!-- SMARTDOWN_OAUTH_SUPPORT -->

@end
