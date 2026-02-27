//
//  PlaidEmbeddedLinkViewController.m
//  LinkDemo-ObjC
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

#import "PlaidEmbeddedLinkViewController.h"
#import "LinkKitObjectiveC.h"
@import LinkKitObjC;

typedef NS_ENUM(NSInteger, LoadingState) {
    LoadingStateLoading,
    LoadingStateReady,
    LoadingStateError
};

@interface PlaidEmbeddedLinkViewController ()

@property (nonatomic, copy) NSString *linkToken;
@property (nonatomic, assign) LoadingState state;
@property (nonatomic, copy, nullable) NSString *errorMessage;
@property (nonatomic, strong, nullable) UIView *embeddedSearchView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, strong) UILabel *errorLabel;
@property (nonatomic, strong) UIView *embeddedViewContainer;

@end

@implementation PlaidEmbeddedLinkViewController

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
    
    self.title = @"Plaid Embedded Link";
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    
    [self setupUI];
    [self createEmbeddedView];
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

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"Plaid Embedded Link View Example";
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 0;
    [stackView addArrangedSubview:self.titleLabel];

    self.versionLabel = [[UILabel alloc] init];
    NSString *version = [PLKPlaid sdkVersion];
    self.versionLabel.text = [NSString stringWithFormat:@"LinkKit v%@", version];
    self.versionLabel.font = [UIFont systemFontOfSize:14];
    self.versionLabel.textColor = [UIColor secondaryLabelColor];
    self.versionLabel.textAlignment = NSTextAlignmentCenter;
    [stackView addArrangedSubview:self.versionLabel];

    self.errorLabel = [[UILabel alloc] init];
    self.errorLabel.font = [UIFont systemFontOfSize:14];
    self.errorLabel.textColor = [UIColor systemRedColor];
    self.errorLabel.textAlignment = NSTextAlignmentCenter;
    self.errorLabel.numberOfLines = 0;
    self.errorLabel.hidden = YES;
    [stackView addArrangedSubview:self.errorLabel];

    self.embeddedViewContainer = [[UIView alloc] init];
    self.embeddedViewContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [stackView addArrangedSubview:self.embeddedViewContainer];

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
    ]];
}

- (void)createEmbeddedView {
    __weak typeof(self) weakSelf = self;
    
    PLKEmbeddedLinkTokenConfiguration *configuration = [PLKEmbeddedLinkTokenConfiguration createWithToken:self.linkToken onSuccess:^(PLKLinkSuccess *success) {
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
    
    NSError *error = nil;
    UIView *embeddedView = [PLKPlaid createEmbeddedLinkUIViewWithConfiguration:configuration 
                                                                          error:&error 
                                                              presentationHandler:^(UIViewController *viewController) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf presentViewController:viewController animated:YES completion:nil];
        }
    } 
                                                                dismissalHandler:^(UIViewController *viewController) {
        [viewController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    if (error) {
        self.state = LoadingStateError;
        self.errorMessage = error.localizedDescription;
        [self updateUI];
    } else if (embeddedView) {
        self.embeddedSearchView = embeddedView;
        self.state = LoadingStateReady;
        [self addEmbeddedView];
        [self updateUI];
    }
}

- (void)addEmbeddedView {
    if (!self.embeddedSearchView) return;
    self.embeddedSearchView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.embeddedViewContainer addSubview:self.embeddedSearchView];

    [NSLayoutConstraint activateConstraints:@[
        [self.embeddedSearchView.topAnchor constraintEqualToAnchor:self.embeddedViewContainer.topAnchor],
        [self.embeddedSearchView.leadingAnchor constraintEqualToAnchor:self.embeddedViewContainer.leadingAnchor],
        [self.embeddedSearchView.trailingAnchor constraintEqualToAnchor:self.embeddedViewContainer.trailingAnchor],
        [self.embeddedSearchView.bottomAnchor constraintEqualToAnchor:self.embeddedViewContainer.bottomAnchor],
        
        // Set a minimum height for the embedded view
        [self.embeddedSearchView.heightAnchor constraintGreaterThanOrEqualToConstant:400]
    ]];
}

- (void)updateUI {
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (self.state) {
            case LoadingStateLoading:
                self.errorLabel.hidden = YES;
                self.embeddedViewContainer.hidden = YES;
                break;
                
            case LoadingStateReady:
                self.errorLabel.hidden = YES;
                self.embeddedViewContainer.hidden = NO;
                break;
                
            case LoadingStateError:
                self.errorLabel.text = self.errorMessage;
                self.errorLabel.hidden = NO;
                self.embeddedViewContainer.hidden = YES;
                break;
        }
    });
}

@end
