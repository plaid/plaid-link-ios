//
//  ViewController+OAuthSupport.m
//  LinkDemo-ObjC
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

#import <LinkKit/LinkKit.h>

#import "ViewController+OAuthSupport.h"
#import "ViewController+PLKPlaidLinkViewDelegate.h"

@implementation ViewController (OAuthSupport)

// MARK: Using OAuth in Plaid Link
// For details about OAuth support please see https://plaid.com/docs/link/ios/#oauth-support and https://plaid.com/docs/#oauth
- (void)presentPlaidLinkWithOAuthSupport:(NSString* _Nullable)oauthStateId {

    #warning Replace <#YOUR_PLAID_PUBLIC_KEY#> and <#COUNTRY_CODE#> below with your public_key and supported country codes
    // <!-- SMARTDOWN_PRESENT_OAUTH -->
    // With custom configuration using OAuth
    @try {
        // Plaid Link OAuth works in two steps, the first step is to initiate the OAuth authentication flow,
        // the second to complete the OAuth authentication flow. On each step Plaid Link must be initialized
        // as follows:

        if ([self.presentedViewController isKindOfClass:[PLKPlaidLinkViewController class]]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }

        PLKConfiguration* linkConfiguration = [[PLKConfiguration alloc] initWithKey:@"<#YOUR_PLAID_PUBLIC_KEY#>" env:PLKEnvironmentSandbox product:PLKProductTransactions];
        linkConfiguration.clientName = @"Link Demo";
        linkConfiguration.countryCodes = @[@"<#COUNTRY_CODE#>"];
        // When re-initializing Link to complete the authentication flow ensure that the same oauthNonce is used.
        linkConfiguration.oauthNonce = self.oauthNonce;
        linkConfiguration.oauthRedirectUri = self.oauthRedirectUri;
        id<PLKPlaidLinkViewDelegate> linkViewDelegate  = self;
        PLKPlaidLinkViewController* linkViewController = [[PLKPlaidLinkViewController alloc] initWithOAuthStateId:oauthStateId configuration:linkConfiguration delegate:linkViewDelegate];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            linkViewController.modalPresentationStyle = UIModalPresentationFormSheet;
        }
        [self presentViewController:linkViewController animated:YES completion:nil];
    } @catch (NSException *exception) {
        NSLog(@"Invalid configuration: %@", exception);
    }
    // <!-- SMARTDOWN_PRESENT_OAUTH -->

}

@end
