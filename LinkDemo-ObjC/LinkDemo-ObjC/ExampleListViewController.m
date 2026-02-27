//
//  ExampleListViewController.m
//  LinkDemo-ObjC
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

#import "ExampleListViewController.h"
#import "ExampleView.h"
#import "ViewControllers/LinkSession/PlaidLinkSessionViewController.h"
#import "ViewControllers/HeadlessSession/PlaidLinkHeadlessSessionViewController.h"
#import "ViewControllers/LayerSession/PlaidLayerSessionViewController.h"
#import "ViewControllers/EmbeddedSearch/PlaidEmbeddedLinkViewController.h"
#import "ViewControllers/FinanceKit/SyncFinanceKitViewController.h"

static NSString *const kCellReuseIdentifier = @"ExampleCell";

@interface ExampleListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<ExampleView *> *examples;
@property (nonatomic, copy) NSString *linkToken;

@end

@implementation ExampleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"LinkKit Examples";
    self.view.backgroundColor = [UIColor systemBackgroundColor];

    #warning Replace <#GENERATED_LINK_TOKEN#> below with your link_token
    self.linkToken = @"<#GENERATED_LINK_TOKEN#>";

    self.examples = [ExampleView allExamples];

    [self setupTableView];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleInsetGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellReuseIdentifier];

    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.examples.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier forIndexPath:indexPath];

    ExampleView *example = self.examples[indexPath.row];

    // Configure cell
    UIListContentConfiguration *content = [cell defaultContentConfiguration];
    content.text = example.title;
    content.secondaryText = example.exampleDescription;
    content.secondaryTextProperties.numberOfLines = 0;
    content.secondaryTextProperties.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    content.secondaryTextProperties.color = [UIColor secondaryLabelColor];

    cell.contentConfiguration = content;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    ExampleView *example = self.examples[indexPath.row];

    UIViewController *viewController = nil;
    
    switch (example.type) {
        case ExampleViewTypePlaidLinkSession:
            viewController = [[PlaidLinkSessionViewController alloc] initWithLinkToken:self.linkToken];
            break;
            
        case ExampleViewTypePlaidLinkHeadlessSession:
            viewController = [[PlaidLinkHeadlessSessionViewController alloc] initWithLinkToken:self.linkToken];
            break;
            
        case ExampleViewTypePlaidLayerSession:
            viewController = [[PlaidLayerSessionViewController alloc] initWithLinkToken:self.linkToken];
            break;
            
        case ExampleViewTypePlaidEmbeddedSearch:
            viewController = [[PlaidEmbeddedLinkViewController alloc] initWithLinkToken:self.linkToken];
            break;
            
        case ExampleViewTypeSyncFinanceKit:
            viewController = [[SyncFinanceKitViewController alloc] initWithLinkToken:self.linkToken];
            break;
    }
    
    if (viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
