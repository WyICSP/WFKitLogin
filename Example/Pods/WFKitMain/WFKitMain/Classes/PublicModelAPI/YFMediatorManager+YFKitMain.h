//
//  YFMediatorManager+YFKitMain.h
//  Pods-YFKitMain_Example
//
//  Created by 王宇 on 2019/1/5.
//

#import <WFBasics/YFMediatorManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFMediatorManager (YFKitMain)

/**
 获取根控制器

 @return UITabBarController
 */
+ (UITabBarController *)rootTabBarCcontroller;

/**
 添加子控制器

 @param vc                子控制器
 @param normalImageName   普通状态下图片
 @param selectedImageName 选中图片
 */
+ (void)addChildVC: (UIViewController *)vc normalImageName: (NSString *)normalImageName selectedImageName:(NSString *)selectedImageName  title:(NSString *)title;

/**
 设置 Tabbar title 字体颜色 和大小

 @param titleColor 字体颜色
 @param titleFont 字体大小
 */
+ (void)setTabbarTitleColor:(UIColor *)titleColor titleFont:(CGFloat)titleFont;

/**
 *  指定选中这个Tabbar
 *
 */
+ (void)appointTabbarIndex:(NSInteger)index;

/**
 *  指定哪一个Tabbar上面有一个小红点。为0 就不显示了
 *
 *  @param badgeValue 数量
 *  @param index      index
 */
+ (void)appointbadgeValue:(NSInteger)badgeValue toIndex:(NSInteger)index;

/**
 设置导航栏背景图片

 @param globalImg 背景图片
 */
+ (void)setNavBarGlobalBackGroundImage:(UIImage *)globalImg;

/**
 设置导航栏背景颜色

 @param globalColor 背景颜色
 */
+ (void)setGlobalBackGroundColor:(UIColor *)globalColor;

/**
 设置导航栏的字体大小和颜色

 @param textColor 字体颜色
 @param fontSize 字体大小
 */
+ (void)setNarBarGlobalTextColor:(UIColor *)textColor andFontSize:(CGFloat)fontSize;

/**
 组件通信测试

 @param controller 跳转的页面
 */
+ (void)jumpCtrlWithController:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END
