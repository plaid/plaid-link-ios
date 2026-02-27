//
//  PlaidLinkHeadlessSessionViewController.m
//  LinkDemo-ObjC
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

#import "PlaidLinkHeadlessSessionViewController.h"
#import "LinkKitObjectiveC.h"
@import LinkKitObjC;

typedef NS_ENUM(NSInteger, LoadingState) {
    LoadingStateLoading,
    LoadingStateReady,
    LoadingStateError
};

@interface PlaidLinkHeadlessSessionViewController ()

@property (nonatomic, copy) NSString *linkToken;
@property (nonatomic, assign) LoadingState state;
@property (nonatomic, copy, nullable) NSString *errorMessage;
@property (nonatomic, strong, nullable) id<PLKPlaidHeadlessSession> headlessSession;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, strong) UILabel *errorLabel;
@property (nonatomic, strong) UIButton *launchButton;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation PlaidLinkHeadlessSessionViewController

- (instancetype)initWithLinkToken:(NSString *)linkToken {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _linkToken = [linkToken copy];
        _state = LoadingStateLoading;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Plaid Headless Session";
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    
    [self setupUI];
    [self createSession];
}

- (void)setupUI {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"Plaid Link Headless Session Example";
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.titleLabel];

    self.versionLabel = [[UILabel alloc] init];
    NSString *version = [PLKPlaid sdkVersion];
    self.versionLabel.text = [NSString stringWithFormat:@"LinkKit v%@", version];
    self.versionLabel.font = [UIFont systemFontOfSize:14];
    self.versionLabel.textColor = [UIColor secondaryLabelColor];
    self.versionLabel.textAlignment = NSTextAlignmentCenter;
    self.versionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.versionLabel];

    self.errorLabel = [[UILabel alloc] init];
    self.errorLabel.font = [UIFont systemFontOfSize:14];
    self.errorLabel.textColor = [UIColor systemRedColor];
    self.errorLabel.textAlignment = NSTextAlignmentCenter;
    self.errorLabel.numberOfLines = 0;
    self.errorLabel.hidden = YES;
    self.errorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.errorLabel];

    self.launchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.launchButton setTitle:@"Launch Payment Flow" forState:UIControlStateNormal];
    self.launchButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.launchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.launchButton.backgroundColor = [UIColor systemBlueColor];
    self.launchButton.layer.cornerRadius = 10;
    self.launchButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.launchButton addTarget:self action:@selector(launchButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.launchButton];

    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    self.activityIndicator.color = [UIColor whiteColor];
    self.activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    [self.launchButton addSubview:self.activityIndicator];

    [NSLayoutConstraint activateConstraints:@[
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:32],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:16],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-16],

        [self.versionLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:8],
        [self.versionLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:16],
        [self.versionLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-16],

        [self.errorLabel.topAnchor constraintEqualToAnchor:self.versionLabel.bottomAnchor constant:16],
        [self.errorLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:16],
        [self.errorLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-16],

        [self.launchButton.topAnchor constraintEqualToAnchor:self.errorLabel.bottomAnchor constant:24],
        [self.launchButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:16],
        [self.launchButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-16],
        [self.launchButton.heightAnchor constraintEqualToConstant:56],

        [self.activityIndicator.leadingAnchor constraintEqualToAnchor:self.launchButton.leadingAnchor constant:16],
        [self.activityIndicator.centerYAnchor constraintEqualToAnchor:self.launchButton.centerYAnchor]
    ]];
    
    [self updateUI];
}

- (void)createSession {
    __weak typeof(self) weakSelf = self;
    
    PLKLinkTokenConfiguration *configuration = [PLKLinkTokenConfiguration createWithToken:self.linkToken onSuccess:^(PLKLinkSuccess *success) {
        NSLog(@"public-token: %@ metadata: %@", success.publicToken, success.metadata.metadataJSON);
    }];
    
    configuration.onExit = ^(PLKLinkExit *exit) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) return;
        
        if (exit.error) {
            NSLog(@"exit with %@\n%@", exit.error, exit.metadata.metadataJSON);
            [strongSelf setState:LoadingStateError];
            NSString *displayMessage = exit.error.userInfo[kPLKExitErrorDisplayMessageKey];
            strongSelf.errorMessage = displayMessage ?: exit.error.localizedDescription ?: @"Exited with error";
            [strongSelf updateUI];
        } else {
            NSLog(@"exit with %@", exit.metadata.metadataJSON);
        }
    };
    
    configuration.onEvent = ^(PLKLinkEvent *event) {
        NSLog(@"Link Event: %@", event.eventName);
    };
    
    configuration.onLoad = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) return;
        
        [strongSelf setState:LoadingStateReady];
        [strongSelf updateUI];
    };
    
    NSError *error = nil;
    id<PLKPlaidHeadlessSession> session = [PLKPlaid createHeadlessSessionWithConfiguration:configuration error:&error];
    
    if (error) {
        self.state = LoadingStateError;
        self.errorMessage = error.localizedDescription;
        [self updateUI];
    } else {
        self.headlessSession = session;
    }
}

- (void)launchButtonTapped {
    if (self.headlessSession) {
        [self.headlessSession start];
    }
}

- (void)updateUI {
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (self.state) {
            case LoadingStateLoading:
                self.launchButton.enabled = NO;
                self.launchButton.backgroundColor = [UIColor systemGrayColor];
                [self.activityIndicator startAnimating];
                self.errorLabel.hidden = YES;
                break;
                
            case LoadingStateReady:
                self.launchButton.enabled = YES;
                self.launchButton.backgroundColor = [UIColor systemBlueColor];
                [self.activityIndicator stopAnimating];
                self.errorLabel.hidden = YES;
                break;
                
            case LoadingStateError:
                self.launchButton.enabled = NO;
                self.launchButton.backgroundColor = [UIColor systemGrayColor];
                [self.activityIndicator stopAnimating];
                self.errorLabel.text = self.errorMessage;
                self.errorLabel.hidden = NO;
                break;
        }
    });
}

@end
