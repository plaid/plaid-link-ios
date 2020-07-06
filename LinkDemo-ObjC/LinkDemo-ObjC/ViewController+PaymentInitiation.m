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
- (void)presentPlaidLinkWithPaymentInitation:(NSString* _Nullable)oauthStateId {

    #warning Replace <#YOUR_PLAID_PUBLIC_KEY#>, <#COUNTRY_CODE#> , and <#GENERATED_PAYMENT_TOKEN#> below with your public_key, supported country codes and the generated payment_token
    // <!-- SMARTDOWN_PAYMENT_MODE -->
    // With custom configuration for payment initation
    @try {
        // Plaid Link Payment Initiation leverages OAuth, which works in two steps, the first step is to initiate the OAuth authentication flow,
        // the second to complete the OAuth authentication flow. On each step Plaid Link must be initialized
        // as follows:

        if ([self.presentedViewController isKindOfClass:[PLKPlaidLinkViewController class]]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }


        PLKConfiguration* linkConfiguration = [[PLKConfiguration alloc] initWithKey:@"<#YOUR_PLAID_PUBLIC_KEY#>" env:PLKEnvironmentSandbox product:PLKProductPaymentInitiation];
        linkConfiguration.clientName = @"Link Demo";
        linkConfiguration.countryCodes = @[@"<#COUNTRY_CODE#>"];
        // When re-initializing Link to complete the authentication flow ensure that the same oauthNonce is used.
        linkConfiguration.oauthNonce = self.oauthNonce;
        linkConfiguration.oauthRedirectUri = self.oauthRedirectUri;
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
