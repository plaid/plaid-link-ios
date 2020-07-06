//
//  ViewController+PaymentInitiation.h
//  LinkDemo-ObjC
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewController (PaymentInitiation)
- (void)presentPlaidLinkWithPaymentInitation:(NSString* _Nullable)oauthStateId;
@end

NS_ASSUME_NONNULL_END
