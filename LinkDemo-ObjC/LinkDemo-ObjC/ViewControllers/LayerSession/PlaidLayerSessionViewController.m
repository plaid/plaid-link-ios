//
//  PlaidLayerSessionViewController.m
//  LinkDemo-ObjC
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

#import "PlaidLayerSessionViewController.h"
#import "LinkKitObjectiveC.h"
@import LinkKitObjC;

typedef NS_ENUM(NSInteger, LoadingState) {
    LoadingStateLoading,
    LoadingStateReady,
    LoadingStateError
};

@interface PlaidLayerSessionViewController ()

@property (nonatomic, copy) NSString *linkToken;
@property (nonatomic, assign) LoadingState state;
@property (nonatomic, copy, nullable) NSString *errorMessage;
@property (nonatomic, strong, nullable) id<PLKPlaidLayerSession> layerSession;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, strong) UILabel *errorLabel;
@property (nonatomic, strong) UITextField *phoneNumberTextField;
@property (nonatomic, strong) UITextField *dobTextField;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) UIButton *launchButton;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation PlaidLayerSessionViewController

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
    
    self.title = @"Plaid Layer Session";
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    
    [self setupUI];
    [self createSession];
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
    self.titleLabel.text = @"Plaid Layer Session Example";
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

    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.text = @"User Phone Number";
    phoneLabel.font = [UIFont systemFontOfSize:14];
    phoneLabel.textColor = [UIColor secondaryLabelColor];
    [stackView addArrangedSubview:phoneLabel];
    
    self.phoneNumberTextField = [[UITextField alloc] init];
    self.phoneNumberTextField.placeholder = @"+1 415-555-0011";
    self.phoneNumberTextField.text = @"+1 415-555-0011";
    self.phoneNumberTextField.keyboardType = UIKeyboardTypePhonePad;
    self.phoneNumberTextField.borderStyle = UITextBorderStyleRoundedRect;
    [stackView addArrangedSubview:self.phoneNumberTextField];

    UILabel *dobLabel = [[UILabel alloc] init];
    dobLabel.text = @"User Date of Birth";
    dobLabel.font = [UIFont systemFontOfSize:14];
    dobLabel.textColor = [UIColor secondaryLabelColor];
    [stackView addArrangedSubview:dobLabel];
    
    self.dobTextField = [[UITextField alloc] init];
    self.dobTextField.placeholder = @"YYYY-MM-DD";
    self.dobTextField.text = @"1975-01-18";
    self.dobTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.dobTextField.borderStyle = UITextBorderStyleRoundedRect;
    [stackView addArrangedSubview:self.dobTextField];

    self.submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.submitButton setTitle:@"Submit User Data" forState:UIControlStateNormal];
    self.submitButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.submitButton.backgroundColor = [UIColor systemBlueColor];
    self.submitButton.layer.cornerRadius = 10;
    [self.submitButton addTarget:self action:@selector(submitButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [stackView addArrangedSubview:self.submitButton];

    UIView *spacer = [[UIView alloc] init];
    [spacer setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
    [stackView addArrangedSubview:spacer];

    self.launchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.launchButton setTitle:@"Launch Layer" forState:UIControlStateNormal];
    self.launchButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.launchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.launchButton.backgroundColor = [UIColor systemBlueColor];
    self.launchButton.layer.cornerRadius = 10;
    [self.launchButton addTarget:self action:@selector(launchButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [stackView addArrangedSubview:self.launchButton];

    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    self.activityIndicator.color = [UIColor whiteColor];
    self.activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    [self.launchButton addSubview:self.activityIndicator];

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

        [self.submitButton.heightAnchor constraintEqualToConstant:56],
        [self.launchButton.heightAnchor constraintEqualToConstant:56],
        [self.activityIndicator.leadingAnchor constraintEqualToAnchor:self.launchButton.leadingAnchor constant:16],
        [self.activityIndicator.centerYAnchor constraintEqualToAnchor:self.launchButton.centerYAnchor]
    ]];
    
    [self updateUI];
}

- (void)createSession {
    __weak typeof(self) weakSelf = self;
    
    PLKLayerTokenConfiguration *configuration = [PLKLayerTokenConfiguration createWithToken:self.linkToken onSuccess:^(PLKLinkSuccess *success) {
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
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) return;
        
        NSLog(@"Link Event: %@", event.eventName);

        // Wait for the Layer ready event
        if (event.eventName.value == PLKEventNameValueLayerReady) {
            [strongSelf setState:LoadingStateReady];
            [strongSelf updateUI];
        } else if (event.eventName.value == PLKEventNameValueLayerNotAvailable) {
            [strongSelf setState:LoadingStateError];
            strongSelf.errorMessage = @"Layer not available";
            [strongSelf updateUI];
        }
    };
    
    NSError *error = nil;
    id<PLKPlaidLayerSession> session = [PLKPlaid createPlaidLayerSessionWithConfiguration:configuration error:&error];
    
    if (error) {
        self.state = LoadingStateError;
        self.errorMessage = error.localizedDescription;
        [self updateUI];
    } else {
        self.layerSession = session;
    }
}

- (void)submitButtonTapped {
    if (self.layerSession) {
        PLKSubmissionData *submissionData = [[PLKSubmissionData alloc] init];
        submissionData.phoneNumber = self.phoneNumberTextField.text;
        submissionData.dateOfBirth = self.dobTextField.text;
        
        [self.layerSession submit:submissionData];
    }
}

- (void)launchButtonTapped {
    if (self.layerSession) {
        __weak typeof(self) weakSelf = self;
        [self.layerSession openWithPresentationHandler:^(UIViewController *viewController) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf presentViewController:viewController animated:YES completion:nil];
            }
        } dismissalHandler:^(UIViewController *viewController) {
            [viewController dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}

- (void)updateUI {
    dispatch_async(dispatch_get_main_queue(), ^{
        // Submit button is enabled whenever we have a layer session
        BOOL hasSession = self.layerSession != nil;
        self.submitButton.enabled = hasSession;
        self.submitButton.backgroundColor = hasSession ? [UIColor systemBlueColor] : [UIColor systemGrayColor];
        
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
