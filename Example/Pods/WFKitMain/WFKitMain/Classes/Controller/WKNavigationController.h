//
//  WKNavigationController.h
//  WKKit
//
//  Created by 王宇 on 16/9/14.
//  Copyright © 2016年 王宇. All rights reserved.
//  在 0.1.2 版本之后就废弃掉了

#import <UIKit/UIKit.h>

@interface WKNavigationController : UINavigationController

/**
 设置背景图片

 @param globalImg 背景图片 设置背景图片 44.0 + [[UIApplication sharedApplication] statusBarFrame].size.height == 88.0 表示为刘海屏
 */
+ (void)setGlobalBackGroundImage:(UIImage *)globalImg;

/**
 设置背景颜色

 @param globalColor 颜色
 */
+ (void)setGlobalBackGroundColor:(UIColor *)globalColor;

/**
 设置字体大小和字体y颜色

 @param textColor 字体颜色
 @param fontSize 字体大小
 */
+ (void)setGlobalTextColor:(UIColor *)textColor andFontSize:(CGFloat)fontSize;

@end
