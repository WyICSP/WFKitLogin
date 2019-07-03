//
//  WKTabbarController.m
//  WKKit
//
//  Created by 王宇 on 16/9/13.
//  Copyright © 2016年 王宇. All rights reserved.
//
#define TabUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#import "WKTabbarController.h"
#import "WKNavigationController.h"

#import "WKHelp.h"

@interface WKTabbarController ()

@end

@implementation WKTabbarController

+ (instancetype)shareInstance {
    static WKTabbarController *tabbarVC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabbarVC = [[WKTabbarController alloc] init];
    });
    return tabbarVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


/**
 添加子控制器
 
 @param vc                子控制器
 @param normalImageName   普通状态下图片
 @param selectedImageName 选中图片
 */
- (void)addChildVC: (UIViewController *)vc normalImageName: (NSString *)normalImageName selectedImageName:(NSString *)selectedImageName  title:(NSString *)title {
    
    WKNavigationController *nav             = [[WKNavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem                          = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:normalImageName] selectedImage:[UIImage imageNamed:selectedImageName]];
    nav.tabBarItem.titlePositionAdjustment  = UIOffsetMake(0.0f, -3.0f);
    [self addChildViewController:nav];
    
}

/**
 设置 Tabbar title 字体颜色 和大小
 
 @param titleColor 字体颜色
 @param titleFont 字体大小
 */
- (void)setTabbarTitleColor:(UIColor *)titleColor titleFont:(CGFloat)titleFont {
    //默认
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : TabUIColorFromRGB(0x9FA0A1),NSFontAttributeName : [UIFont systemFontOfSize:titleFont]} forState:UIControlStateNormal];
    //选中
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : titleColor,NSFontAttributeName : [UIFont systemFontOfSize:titleFont]} forState:UIControlStateSelected];
}

/**
 *  指定选中这个Tabbar
 *
 */
- (void)appointTabbarIndex:(NSInteger)index {
    
    NSInteger number = self.viewControllers.count;
    if (index >= number|| index<0) {
    }else{
        [self setSelectedIndex:index];
    }
    
}

/**
 *  指定哪一个Tabbar上面有一个小红点。为0 就不显示了
 *
 *  @param badgeValue 数量
 *  @param index      index
 */
- (void)appointbadgeValue:(NSInteger)badgeValue toIndex:(NSInteger)index {
    
    if (badgeValue!=0) {
        NSInteger number = self.viewControllers.count;
        if (index<number) {
            UIViewController *VC = [self.viewControllers objectAtIndex:index];
            VC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",(long)badgeValue];
        }
    } else {
        NSInteger number = self.viewControllers.count;
        if (index<number) {
            UIViewController *VC = [self.viewControllers objectAtIndex:index];
            VC.tabBarItem.badgeValue = nil;
        }
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if ([item.title isEqualToString:@"货源"]) {
//        [YFLoginModel loginWithLoginModeType:1 loginSuccess:^{} loginFailure:^{}];
    }
}



@end
