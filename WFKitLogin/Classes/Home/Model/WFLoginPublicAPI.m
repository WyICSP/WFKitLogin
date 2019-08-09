//
//  WFLoginPublicAPI.m
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/8/9.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import "WFLoginPublicAPI.h"

@implementation WFLoginPublicAPI

/**
 根视图
 
 @return 登录页面
 */
+ (WFLoginViewController *)rootLoginViewController {
    return [WFLoginViewController shareInstance];
}

@end
