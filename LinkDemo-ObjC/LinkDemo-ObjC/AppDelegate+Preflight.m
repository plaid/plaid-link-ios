//
//  AppDelegate+Preflight.m
//  LinkDemo-ObjC
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

#import <LinkKit/LinkKit.h>

#import "AppDelegate+Preflight.h"

@implementation AppDelegate (Preflight)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // NOTE: Below there are Plaid setup examples for a preflight check, yet with recent changes to
    // Plaid's API and LinkKit this is no longer a necessity.
//    [self setupPlaidLinkWithCustomConfiguration];
//    [self setupPlaidLinkWithSharedConfiguration];
    return YES;
}

// MARK: Plaid Link setup with shared configuration from Info.plist
- (void)setupPlaidLinkWithSharedConfiguration {

    // <!-- SMARTDOWN_SETUP_SHARED -->
    // With shared configuration from Info.plist
    [PLKPlaidLink setupWithSharedConfiguration:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            // Handle success here, e.g. by posting a notification
            NSLog(@"Plaid Link setup was successful");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PLDPlaidLinkSetupFinished" object:self];
        }
        else {
            NSLog(@"Unable to setup Plaid Link due to: %@", [error localizedDescription]);
        }
    }];
    // <!-- SMARTDOWN_SETUP_SHARED -->

}

// MARK: Plaid Link setup with custom configuration
- (void)setupPlaidLinkWithCustomConfiguration {

    #warning Replace <#YOUR_PLAID_PUBLIC_KEY#> below with your public_key
    // <!-- SMARTDOWN_SETUP_CUSTOM -->
    // With custom configuration
    PLKConfiguration* linkConfiguration;
    @try {
        linkConfiguration = [[PLKConfiguration alloc] initWithKey:@"<#YOUR_PLAID_PUBLIC_KEY#>"
                                                              env:PLKEnvironmentDevelopment
                                                          product:PLKProductAuth];
        linkConfiguration.clientName = @"Link Demo";
        [PLKPlaidLink setupWithConfiguration:linkConfiguration completion:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                // Handle success here, e.g. by posting a notification
                NSLog(@"Plaid Link setup was successful");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PLDPlaidLinkSetupFinished" object:self];
            }
            else {
                NSLog(@"Unable to setup Plaid Link due to: %@", [error localizedDescription]);
            }
        }];
    } @catch (NSException *exception) {
        NSLog(@"Invalid configuration: %@", exception);
    }
    // <!-- SMARTDOWN_SETUP_CUSTOM -->

}

@end
