//
//  ViewController.h
//  LinkDemo-ObjC
//
//  Copyright © 2019 Plaid Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LinkKit/LinkKit.h>

@interface ViewController : UIViewController

@property (readwrite) id<PLKHandler> linkHandler;

- (void)presentPlaidLinkUsingLinkToken;

@end

