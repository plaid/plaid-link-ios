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
@end

@interface ViewController : UIViewController <LinkOAuthHandling>

@property (readwrite) id<PLKHandler> linkHandler;

#pragma mark - PublicKey Configuration (Deprecated)
// Integrating LinkKit using public key has been deprecated in favor of Link Tokens
// hence the public key related oauthNonce and oauthRedirect properties are deprecated as well.
// For more information on how to migrate to Link Tokens see https://plaid.com/docs/link/link-token-migration-guide/
@property (readonly) NSString* oauthNonce;
@property (readonly) NSURL* oauthRedirectUri;

@end

