//
//  ViewController.h
//  LinkDemo-ObjC
//
//  Copyright © 2019 Plaid Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LinkKit/LinkKit.h>

@protocol LinkOAuthHandling
@property (readonly) id<PLKHandler> linkHandler;
@property (readonly) NSURL* oauthRedirectUri;
@end

@interface ViewController : UIViewController <LinkOAuthHandling>

@property (readonly) NSString* oauthNonce;
@property (readwrite) id<PLKHandler> linkHandler;

@end

