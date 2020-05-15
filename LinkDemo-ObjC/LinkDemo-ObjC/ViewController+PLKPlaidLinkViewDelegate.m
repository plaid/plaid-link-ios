//
//  ViewController+PLKPlaidLinkViewDelegate.m
//  LinkDemo-ObjC
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

#import "ViewController+PLKPlaidLinkViewDelegate.h"

@implementation ViewController (PLKPlaidLinkViewDelegate)

// MARK: - PLKPlaidLinkViewDelegate Protocol

// <!-- SMARTDOWN_DELEGATE_SUCCESS -->
- (void)linkViewController:(PLKPlaidLinkViewController*)linkViewController
 didSucceedWithPublicToken:(NSString*)publicToken
                  metadata:(NSDictionary<NSString*,id>* _Nullable)metadata {
    [self dismissViewControllerAnimated:YES completion:^{
        // Handle success, e.g. by storing publicToken with your service
        NSLog(@"Successfully linked account!\npublicToken: %@\nmetadata: %@", publicToken, metadata);
        [self handleSuccessWithToken:publicToken metadata:metadata];
    }];
}
// <!-- SMARTDOWN_DELEGATE_SUCCESS -->

// <!-- SMARTDOWN_DELEGATE_EXIT -->
- (void)linkViewController:(PLKPlaidLinkViewController*)linkViewController
          didExitWithError:(NSError* _Nullable)error
                  metadata:(NSDictionary<NSString*,id>* _Nullable)metadata {
    [self dismissViewControllerAnimated:YES completion:^{
        if (error) {
            NSLog(@"Failed to link account due to: %@\nmetadata: %@", [error localizedDescription], metadata);
            [self handleError:error metadata:metadata];
        }
        else {
            NSLog(@"Plaid link exited with metadata: %@", metadata);
            [self handleExitWithMetadata:metadata];
        }
    }];
}
// <!-- SMARTDOWN_DELEGATE_EXIT -->

// <!-- SMARTDOWN_DELEGATE_EVENT -->
- (void)linkViewController:(PLKPlaidLinkViewController*)linkViewController
            didHandleEvent:(NSString*)event
                  metadata:(NSDictionary<NSString*,id>* _Nullable)metadata {
    NSLog(@"Link event: %@\nmetadata: %@", event, metadata);
}
// <!-- SMARTDOWN_DELEGATE_EVENT -->


// MARK: -

- (void)handleSuccessWithToken:(NSString*)publicToken metadata:(NSDictionary<NSString*,id>*)metadata {
    NSString* message = [NSString stringWithFormat:@"token: %@\nmetadata: %@", publicToken, metadata];
    [self presentAlertViewWithTitle:@"Success" message:message];
}

- (void)handleError:(NSError*)error metadata:(NSDictionary<NSString*,id>*)metadata {
    NSString* message = [NSString stringWithFormat:@"error: %@\nmetadata: %@", [error localizedDescription], metadata];
    [self presentAlertViewWithTitle:@"Failure" message:message];
}

- (void)handleExitWithMetadata:(NSDictionary<NSString*,id>*)metadata {
    NSString* message = [NSString stringWithFormat:@"metadata: %@", metadata];
    [self presentAlertViewWithTitle:@"Exit" message:message];
}

- (void)presentAlertViewWithTitle:(NSString*)title message:(NSString*)message {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
