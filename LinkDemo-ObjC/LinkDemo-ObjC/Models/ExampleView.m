//
//  ExampleView.m
//  LinkDemo-ObjC
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

#import "ExampleView.h"

@implementation ExampleView

- (instancetype)initWithType:(ExampleViewType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

+ (instancetype)exampleWithType:(ExampleViewType)type {
    return [[self alloc] initWithType:type];
}

+ (NSArray<ExampleView *> *)allExamples {
    return @[
        [ExampleView exampleWithType:ExampleViewTypePlaidLinkSession],
        [ExampleView exampleWithType:ExampleViewTypePlaidLinkHeadlessSession],
        [ExampleView exampleWithType:ExampleViewTypePlaidLayerSession],
        [ExampleView exampleWithType:ExampleViewTypePlaidEmbeddedSearch],
        [ExampleView exampleWithType:ExampleViewTypeSyncFinanceKit],
    ];
}

- (NSString *)title {
    switch (self.type) {
        case ExampleViewTypePlaidLinkSession:
            return @"PlaidLinkSession";
        case ExampleViewTypePlaidLinkHeadlessSession:
            return @"PlaidLinkHeadlessSession";
        case ExampleViewTypePlaidLayerSession:
            return @"PlaidLayerSession";
        case ExampleViewTypePlaidEmbeddedSearch:
            return @"PlaidEmbeddedSearch";
        case ExampleViewTypeSyncFinanceKit:
            return @"Sync FinanceKit";
    }
}

- (NSString *)exampleDescription {
    switch (self.type) {
        case ExampleViewTypePlaidLinkSession:
            return @"Shows how create a PlaidLinkSession and use openWithPresentationHandler.";
        case ExampleViewTypePlaidLinkHeadlessSession:
            return @"Shows how to create a PlaidHeadlessSession and start a payment flow.";
        case ExampleViewTypePlaidLayerSession:
            return @"Shows how to create a PlaidLayerSession and start a Layer flow using openWithPresentationHandler.";
        case ExampleViewTypePlaidEmbeddedSearch:
            return @"Shows how to create a EmbeddedSearchView and start a Link flow from it.";
        case ExampleViewTypeSyncFinanceKit:
            return @"Shows how to sync the latest transactions from Apple Card using FinanceKit.";
    }
}

@end
