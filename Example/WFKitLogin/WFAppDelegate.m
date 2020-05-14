//
//  WFAppDelegate.m
//  WFKitLogin
//
//  Created by wyxlh on 04/15/2019.
//  Copyright (c) 2019 wyxlh. All rights reserved.
//

#import "WFAppDelegate.h"
#import "WFLoginViewController.h"
#import "YFMainPublicModelAPI.h"
#import "WFViewController.h"
#import "WKNavigationController.h"
#import "WFUserCenterViewController.h"
#import "WFNewHomeViewController.h"
#import "YFMediatorManager+YFKitMain.h"

@implementation WFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //去掉导航栏的黑线
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
//    //创建window
//    UIWindow *window                         = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.window                              = window;
//    [self.window setBackgroundColor:[UIColor whiteColor]];
////    WFLoginViewController *login     = [WFLoginViewController shareInstance];
//    WFNewHomeViewController *home     = [[WFNewHomeViewController alloc] init];
//    self.window.rootViewController    = [[WKNavigationController alloc] initWithRootViewController:home];
//    [YFMainPublicModelAPI setGlobalBackGroundColor:UIColor.whiteColor];
//    [YFMainPublicModelAPI setNarBarGlobalTextColor:UIColor.blackColor andFontSize:18.0f];
    
    [self createTabbar];
//    UITabBarController *rootVC        = [YFMainPublicModelAPI rootTabBarCcontroller];
//    [YFMainPublicModelAPI addChildVC:login normalImageName:@"" selectedImageName:@"" title:@"登录"];
//    [YFMainPublicModelAPI addChildVC:[WFUserCenterViewController new] normalImageName:@"" selectedImageName:@"" title:@"我的片区"];
//    [YFMainPublicModelAPI addChildVC:[WFUserCenterViewController new] normalImageName:@"" selectedImageName:@"" title:@"我的"];
//    [YFMainPublicModelAPI setGlobalBackGroundColor:[UIColor whiteColor]];
//    [YFMainPublicModelAPI setNarBarGlobalTextColor:[UIColor blackColor] andFontSize:18];
//
//    [self.window setRootViewController:rootVC];
    
    
    [self.window makeKeyAndVisible];
    return YES;
}


- (double)decimalNumberWithDouble:(double)conversionValue {
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber doubleValue];
}

#pragma mark 创建tabbar
-(void)createTabbar{
    
    //去掉导航栏的黑线
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    //创建window
    UIWindow *window                         = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window                              = window;
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    // 取出沙盒中存储的上次使用软件的版本号
//    NSUserDefaults *defaults                 = [NSUserDefaults standardUserDefaults];
//    NSString *lastVersion                    = [defaults stringForKey:key];
//    // 获得当前软件的版本号
//    NSString *currentVersion                 = [NSString getAppVersion];
        //如果没有登录
        WFLoginViewController *login     = [WFLoginViewController shareInstance];
            UITabBarController *rootVC        = [YFMediatorManager rootTabBarCcontroller];
            [YFMediatorManager addChildVC:login normalImageName:@"videoImg" selectedImageName:@"videoImg" title:@"商城"];
            [YFMediatorManager addChildVC:[WFNewHomeViewController new] normalImageName:@"videoImg" selectedImageName:@"videoImg" title:@"我的"];
            [YFMediatorManager setGlobalBackGroundColor:[UIColor whiteColor]];
            [YFMediatorManager setNarBarGlobalTextColor:[UIColor blackColor] andFontSize:18];
            
            [self.window setRootViewController:rootVC];
    
    [self.window makeKeyAndVisible];
    
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
