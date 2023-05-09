//
//  ViewController.m
//  LinkDemo-ObjC
//
//  Copyright © 2019 Plaid Inc. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+LinkToken.h"

@interface ViewController ()
@property IBOutlet UIButton* button;
@property IBOutlet UILabel* label;
@property IBOutlet UIView* buttonContainerView;
@end

@implementation ViewController
@synthesize linkHandler = _linkHandler;

#pragma mark - Implementation

- (void)viewDidLoad {
    [super viewDidLoad];

    NSBundle* linkKitBundle = [NSBundle bundleForClass:[PLKPlaid class]];
    NSString* linkName      = [linkKitBundle objectForInfoDictionaryKey:(NSString*)kCFBundleNameKey];
    self.label.text         = [NSString stringWithFormat:@"Objective-C — %@ %@+%@"
                                 , linkName
                                 , [linkKitBundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
                                 , [linkKitBundle objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];

    UIColor* shadowColor = [UIColor colorWithRed:3/255.0 green:49/255.0 blue:86/255.0 alpha:0.1];
    self.buttonContainerView.layer.shadowColor   = [shadowColor CGColor];
    self.buttonContainerView.layer.shadowOffset  = CGSizeMake(0, -1);
    self.buttonContainerView.layer.shadowRadius  = 2;
    self.buttonContainerView.layer.shadowOpacity = 1;
}

- (IBAction)didTapButton:(id)sender {
    [self presentPlaidLinkUsingLinkToken];
}

@end
