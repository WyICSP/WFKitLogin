//
//  YFMediatorManager+YFKitMain.m
//  Pods-YFKitMain_Example
//
//  Created by 王宇 on 2019/1/5.
//

#import "YFMediatorManager+YFKitMain.h"

@implementation YFMediatorManager (YFKitMain)

#pragma mark 主骨架提供的接口
/**
 获取跟视图
 */
+ (UITabBarController *)rootTabBarCcontroller {

    UITabBarController *rootVC = [self performTarget:@"YFMainPublicModelAPI" action:@"rootTabBarCcontroller" params:nil isRequiredReturnValue:YES];
    if (rootVC == nil) {
        NSLog(@"没找到相应的页面");
        abort();
    }
    return rootVC;
}

/**
 添加自控制器
 */
+ (void)addChildVC:(UIViewController *)vc normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName title:(NSString *)title {

    NSArray *pamrs = @[vc,normalImageName,selectedImageName,title];
    [self performTarget:@"YFMainPublicModelAPI" action:@"addChildVC:" params:pamrs isRequiredReturnValue:NO];
}

/**
 设置 Tabbar title 字体颜色 和大小

 @param titleColor 字体颜色
 @param titleFont 字体大小
 */
+ (void)setTabbarTitleColor:(UIColor *)titleColor titleFont:(CGFloat)titleFont {

    NSArray *parms = @[titleColor,@(titleFont)];
    [self performTarget:@"YFMainPublicModelAPI" action:@"setTabbarTitleColorAndFont:" params:parms isRequiredReturnValue:NO];
}

/**
 选中 tarber

 @param index 某一个
 */
+ (void)appointTabbarIndex:(NSInteger)index {
    [self performTarget:@"YFMainPublicModelAPI" action:@"appointTabbarIndex:" params:@(index) isRequiredReturnValue:NO];
}

/**
 *  指定哪一个Tabbar上面有一个小红点。为0 就不显示了
 *
 *  @param badgeValue 数量
 *  @param index      index
 */
+ (void)appointbadgeValue:(NSInteger)badgeValue toIndex:(NSInteger)index {
    NSArray *parms = @[@(badgeValue),@(index)];
    [self performTarget:@"YFMainPublicModelAPI" action:@"appointbadgeValue:" params:parms isRequiredReturnValue:NO];
}

/**
 设置导航栏背景图片

 @param globalImg 背景图片
 */
+ (void)setNavBarGlobalBackGroundImage:(UIImage *)globalImg {
    [self performTarget:@"YFMainPublicModelAPI" action:@"setNavBarGlobalBackGroundImage:" params:globalImg isRequiredReturnValue:NO];
}

/**
 设置导航栏背景颜色

 @param globalColor 背景颜色
 */
+ (void)setGlobalBackGroundColor:(UIColor *)globalColor {
    [self performTarget:@"YFMainPublicModelAPI" action:@"setGlobalBackGroundColor:" params:globalColor isRequiredReturnValue:NO];
}

/**
 设置title 颜色 和大小

 @param textColor 颜色
 @param fontSize 字体大小
 */
+ (void)setNarBarGlobalTextColor:(UIColor *)textColor andFontSize:(CGFloat)fontSize {
    NSArray *parms = @[textColor,@(fontSize)];
    [self performTarget:@"YFMainPublicModelAPI" action:@"setGlobalTextWithFontSize:" params:parms isRequiredReturnValue:NO];
}

+ (void)jumpCtrlWithController:(UIViewController *)controller {
    [self performTarget:@"YFFindPublicAPI" action:@"jumpCtrlWithController:" params:controller isRequiredReturnValue:NO];
}

@end
