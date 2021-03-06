//
//  LCAppDelegate.m
//  LegendsCard
//
//  Created by Josh Sklar on 8/21/13.
//  Copyright (c) 2013 LegendsCard. All rights reserved.
//

#import "LCAppDelegate.h"
#import "LCHomeViewController.h"
#import "UIFont+LCFont.h"

@implementation LCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"iJ4cKUTiP5B5avZszjMHHLozSeTkgqPx9cO0reku"
                  clientKey:@"OSor4WNb5AIXDPbTUb2xUsPPzcCxlkX9vgZw5Q4X"];
    [Flurry startSession:@"DKZZ47WH5H6JM79Z4SYC"];
    [Flurry logEvent:@"user-opened-app"];
    
    
    [[UIApplication sharedApplication]
     setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // Set global UINavigationBar and UIBarButtonItem appearance properties
    if ([[UINavigationBar class] respondsToSelector:@selector(appearance)]) {
        [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              [UIColor whiteColor], NSForegroundColorAttributeName,
                                                              [UIFont LC_helveticaLightWithSize:22], NSFontAttributeName,
                                                              nil]];
    }
    
    if ([[UIBarButtonItem class] respondsToSelector:@selector(appearance)]) {
        [[UIBarButtonItem appearance] setTitleTextAttributes:@{
                                                               NSFontAttributeName: [UIFont LC_helveticaLightWithSize:18],
                                                               NSForegroundColorAttributeName: [UIColor whiteColor]
                                                               }
                                                    forState:UIControlStateNormal];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    self.viewController = [[LCHomeViewController alloc] init];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
