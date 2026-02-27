//
//  ExampleView.h
//  LinkDemo-ObjC
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ExampleViewType) {
    ExampleViewTypePlaidLinkSession,
    ExampleViewTypePlaidLinkHeadlessSession,
    ExampleViewTypePlaidLayerSession,
    ExampleViewTypePlaidEmbeddedSearch,
    ExampleViewTypeSyncFinanceKit,
};

@interface ExampleView : NSObject

@property (nonatomic, readonly) ExampleViewType type;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *exampleDescription;

+ (instancetype)exampleWithType:(ExampleViewType)type;
+ (NSArray<ExampleView *> *)allExamples;

@end

NS_ASSUME_NONNULL_END
