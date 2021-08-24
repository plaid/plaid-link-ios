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
                                                                                                     environment:/*@START_MENU_TOKEN@*/PLKEnvironmentSandbox/*[["PLKEnvironmentSandbox","PLKEnvironmentDevelopment","PLKEnvironmentProduction"],[[[-1,0],[-1,1],[-1,2]]],[0]]@END_MENU_TOKEN@*/
                                                                                                        products:@[@(/*@START_MENU_TOKEN@*/PLKProductTransactions/*[["PLKProductTransactions","PLKProductAuth","PLKProductIdentity","PLKProductIncome","PLKProductPaymentInitation","PLKProductAssets","PLKProductInvestments","PLKProductLiabilities","PLKProductLiabilitesReport"],[[[-1,0],[-1,1],[-1,2],[-1,3],[-1,4],[-1,5],[-1,6],[-1,7],[-1,8]]],[0]]@END_MENU_TOKEN@*/)]
                                                                                                        language:/*@START_MENU_TOKEN@*/@"en"/*[["@\"en\"","@\"es\"","@\"fr\"","@\"nl\""],[[[-1,0],[-1,1],[-1,2],[-1,3]]],[0]]@END_MENU_TOKEN@*/
                                                                                                           token:token
                                                                                                    countryCodes:@[/*@START_MENU_TOKEN@*/@"US"/*[["@\"US\"","@\"CA\"","@\"GB\"","@\"NL\""],[[[-1,0],[-1,1],[-1,2],[-1,3]]],[0]]@END_MENU_TOKEN@*/]
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
