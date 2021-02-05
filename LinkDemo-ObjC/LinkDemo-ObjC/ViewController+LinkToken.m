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
// For details please see https://plaid.com/docs/#create-link-token
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
