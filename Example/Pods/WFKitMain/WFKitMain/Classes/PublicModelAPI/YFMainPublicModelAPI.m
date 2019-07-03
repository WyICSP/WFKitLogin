//
//  YFMainPublicModelAPI.m
//
//  Created by 王宇 on 2018/11/27.
//  Copyright © 2018 wy. All rights reserved.
//

#import "YFMainPublicModelAPI.h"
#import "WKTabbarController.h"
#import "WKNavigationController.h"

@implementation YFMainPublicModelAPI

+ (UITabBarController *)rootTabBarCcontroller {
   return [WKTabbarController shareInstance];
}

+ (void)addChildVC:(UIViewController *)vc normalImageName: (NSString *)normalImageName selectedImageName:(NSString *)selectedImageName  title:(NSString *)title {
    [[WKTabbarController shareInstance] addChildVC:vc normalImageName:normalImageName selectedImageName:selectedImageName title:title];
}

+ (void)addChildVC:(NSArray *)parms {
    //获取到控制器
    UIViewController *vc = parms[0];
    //获取到正常的tabbar 图片的名字
    NSString *normalImageName = parms[1];
    //获取到选中的tabbar 图片的名字
    NSString *selectedImageName = parms[2];
    //获取到 title
    NSString *title = parms[3];
    [self addChildVC:vc normalImageName:normalImageName selectedImageName:selectedImageName title:title];
}

+ (void)setTabbarTitleColor:(UIColor *)titleColor titleFont:(CGFloat)titleFont {
    [[WKTabbarController shareInstance] setTabbarTitleColor:titleColor titleFont:titleFont];
}

+ (void)setTabbarTitleColorAndFont:(NSArray *)parms {
    //得到字体颜色
    UIColor *titleColor = [parms firstObject];
    //得到字体大小
    CGFloat font = [[parms lastObject] doubleValue];
    
    [self setTabbarTitleColor:titleColor titleFont:font];
}

+ (void)appointTabbarIndex:(NSNumber *)index {
    [[WKTabbarController shareInstance] appointTabbarIndex:index.integerValue];
}

+ (void)appointbadgeValue:(NSNumber *)badgeValue toIndex:(NSNumber *)index {
    [[WKTabbarController shareInstance] appointbadgeValue:badgeValue.integerValue toIndex:index.integerValue];
}

+ (void)appointbadgeValue:(NSArray *)parms {
    //得到badgeValue
    NSNumber *badgeValue = [parms firstObject];
    //得到index
    NSNumber *index = [parms lastObject];
    [self appointbadgeValue:badgeValue toIndex:index];
}

+ (void)setNavBarGlobalBackGroundImage:(UIImage *)globalImg {
    [WKNavigationController setGlobalBackGroundImage:globalImg];
}

+ (void)setGlobalBackGroundColor:(UIColor *)globalColor {
    [WKNavigationController setGlobalBackGroundColor:globalColor];
}

+ (void)setNarBarGlobalTextColor:(UIColor *)textColor andFontSize:(CGFloat)fontSize {
    [WKNavigationController setGlobalTextColor:textColor andFontSize:fontSize];
}

+ (void)setGlobalTextWithFontSize:(NSArray *)parms {
    //得到 titleColor
    UIColor *titleColor = [parms firstObject];
    //得到 title 字体大小
    CGFloat fontSize = [[parms lastObject] doubleValue];
    //设置字体颜色
    [self setNarBarGlobalTextColor:titleColor andFontSize:fontSize];
}

@end
