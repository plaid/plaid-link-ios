//
//  ViewController+ItemAddToken.m
//  LinkDemo-ObjC
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

#import <LinkKit/LinkKit.h>

#import "ViewController+ItemAddToken.h"
#import "ViewController+PLKPlaidLinkViewDelegate.h"

@implementation ViewController (ItemAddToken)

// MARK: Start Plaid Link with custom configuration using an item-add token
// For details please see https://plaid.com/docs/link-token-migration-guide/
- (void)presentPlaidLinkUsingItemAddToken {

    #warning Replace <#GENERATED_ITEM_ADD_TOKEN#> below with your update mode public_token
    // <!-- SMARTDOWN_PRESENT_ITEMADD -->
    // With custom configuration using an item-add token
    PLKConfiguration* linkConfiguration;
    @try {
        linkConfiguration = [[PLKConfiguration alloc] initWithKey:kPLKUseItemAddTokenInsteadOfPublicKey env:PLKEnvironmentSandbox product:PLKProductAuth];
        linkConfiguration.clientName = @"Link Demo";
    } @catch (NSException *exception) {
        NSLog(@"Invalid configuration: %@", exception);
        return;
    }

    // In your production application replace the hardcoded itemAddToken below with code that fetches an item-add token
    // from your backend server which in turn retrieves it securely from Plaid, for details please refer to
    // https://plaid.com/docs/link-token-migration-guide/
    NSString* itemAddToken = @"<#GENERATED_ITEM_ADD_TOKEN#>";
    id<PLKPlaidLinkViewDelegate> linkViewDelegate  = self;
    PLKPlaidLinkViewController* linkViewController = [[PLKPlaidLinkViewController alloc] initWithItemAddToken:itemAddToken configuration:linkConfiguration delegate:linkViewDelegate];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        linkViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    [self presentViewController:linkViewController animated:YES completion:nil];
    // <!-- SMARTDOWN_PRESENT_ITEMADD -->

}

@end
