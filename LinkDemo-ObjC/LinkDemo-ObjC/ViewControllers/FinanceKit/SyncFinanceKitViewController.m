//
//  SyncFinanceKitViewController.m
//  LinkDemo-ObjC
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

#import "SyncFinanceKitViewController.h"
#import "LinkKitObjectiveC.h"
@import LinkKitObjC;

@interface SyncFinanceKitViewController ()

@property (nonatomic, copy) NSString *linkToken;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, strong) UILabel *warningLabel;
@property (nonatomic, strong) UILabel *requirementsLabel;
@property (nonatomic, strong) UIButton *syncButton;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation SyncFinanceKitViewController

- (instancetype)initWithLinkToken:(NSString *)linkToken {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _linkToken = [linkToken copy];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Sync FinanceKit";
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    
    [self setupUI];
}

- (void)setupUI {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:scrollView];
    
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.spacing = 16;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView addSubview:stackView];
    
    // Title Label
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"Sync FinanceKit Example";
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 0;
    [stackView addArrangedSubview:self.titleLabel];
    
    // Version Label
    self.versionLabel = [[UILabel alloc] init];
    NSString *version = [PLKPlaid sdkVersion];
    self.versionLabel.text = [NSString stringWithFormat:@"LinkKit v%@", version];
    self.versionLabel.font = [UIFont systemFontOfSize:14];
    self.versionLabel.textColor = [UIColor secondaryLabelColor];
    self.versionLabel.textAlignment = NSTextAlignmentCenter;
    [stackView addArrangedSubview:self.versionLabel];

    self.warningLabel = [[UILabel alloc] init];
    self.warningLabel.text = @"⚠️ IMPORTANT";
    self.warningLabel.font = [UIFont boldSystemFontOfSize:16];
    self.warningLabel.textColor = [UIColor systemOrangeColor];
    self.warningLabel.textAlignment = NSTextAlignmentCenter;
    [stackView addArrangedSubview:self.warningLabel];

    self.requirementsLabel = [[UILabel alloc] init];
    self.requirementsLabel.text = @"Requirements:\n\n1. You MUST have a FinanceKit entitlement from Apple (or the app will crash)\n\n2. The link token must be associated with an access token from a previous session where the user linked their Apple Card\n\n3. iOS 17.4 or later is required";
    self.requirementsLabel.font = [UIFont systemFontOfSize:14];
    self.requirementsLabel.textColor = [UIColor labelColor];
    self.requirementsLabel.numberOfLines = 0;
    self.requirementsLabel.textAlignment = NSTextAlignmentLeft;
    [stackView addArrangedSubview:self.requirementsLabel];

    self.syncButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.syncButton setTitle:@"Sync FinanceKit" forState:UIControlStateNormal];
    self.syncButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.syncButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.syncButton.backgroundColor = [UIColor systemBlueColor];
    self.syncButton.layer.cornerRadius = 10;
    [self.syncButton addTarget:self action:@selector(syncButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [stackView addArrangedSubview:self.syncButton];

    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    self.activityIndicator.color = [UIColor whiteColor];
    self.activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    [self.syncButton addSubview:self.activityIndicator];

    self.statusLabel = [[UILabel alloc] init];
    self.statusLabel.font = [UIFont systemFontOfSize:14];
    self.statusLabel.textColor = [UIColor secondaryLabelColor];
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    self.statusLabel.numberOfLines = 0;
    self.statusLabel.hidden = YES;
    [stackView addArrangedSubview:self.statusLabel];

    [NSLayoutConstraint activateConstraints:@[
        [scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],

        [stackView.topAnchor constraintEqualToAnchor:scrollView.topAnchor constant:16],
        [stackView.leadingAnchor constraintEqualToAnchor:scrollView.leadingAnchor constant:16],
        [stackView.trailingAnchor constraintEqualToAnchor:scrollView.trailingAnchor constant:-16],
        [stackView.bottomAnchor constraintEqualToAnchor:scrollView.bottomAnchor constant:-16],
        [stackView.widthAnchor constraintEqualToAnchor:scrollView.widthAnchor constant:-32],
        
        [self.syncButton.heightAnchor constraintEqualToConstant:56],
        [self.activityIndicator.leadingAnchor constraintEqualToAnchor:self.syncButton.leadingAnchor constant:16],
        [self.activityIndicator.centerYAnchor constraintEqualToAnchor:self.syncButton.centerYAnchor]
    ]];
}

- (void)syncButtonTapped {
    if (@available(iOS 17.4, *)) {
        [self syncFinanceKit];
    } else {
        [self showStatus:@"❌ FinanceKit requires iOS 17.4 or later" isError:YES];
    }
}

- (void)syncFinanceKit API_AVAILABLE(ios(17.4)) {
    self.syncButton.enabled = NO;
    [self.activityIndicator startAnimating];
    self.statusLabel.hidden = YES;
    
    [PLKPlaidFinanceKit syncFinanceKitWithToken:self.linkToken
                      requestAuthorizationIfNeeded:NO
                                       syncBehavior:PLKSyncBehaviorLive
                                          onSuccess:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showStatus:@"✅ Sync completed successfully" isError:NO];
            [self.activityIndicator stopAnimating];
            self.syncButton.enabled = YES;
        });
    }
                                            onError:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *errorMessage = [NSString stringWithFormat:@"❌ Sync failed: %@", error.localizedDescription];
            [self showStatus:errorMessage isError:YES];
            [self.activityIndicator stopAnimating];
            self.syncButton.enabled = YES;
        });
    }];
}

- (void)showStatus:(NSString *)message isError:(BOOL)isError {
    self.statusLabel.text = message;
    self.statusLabel.textColor = isError ? [UIColor systemRedColor] : [UIColor systemGreenColor];
    self.statusLabel.hidden = NO;
}

@end
