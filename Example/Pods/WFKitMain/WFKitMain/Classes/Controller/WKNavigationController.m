//
//  WKNavigationController.m
//  WKKit
//
//  Created by 王宇 on 16/9/14.
//  Copyright © 2016年 王宇. All rights reserved.
//

#import "WKNavigationController.h"

@interface WKNavigationController ()

@end

@implementation WKNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationBar.translucent = NO;
    
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

+ (void)setGlobalBackGroundColor:(UIColor *)globalColor{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    [navBar setBarTintColor:globalColor];
}

+ (void)setGlobalBackGroundImage:(UIImage *)globalImg {
    if (@available(iOS 9.0, *)) {
        UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
        [navBar setBackgroundImage:globalImg forBarMetrics:UIBarMetricsDefault];
        
    } else {
        // Fallback on earlier versions
    }
}

+ (void)setGlobalTextColor:(UIColor *)textColor andFontSize:(CGFloat)fontSize {
    if (@available(iOS 9.0, *)) {
        UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
        [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:textColor}];
    } else {
        // Fallback on earlier versions
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
