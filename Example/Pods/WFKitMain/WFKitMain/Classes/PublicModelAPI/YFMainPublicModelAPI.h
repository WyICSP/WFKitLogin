//
//  YFMainPublicModelAPI.h
//  YFKit
//
//  Created by 王宇 on 2018/11/27.
//  Copyright © 2018 wy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFMainPublicModelAPI : NSObject

/**
 获取根控制器
 
 @return rootTabBarCcontroller
 */
+ (UITabBarController *)rootTabBarCcontroller;

/**
 添加子控制器
 
 @param vc                子控制器
 @param normalImageName   普通状态下图片
 @param selectedImageName 选中图片
 */
+ (void)addChildVC:(UIViewController *)vc normalImageName: (NSString *)normalImageName selectedImageName:(NSString *)selectedImageName  title:(NSString *)title;

+ (void)addChildVC:(NSArray *)parms;

/**
 设置 Tabbar title 字体颜色 和大小
 
 @param titleColor 字体颜色
 @param titleFont 字体大小
 */
+ (void)setTabbarTitleColor:(UIColor *)titleColor titleFont:(CGFloat)titleFont;

+ (void)setTabbarTitleColorAndFont:(NSArray *)parms;

/**
 *  指定选中这个Tabbar 这里使用NSNumber 是为了在使用 targetaAction 的时候 值不会改变
 *
 */
+ (void)appointTabbarIndex:(NSNumber *)index;

/**
 *  指定哪一个Tabbar上面有一个小红点。为0 就不显示了
 *
 *  @param badgeValue 数量
 *  @param index      这里使用NSNumber 是为了在使用 targetaAction 的时候 值不会改变
 */
+ (void)appointbadgeValue:(NSNumber *)badgeValue toIndex:(NSNumber *)index;

+ (void)appointbadgeValue:(NSArray *)parms;

/**
 设置导航栏背景图片

 @param globalImg 背景图片
 */
+ (void)setNavBarGlobalBackGroundImage:(UIImage *)globalImg;

/**
 设置背景颜色
 
 @param globalColor 背景颜色
 */
+ (void)setGlobalBackGroundColor:(UIColor *)globalColor;

/**
 设置导航栏的字体大小和颜色

 @param textColor 字体颜色
 @param fontSize 字体大小
 */
+ (void)setNarBarGlobalTextColor:(UIColor *)textColor andFontSize:(CGFloat)fontSize;

+ (void)setGlobalTextWithFontSize:(NSArray *)parms;

@end

NS_ASSUME_NONNULL_END
