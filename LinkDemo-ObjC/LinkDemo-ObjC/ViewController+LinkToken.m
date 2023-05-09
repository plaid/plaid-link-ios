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
        NSLog(@"public-token: %@ metadata: %@", success.publicToken, success.metadata);
    }];
    linkConfiguration.onExit = ^(PLKLinkExit * exit) {
        if (exit.error) {
            NSLog(@"exit with %@\n%@", exit.error, exit.metadata);
        } else {
            NSLog(@"exit with %@", exit.metadata);
        }
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
