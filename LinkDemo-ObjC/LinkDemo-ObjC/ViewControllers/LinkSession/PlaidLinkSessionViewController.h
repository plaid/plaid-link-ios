//
//  PlaidLinkSessionViewController.h
//  LinkDemo-ObjC
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlaidLinkSessionViewController : UIViewController

- (instancetype)initWithLinkToken:(NSString *)linkToken;

@end

NS_ASSUME_NONNULL_END
