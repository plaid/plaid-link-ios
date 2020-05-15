//
//  ViewController+PaymentInitiation.m
//  LinkDemo-ObjC
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

#import <LinkKit/LinkKit.h>

#import "ViewController+PaymentInitiation.h"
#import "ViewController+PLKPlaidLinkViewDelegate.h"

@implementation ViewController (PaymentInitiation)

// MARK: Start Plaid Link in payment initation mode
// For details about OAuth support please see https://plaid.com/docs/#payment-initiation
- (void)presentPlaidLinkWithPaymentInitation {

    #warning Replace <#YOUR_PLAID_PUBLIC_KEY#>, <#COUNTRY_CODE#> , and <#GENERATED_PAYMENT_TOKEN#> below with your public_key, supported country codes and the generated payment_token
    // <!-- SMARTDOWN_PAYMENT_MODE -->
    // With custom configuration for payment initation
    @try {
        // Plaid Link Payment Initiation leverages OAuth, which works in two steps, the first step is to initiate the OAuth authentication flow,
        // the second to complete the OAuth authentication flow. On each step Plaid Link must be initialized
        // as follows:

        // When re-initializing Link to complete the authentication flow ensure that the same oauthNonce is used.
        NSString* oauthNonce = [[NSUUID UUID] UUIDString];

        #warning Replace the example oauthRedirectUri below with your oauthRedirectUri, which should be configured as a universal link and must be whitelisted through Plaid's developer dashboard
        NSURL* oauthRedirectUri = [NSURL URLWithString:@"https://example.net/plaid-oauth"];

        // Replace the example userActivityWebpageURL below with code that takes the userActivity.webpageURL from
        // UIApplicationDelegate.application:continueUserActivity:restorationHandler:
        NSURL* userActivityWebpageURL = [NSURL URLWithString:@"https://example.net/plaid-oauth?oauth_state_id=f81d4fae-7dec-11d0-a765-00a0c91e6bf6"];
        NSString* oauthStateId = PLKOAuthStateIdFromURL(userActivityWebpageURL);

        PLKConfiguration* linkConfiguration = [[PLKConfiguration alloc] initWithKey:@"<#YOUR_PLAID_PUBLIC_KEY#>" env:PLKEnvironmentSandbox product:PLKProductPaymentInitiation];
        linkConfiguration.clientName = @"Link Demo";
        linkConfiguration.countryCodes = @[@"<#COUNTRY_CODE#>"];
        linkConfiguration.oauthNonce = oauthNonce;
        linkConfiguration.oauthRedirectUri = oauthRedirectUri;
        id<PLKPlaidLinkViewDelegate> linkViewDelegate  = self;

        NSString* paymentToken = @"<#GENERATED_PAYMENT_TOKEN#>";
        PLKPlaidLinkViewController* linkViewController = [[PLKPlaidLinkViewController alloc] initWithPaymentToken:paymentToken oauthStateId:oauthStateId configuration:linkConfiguration delegate:linkViewDelegate];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            linkViewController.modalPresentationStyle = UIModalPresentationFormSheet;
        }
        [self presentViewController:linkViewController animated:YES completion:nil];
    } @catch (NSException *exception) {
        NSLog(@"Invalid configuration: %@", exception);
    }
    // <!-- SMARTDOWN_PAYMENT_MODE -->

}

@end
