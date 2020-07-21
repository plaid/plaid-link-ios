//
//  ViewController+LinkToken.m
//  LinkDemo-ObjC
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

#import <LinkKit/LinkKit.h>

#import "ViewController+LinkToken.h"
#import "ViewController+PLKPlaidLinkViewDelegate.h"

@implementation ViewController (LinkToken)

// MARK: Start Plaid Link with custom configuration using a Link token
// For details please see https://plaid.com/docs/#create-link-token/
- (void)presentPlaidLinkUsingLinkToken {

    #warning Replace <#GENERATED_LINK_TOKEN#> below with your link_token
    // In your production application replace the hardcoded linkToken below with code that fetches an link_token
    // from your backend server which in turn retrieves it securely from Plaid, for details please refer to
    // https://plaid.com/docs/#create-link-token/
    NSString* linkToken = @"<#GENERATED_LINK_TOKEN#>";

    // <!-- SMARTDOWN_PRESENT_LINKTOKEN -->
    // With custom configuration using a link_token
    PLKConfiguration* linkConfiguration;
    @try {
        linkConfiguration = [[PLKConfiguration alloc] initWithLinkToken: linkToken];
    } @catch (NSException *exception) {
        NSLog(@"Invalid configuration: %@", exception);
        return;
    }

    id<PLKPlaidLinkViewDelegate> linkViewDelegate  = self;
    PLKPlaidLinkViewController* linkViewController = [[PLKPlaidLinkViewController alloc] initWithLinkToken:linkToken configuration:linkConfiguration delegate:linkViewDelegate];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        linkViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    [self presentViewController:linkViewController animated:YES completion:nil];
    // <!-- SMARTDOWN_PRESENT_LINKTOKEN -->

}

@end
