//
//  AMAppDelegate.m
//  AMProgressView
//
//  Created by Albert Mata on 15/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import "AMAppDelegate.h"
#import "AMViewController.h"

@implementation AMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[AMViewController alloc] init];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end