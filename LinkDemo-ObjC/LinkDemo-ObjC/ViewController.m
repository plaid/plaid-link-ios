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
#import "ViewController+UpdateMode.h"

@interface ViewController ()
@property IBOutlet UIButton* button;
@property IBOutlet UILabel* label;
@property IBOutlet UIView* buttonContainerView;
@end

@implementation ViewController

- (void)awakeFromNib {
    [super awakeFromNib];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveNotification:)
                                                 name:@"PLDPlaidLinkSetupFinished"
                                               object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.button.enabled = NO;

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

- (IBAction)didTapButton:(id)sender {
    typedef enum : NSUInteger {
        customConfiguration,
        sharedConfiguration,
        updateMode,
    } PlaidLinkSampleFlow;
    #warning Select your desired Plaid Link sample flow
    PlaidLinkSampleFlow sampleFlow = customConfiguration;
    switch (sampleFlow) {
        case sharedConfiguration:
            [self presentPlaidLinkWithSharedConfiguration];
            break;
        case updateMode:
            [self presentPlaidLinkInUpdateMode];
            break;
        case customConfiguration:
            // Intentionally fallthrough
        default:
            [self presentPlaidLinkWithCustomConfiguration];
            break;
    }
}

@end
