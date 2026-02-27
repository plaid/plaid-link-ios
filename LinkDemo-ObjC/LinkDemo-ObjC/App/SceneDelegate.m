//
//  SceneDelegate.m
//  LinkDemo-ObjC
//
//  Copyright © 2026 Plaid Inc. All rights reserved.
//

#import "SceneDelegate.h"
#import "ExampleListViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Create the window with the UIWindowScene
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];

    // Create the root view controller
    ExampleListViewController *exampleListVC = [[ExampleListViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:exampleListVC];

    // Set the root view controller and make the window visible
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
}

@end
