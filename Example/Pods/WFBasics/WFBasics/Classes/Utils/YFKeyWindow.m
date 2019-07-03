//
//  YFKeyWindow.m
//  YFKit
//
//  Created by 王宇 on 2018/5/16.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "YFKeyWindow.h"

static YFKeyWindow *_instance = nil;

@implementation YFKeyWindow


#pragma mark 登录
-(void)login {
//    YFLoginViewController *userLogin            = [YFLoginViewController new];
//    userLogin.isLoginOut                        = YES;
//    AppDelegate *Delegate                       = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    WKTabbarController *wkTabbar                = Delegate.tabbar;
//    WKNavigationController *navUserlogin        = [[WKNavigationController alloc]initWithRootViewController:userLogin];
//    [wkTabbar.selectedViewController presentViewController:navUserlogin animated:YES completion:nil];
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    }) ;
    return _instance ;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [YFKeyWindow shareInstance] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [YFKeyWindow shareInstance] ;
}

@end
