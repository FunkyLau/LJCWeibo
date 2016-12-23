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
#import "MMDrawerController.h"
#import "MeViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "MMNavigationController.h"
#import "LeftViewController.h"

@interface AppDelegate ()
@property (nonatomic,strong) MMDrawerController *drawerController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CGRect windowFrame = [UIScreen mainScreen].bounds;
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, windowFrame.size.width, windowFrame.size.height)];
    //
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //创建沙盒必要目录
    [PathUtil ensureLocalDirsPresent];
    //监听网络状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[UINavigationBar appearance] setBarTintColor:DEFAULT_COLOR];
    
    [self initMainController];
    //self.window.rootViewController = rootNavController;
    UIViewController *tempRootClr = _drawerController;
    self.window.rootViewController = tempRootClr;
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

- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    NSString * key = [identifierComponents lastObject];
    if([key isEqualToString:@"MMDrawer"]){
        return self.window.rootViewController;
    }
    else if ([key isEqualToString:@"MMExampleCenterNavigationControllerRestorationKey"]) {
        return ((MMDrawerController *)self.window.rootViewController).centerViewController;
    }
    else if ([key isEqualToString:@"MMExampleRightNavigationControllerRestorationKey"]) {
        return ((MMDrawerController *)self.window.rootViewController).rightDrawerViewController;
    }
    else if ([key isEqualToString:@"MMExampleLeftNavigationControllerRestorationKey"]) {
        return ((MMDrawerController *)self.window.rootViewController).leftDrawerViewController;
    }
    else if ([key isEqualToString:@"MMExampleLeftSideDrawerController"]){
        UIViewController * leftVC = ((MMDrawerController *)self.window.rootViewController).leftDrawerViewController;
        if([leftVC isKindOfClass:[UINavigationController class]]){
            return [(UINavigationController*)leftVC topViewController];
        }
        else {
            return leftVC;
        }
        
    }
    else if ([key isEqualToString:@"MMExampleRightSideDrawerController"]){
        UIViewController * rightVC = ((MMDrawerController *)self.window.rootViewController).rightDrawerViewController;
        if([rightVC isKindOfClass:[UINavigationController class]]){
            return [(UINavigationController*)rightVC topViewController];
        }
        else {
            return rightVC;
        }
    }
    return nil;
}

-(void)initMainController {
    UITabBarController *mainVC = [self buildRootNavigationController];
    [mainVC setRestorationIdentifier:@"MMExampleCenterNavigationControllerRestorationKey"];
    
    // left ui
    UIViewController *leftVC = [LeftViewController new];
    [leftVC setRestorationIdentifier:@"MMExampleLeftNavigationControllerRestorationKey"];
    
    // root view controller
    MMDrawerController *rootVC = [[MMDrawerController alloc]
                                  initWithCenterViewController:mainVC
                                  leftDrawerViewController:leftVC];
    self.drawerController = rootVC;
    [rootVC setShowsShadow:NO];
    [rootVC setRestorationIdentifier:@"MMDrawer"];
    [rootVC setMaximumLeftDrawerWidth:kScreenWidth/2];
    [rootVC setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [rootVC setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [rootVC setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager]
                 drawerVisualStateBlockForDrawerSide:drawerSide];
        if(block){
            block(drawerController, drawerSide, percentVisible);
        }
    }];
}

-(UITabBarController *)buildRootNavigationController{
    HomeViewController *homeVC = [HomeViewController new];
    DiscoverViewController *discoverVC = [DiscoverViewController new];
    MessageBoxViewController *msgBoxVC = [MessageBoxViewController new];
    MeViewController *meVC = [MeViewController new];
    
    homeVC.controllerState = ControllerStateWithBothMenuButton;
    discoverVC.controllerState = ControllerStateWithRightButtonAndSearchBar;
    msgBoxVC.controllerState = ControllerStateShowLogo;
    meVC.controllerState = DHCtrlState_TopBar|DHCtrlState_TopBar_Title;
    
    //UINavigationController *rootNavController = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    
    UITabBarController *rootNavController = [[UITabBarController alloc] init];
    UITabBarItem *homeItem = [[UITabBarItem alloc] initWithTitle:@"主页" image:[UIImage imageNamed:@"home_tab_icon_1"] tag:1];
    UITabBarItem *msgBoxItem = [[UITabBarItem alloc] initWithTitle:@"消息" image:[UIImage imageNamed:@"home_tab_icon_2"] tag:2];
    UITabBarItem *marketItem = [[UITabBarItem alloc] initWithTitle:@"探索" image:[UIImage imageNamed:@"home_tab_icon_3"] tag:3];
    
    UITabBarItem *meItem = [[UITabBarItem alloc] initWithTitle:@"个人" image:[UIImage imageNamed:@"home_tab_icon_4"] tag:4];
    [homeVC setTabBarItem:homeItem];
    [msgBoxVC setTabBarItem:msgBoxItem];
    [discoverVC setTabBarItem:marketItem];
    [meVC setTabBarItem:meItem];
    
    NSArray *tapBarItems = @[homeVC,msgBoxVC,discoverVC,meVC];
    [rootNavController setViewControllers:tapBarItems];
    
    return rootNavController;
}

@end
