//
//  AppDelegate+OAuthSupport.m
//  LinkDemo-ObjC
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

#import <LinkKit/LinkKit.h>
#import "ViewController.h"
#import "ViewController+PaymentInitiation.h"
#import "ViewController+OAuthSupport.h"

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
    NSURL* webpageURL = userActivity.webpageURL;

    if (![self.window.rootViewController isKindOfClass:[ViewController class]]) {
        return NO;
    }
    ViewController* viewController = (ViewController*)self.window.rootViewController;

    // Check that the userActivity.webpageURL is the oauthRedirectUri that we have 
    // configured in the Plaid dashboard. 
    if (!(viewController.oauthRedirectUri
        && [webpageURL.host isEqualToString:viewController.oauthRedirectUri.host]
        && [webpageURL.path isEqualToString:viewController.oauthRedirectUri.path]
          )) {
        return NO;
    }

    // Extract oauthStateId from userActivity.webpageURL
    NSString* oauthStateId = PLKOAuthStateIdFromURL(webpageURL);
    if (!oauthStateId) {
        NSLog(@"Unable to extract oauthStateId from URL: %@", webpageURL);
        return NO;
    }

    [viewController presentPlaidLinkWithOAuthSupport:oauthStateId];
    // for the payment initiation flow use:
    //[viewController presentPlaidLinkWithPaymentInitation:oauthStateId];

    return YES;
}
// <!-- SMARTDOWN_OAUTH_SUPPORT -->

@end
