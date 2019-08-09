//
//  YFFunctionPublicAPI.h
//  YFFunction_Example
//
//  Created by 王宇 on 2018/12/4.
//  Copyright © 2018 wyxlh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFFunctionPublicAPI : NSObject

#pragma mark 设置富文本
/**
 适用于一个字符串中有两种颜色的 并且字体大小不一样的
 */
+ (void)setRichText:(UILabel *)lable titleString:(NSString *)titleString textFont:(UIFont *)textFont fontRang:(NSRange)fontRang textColor:(UIColor *)textColor colorRang:(NSRange)colorRang;

/**
 适用于一个字符串中有两种颜色的但是不是在一个位置的中间有被叉开  并且字体大小不一样的
 比如 今天我花了¥100元 在路上捡了¥50元 数字变颜色 其实这样写比较麻烦  可以直接用第一种 自己去计算下第二个数字的下标就可以了
 */
+ (void)setRichTwoText:(UILabel *)lable titleString:(NSString *)titleString textFirstFont:(UIFont *)textFirstFont fontFirstRang:(NSRange)fontFirstRang textFirstColor:(UIColor *)textFirstColor colorFirstRang:(NSRange)colorFirstRang textSecondFont:(UIFont *)textSecondFont fontSecondRang:(NSRange)fontSecondRang textSecondColor:(UIColor *)textSecondColor colorSecondRang:(NSRange)colorSecondRang;

/**
 适用于两种字体大小 一种颜色 比如 原价¥100  ¥字体为12号 100位18号, 原价14号
 */
+ (void)setRichTextTwoTypsFontAndColor:(UILabel *)lable titleString:(NSString *)titleString  textColor:(UIColor *)textColor colorRang:(NSRange)colorRang textFirstFont:(UIFont *)textFirstFont fontFirstRang:(NSRange)fontFirstRang  textSecondFont:(UIFont *)textSecondFont fontSecondRang:(NSRange)fontSecondRang;

/**
 只设置颜色的不同
 */
+ (void)setRichTextOnlyColor:(UILabel *)lable titleString:(NSString *)titleString  textColor:(UIColor *)textColor colorRang:(NSRange)colorRang;

/**
 只设置字体的不同
 */
+ (void)setRichTextOnlyFont:(UILabel *)lable titleString:(NSString *)titleString  textFont:(UIFont *)textFont fontRang:(NSRange)fontRang;

/**
 设置行间距
 */
+ (void)setRiChLineSpacing:(UILabel *)lable titleString:(NSString *)titleString textColor:(UIColor *)textColor colorRang:(NSRange)colorRang LineSpacing:(CGFloat )LineSpacing;

#pragma mark 弹出视图
/**
 只需要传信息 显示在 window 上
 */
+ (void)showMessage:(NSString *)msg;

/**
 需要传信息 + View 显示在View 上
 */
+ (void)showMessage:(NSString *)msg inView:(UIView *)view;

/**
 需要传信息 + View  + 时间显示在View 上
 */
+ (void)showMessage:(NSString *)msg inView:(UIView *)view duration:(NSTimeInterval)duration;

@end

NS_ASSUME_NONNULL_END
