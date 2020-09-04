//
//  ViewController.m
//  LinkDemo-ObjC
//
//  Copyright © 2019 Plaid Inc. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+PLKPlaidLinkViewDelegate.h"
#import "ViewController+CustomConfiguration.h"
#import "ViewController+SharedConfiguration.h"
#import "ViewController+PaymentInitiation.h"
#import "ViewController+LinkToken.h"
#import "ViewController+OAuthSupport.h"
#import "ViewController+LegacyPublicKeyUpdateMode.h"

@interface ViewController ()
@property IBOutlet UIButton* button;
@property IBOutlet UILabel* label;
@property IBOutlet UIView* buttonContainerView;
@end

@implementation ViewController
@synthesize oauthNonce = _oauthNonce;

- (void)awakeFromNib {
    [super awakeFromNib];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveNotification:)
                                                 name:@"PLDPlaidLinkSetupFinished"
                                               object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSBundle* linkKitBundle = [NSBundle bundleForClass:[PLKPlaidLinkViewController class]];
    NSString* linkName      = [linkKitBundle objectForInfoDictionaryKey:(NSString*)kCFBundleNameKey];
    self.label.text         = [NSString stringWithFormat:@"Objective-C — %@ %s+%.0f"
                                 , linkName, LinkKitVersionString, LinkKitVersionNumber];

    UIColor* shadowColor = [UIColor colorWithRed:3/255.0 green:49/255.0 blue:86/255.0 alpha:0.1];
    self.buttonContainerView.layer.shadowColor   = [shadowColor CGColor];
    self.buttonContainerView.layer.shadowOffset  = CGSizeMake(0, -1);
    self.buttonContainerView.layer.shadowRadius  = 2;
    self.buttonContainerView.layer.shadowOpacity = 1;
}

- (void)didReceiveNotification:(NSNotification*)notification {
    if ([@"PLDPlaidLinkSetupFinished" isEqualToString:notification.name]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:notification.name
                                                      object:self];
        self.button.enabled = YES;
    }
}

- (NSURL*)oauthRedirectUri {
    #warning Replace <#YOUR_OAUTH_REDIRECT_URI#> below with your oauthRedirectUri, which should be a universal link and must be configured in the Plaid developer dashboard
    # warning Ensure to also replace YOUR_OAUTH_REDIRECT_URI in the Associated Domains Capability or in the LinkDemo-ObjC.entitlements
    # warning Remember to change the application Bundle Identifier to match one you have configured for universal links
    return [NSURL URLWithString:@"<#YOUR_OAUTH_REDIRECT_URI#>"];
}

- (NSString*)oauthNonce {
    // When re-initializing Link to complete the OAuth flows ensure that the same oauthNonce is used per session.
    // This is a simplified example for demonstaration purposes only.
    if (_oauthNonce == nil) {
        _oauthNonce = [[NSUUID UUID] UUIDString];
    }
    return _oauthNonce;
}

- (IBAction)didTapButton:(id)sender {
    typedef enum : NSUInteger {
        customConfiguration,
        sharedConfiguration,
        linkToken,
        oauthSupport,
        paymentInitiation,
        legacyUpdateMode,
    } PlaidLinkSampleFlow;
    #warning Select your desired Plaid Link sample flow
    PlaidLinkSampleFlow sampleFlow = linkToken;
    switch (sampleFlow) {
        case sharedConfiguration:
            [self presentPlaidLinkWithSharedConfiguration];
            break;
        case linkToken:
            [self presentPlaidLinkUsingLinkToken];
            break;
        case oauthSupport:
            [self presentPlaidLinkWithOAuthSupport:nil];
            break;
        case paymentInitiation:
            [self presentPlaidLinkWithPaymentInitation:nil];
            break;
        case legacyUpdateMode:
            [self presentPlaidLinkInLegacyPublicKeyUpdateMode];
            break;
        case customConfiguration:
            // Intentionally fallthrough
        default:
            [self presentPlaidLinkWithCustomConfiguration];
            break;
    }
}

@end
