//
//  ViewController+LinkToken.m
//  LinkDemo-ObjC
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

#import <LinkKit/LinkKit.h>

#import "ViewController+LinkToken.h"

@implementation ViewController (LinkToken)

// MARK: Start Plaid Link using a Link token
// Steps to acquire a Link Token:
//
// 1. Sign up for a Plaid account to get an API key.
//      Ref - https://dashboard.plaid.com/signup
// 2. Make a request to our API using your API key.
//      Ref - https://plaid.com/docs/quickstart/#introduction
//      Ref - https://plaid.com/docs/api/tokens/#linktokencreate
- (void)presentPlaidLinkUsingLinkToken {

    #warning Replace <#GENERATED_LINK_TOKEN#> below with your link_token

    PLKLinkTokenConfiguration* linkConfiguration = [PLKLinkTokenConfiguration createWithToken:@"<#GENERATED_LINK_TOKEN#>"
                                                                                    onSuccess:^(PLKLinkSuccess *success) {

        // Closure is called when a user successfully links an Item. It should take a single LinkSuccess argument,
        // containing the publicToken String and a metadata of type SuccessMetadata.
        // Ref - https://plaid.com/docs/link/ios/#onsuccess
        NSLog(@"public-token: %@ metadata: %@", success.publicToken, success.metadata);
    }];

    // Optional closure is called when a user exits Link without successfully linking an Item,
    // or when an error occurs during Link initialization. It should take a single LinkExit argument,
    // containing an optional error and a metadata of type ExitMetadata.
    // Ref - https://plaid.com/docs/link/ios/#onexit
    linkConfiguration.onExit = ^(PLKLinkExit * exit) {
        if (exit.error) {
            NSLog(@"exit with %@\n%@", exit.error, exit.metadata);
        } else {
            NSLog(@"exit with %@", exit.metadata);
        }
    };

    // Optional closure is called when certain events in the Plaid Link flow have occurred, for example,
    // when the user selected an institution. This enables your application to gain further insight into
    // what is going on as the user goes through the Plaid Link flow.
    // Ref - https://plaid.com/docs/link/ios/#onevent
    linkConfiguration.onEvent = ^(PLKLinkEvent * event) {
        NSLog(@"Link event %@", event);
    };

    NSError *createError = nil;
    id<PLKHandler> handler = [PLKPlaid createWithLinkTokenConfiguration:linkConfiguration
                                                                  error:&createError];
    if (handler) {
        self.linkHandler = handler;
        [handler openWithContextViewController:self];
    } else if (createError) {
        NSLog(@"Unable to create PLKHandler due to: %@", createError);
    }
}

@end
