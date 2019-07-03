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
 
}

@end
