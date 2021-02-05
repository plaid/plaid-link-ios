//
//  ViewController+PublicKey.m
//  LinkDemo-ObjC
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

#import <LinkKit/LinkKit.h>

#import "ViewController+PublicKey.h"

@implementation ViewController (PublicKey)

// MARK: Start Plaid Link using a public key for compatibility with previous version of LinkKit
// For details please see https://plaid.com/docs/
- (void)presentPlaidLinkUsingPublicKey {

    #warning Replace <#PUBLIC_KEY#> below with your public_key

     PLKLinkPublicKeyConfigurationToken* token = [PLKLinkPublicKeyConfigurationToken createWithPublicKey:@"<#PUBLIC_KEY#>"];
    // For payment initiation Link flows replace the line above with the following line:
    //PLKLinkPublicKeyConfigurationToken* token = [PLKLinkPublicKeyConfigurationToken createWithPaymentToken:@"<#PAYMENT_TOKEN#>" publicKey:@"<#PUBLIC_KEY#>"];
    PLKLinkPublicKeyConfiguration *linkConfiguration = [[PLKLinkPublicKeyConfiguration alloc] initWithClientName:@"<#APPLICATION_NAME#>"
                                                                                                     environment:<#PLKEnvironmentSandbox#>
                                                                                                        products:@[@(<#PLKProductTransactions#>)]
                                                                                                    language:@"en"
                                                                                                       token:token
                                                                                                countryCodes:@[@"US"]
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

    // To enable OAuth flows set the oauthConfiguration as follows:
    linkConfiguration.oauthConfiguration = [[PLKOAuthNonceConfiguration alloc] initWithNonce:self.oauthNonce
                                                                                 redirectUri:self.oauthRedirectUri];

    NSError *createError = nil;
    id<PLKHandler> handler = [PLKPlaid createWithLinkPublicKeyConfiguration:linkConfiguration
                                                                      error:&createError];
    if (handler) {
        self.linkHandler = handler;
        [handler openWithContextViewController:self];
    } else if (createError) {
        NSLog(@"Unable to create PLKHandler due to: %@", createError);
    }

}

@end
