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

    // Check that the userActivity.webpageURL matches the oauthRedirectUri that we have 
    // configured in the Plaid dashboard. 
    if (!(handler
        && linkOAuthHandler.oauthRedirectUri
        && [webpageURL.host isEqualToString:linkOAuthHandler.oauthRedirectUri.host]
        && [webpageURL.path isEqualToString:linkOAuthHandler.oauthRedirectUri.path]
          )) {
        return NO;
    }

    NSError* error = [handler continueFromRedirectUri:webpageURL];
    if (error) {
        NSLog(@"Unable to continue from redirect due to: %@", [error localizedDescription]);
    }

    return YES;
}
// <!-- SMARTDOWN_OAUTH_SUPPORT -->

@end
