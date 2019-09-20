//
//  SVProgressHUD+YFHud.m
//  YFBasicComponents_Example
//
//  Created by 王宇 on 2018/12/28.
//  Copyright © 2018 wyxlh. All rights reserved.
//

#import "SVProgressHUD+YFHud.h"

@implementation SVProgressHUD (YFHud)

+ (void)load {
    [SVProgressHUD setMinimumSize:CGSizeMake(100, 100)];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    //不允许用户操作 当HUD显示的时候，不允许用户交互，且显示渐变的背景图层。
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

@end
