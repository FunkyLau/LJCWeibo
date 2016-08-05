//
//  AppDelegate.m
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 16/7/2.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "DiscoverViewController.h"
#import "MessageBoxViewController.h"
#import "MeViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CGRect windowFrame = [UIScreen mainScreen].bounds;
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 20, windowFrame.size.width, windowFrame.size.height-20)];
    //
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    HomeViewController *homeVC = [HomeViewController new];
    DiscoverViewController *discoverVC = [DiscoverViewController new];
    MessageBoxViewController *msgBoxVC = [MessageBoxViewController new];
    MeViewController *meVC = [MeViewController new];
    
    homeVC.controllerState = ControllerStateWithBothButtonAndSearchBar;
    discoverVC.controllerState = ControllerStateWithBothButtonAndSearchBar;
    msgBoxVC.controllerState = ControllerStateWithBothMenuButton;
    meVC.controllerState = ControllerStateWithBothMenuButton;
    
    //UINavigationController *rootNavController = [[UINavigationController alloc] initWithRootViewController:homeVC];
    UITabBarController *rootNavController = [[UITabBarController alloc] init];
    
    
    UITabBarItem *homeItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"close_cha"] tag:1];
    UITabBarItem *msgBoxItem = [[UITabBarItem alloc] initWithTitle:@"消息" image:[UIImage imageNamed:@"close_cha"] tag:2];
    UITabBarItem *marketItem = [[UITabBarItem alloc] initWithTitle:@"探索" image:[UIImage imageNamed:@"close_cha"] tag:3];
    
    UITabBarItem *meItem = [[UITabBarItem alloc] initWithTitle:@"个人" image:[UIImage imageNamed:@"close_cha"] tag:4];
    [homeVC setTabBarItem:homeItem];
    [msgBoxVC setTabBarItem:msgBoxItem];
    [discoverVC setTabBarItem:marketItem];
    [meVC setTabBarItem:meItem];
    
    NSArray *tapBarItems = @[homeVC,msgBoxVC,discoverVC,meVC];
    [rootNavController setViewControllers:tapBarItems];
    
    self.window.rootViewController = rootNavController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
