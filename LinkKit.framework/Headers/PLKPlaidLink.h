//
//  PLKPlaidLink.h
//  LinkKit
//
//  Copyright © 2016 Plaid Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PLKConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

/**
 A block that LinkKit calls when the requested Plaid Link setup has finished.

 @param success YES if the setup was successful, NO otherwise.
 @param error If an error occurs, contains an NSError object that describes the problem, nil otherwise.
 */
typedef void(^PLKPlaidLinkSetupCompletionHandler)(BOOL success,  NSError* _Nullable  error);

@interface PLKPlaidLink : NSObject

/**
 Setup Plaid Link using the shared configuration from Info.plist.
 The method verifies that the configured key is eligible for API use in the given environment
 and retrieves institution data.

 @param completion A block object to be executed when the Plaid Link setup finishes.
                   This block has no return value and takes two arguments:
                   a Boolean arguments that indicates whether or not the setup finished successfully,
                   and an NSError object
 */
+ (void)setupWithSharedConfiguration:(PLKPlaidLinkSetupCompletionHandler)completion;

/**
 Setup Plaid Link using the shared configuration from Info.plist.
 The method verifies that the configured key is eligible for API use in the given environment
 and retrieves institution data.

 @param itemAddToken An item add token replacing the configured public_key.
 @param completion A block object to be executed when the Plaid Link setup finishes.
                   This block has no return value and takes two arguments:
                   a Boolean arguments that indicates whether or not the setup finished successfully,
                   and an NSError object
 */
+ (void)setupWithSharedConfigurationUsingItemAddToken:(NSString*)itemAddToken
                                           completion:(PLKPlaidLinkSetupCompletionHandler)completion;

/**
 Setup Plaid Link using the given custom configuration.
 The method verifies that the configured key is eligible for API use in the given environment
 and retrieves institution data.

 @param configuration A custom configuration object to use.
 @param completion A block object to be executed when the Plaid Link setup finishes.
                   This block has no return value and takes two arguments:
                   a Boolean arguments that indicates whether or not the setup finished successfully,
                   and an NSError object
 */
+ (void)setupWithConfiguration:(PLKConfiguration*)configuration
                    completion:(PLKPlaidLinkSetupCompletionHandler)completion;

/**
 Setup Plaid Link using the given custom configuration.
 The method verifies that the configured key is eligible for API use in the given environment
 and retrieves institution data.

 @param configuration A custom configuration object to use.
 @param itemAddToken An item add token replacing the configured public_key.
 @param completion A block object to be executed when the Plaid Link setup finishes.
                   This block has no return value and takes two arguments:
                   a Boolean arguments that indicates whether or not the setup finished successfully,
                   and an NSError object
 */
+ (void)setupWithConfiguration:(PLKConfiguration*)configuration
                  itemAddToken:(NSString*)itemAddToken
                    completion:(PLKPlaidLinkSetupCompletionHandler)completion;

/**
 Prepares Plaid Link for the update mode using the shared configuration from Info.plist
 The method verifies that the given publicToken is valid.

 @param publicToken An existing user's public token to setup Link in update mode.
 @param completion A block object to be executed when the Plaid Link setup finishes.
                   This block has no return value and takes two arguments:
                   a Boolean arguments that indicates whether or not the setup finished successfully,
                   and an NSError object
 */
+ (void)setupWithPublicToken:(NSString*)publicToken
                  completion:(PLKPlaidLinkSetupCompletionHandler)completion;

/**
 Prepares Plaid Link for the update mode using the shared configuration from Info.plist
 The method verifies that the given publicToken is valid.

 @param publicToken An existing user's public token to setup Link in update mode.
 @param itemAddToken An item add token replacing the configured public_key.
 @param completion A block object to be executed when the Plaid Link setup finishes.
                   This block has no return value and takes two arguments:
                   a Boolean arguments that indicates whether or not the setup finished successfully,
                   and an NSError object
 */
+ (void)setupWithPublicToken:(NSString*)publicToken
                itemAddToken:(NSString*)itemAddToken
                  completion:(PLKPlaidLinkSetupCompletionHandler)completion;

/**
 Prepares Plaid Link for the update mode using the shared configuration from Info.plist
 The method verifies that the given publicToken is valid.

 @param publicToken An existing user's public token to setup Link in update mode.
 @param linkToken A link token replacing the configured public_key.
 @param completion A block object to be executed when the Plaid Link setup finishes.
                   This block has no return value and takes two arguments:
                   a Boolean arguments that indicates whether or not the setup finished successfully,
                   and an NSError object
 */
+ (void)setupWithPublicToken:(NSString*)publicToken
                   linkToken:(NSString*)linkToken
                  completion:(PLKPlaidLinkSetupCompletionHandler)completion;

/**
 Prepares Plaid Link for the update mode using the given custom configuration.
 The method verifies that the given publicToken is valid.

 @param publicToken An existing user's public token to setup Link in update mode.
 @param configuration A custom configuration object to use.
 @param completion A block object to be executed when the Plaid Link setup finishes.
                   This block has no return value and takes two arguments:
                   a Boolean arguments that indicates whether or not the setup finished successfully,
                   and an NSError object
 */
+ (void)setupWithPublicToken:(NSString*)publicToken
               configuration:(PLKConfiguration*)configuration
                  completion:(PLKPlaidLinkSetupCompletionHandler)completion;

/**
 Prepares Plaid Link for the update mode using the given custom configuration.
 The method verifies that the given publicToken is valid.

 @param publicToken An existing user's public token to setup Link in update mode.
 @param itemAddToken An item add token replacing the configured public_key.
 @param configuration A custom configuration object to use.
 @param completion A block object to be executed when the Plaid Link setup finishes.
                   This block has no return value and takes two arguments:
                   a Boolean arguments that indicates whether or not the setup finished successfully,
                   and an NSError object
 */
+ (void)setupWithPublicToken:(NSString*)publicToken
                itemAddToken:(NSString* _Nullable)itemAddToken
               configuration:(PLKConfiguration*)configuration
                  completion:(PLKPlaidLinkSetupCompletionHandler)completion;

/**
 Prepares Plaid Link for the update mode using the given custom configuration.
 The method verifies that the given publicToken is valid.

 @param publicToken An existing user's public token to setup Link in update mode.
 @param linkToken A link token replacing the configured public_key.
 @param configuration A custom configuration object to use.
 @param completion A block object to be executed when the Plaid Link setup finishes.
                   This block has no return value and takes two arguments:
                   a Boolean arguments that indicates whether or not the setup finished successfully,
                   and an NSError object
 */
+ (void)setupWithPublicToken:(NSString*)publicToken
                linkToken:(NSString* _Nullable)linkToken
               configuration:(PLKConfiguration*)configuration
                  completion:(PLKPlaidLinkSetupCompletionHandler)completion;
@end
NS_ASSUME_NONNULL_END
