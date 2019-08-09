//
//  YFFunctionPublicAPI.m
//  YFFunction_Example
//
//  Created by 王宇 on 2018/12/4.
//  Copyright © 2018 wyxlh. All rights reserved.
//

#import "YFFunctionPublicAPI.h"
#import "AttributedLbl.h"
#import "YFToast.h"

@implementation YFFunctionPublicAPI

#pragma mark 设置富文本
+ (void)setRichText:(UILabel *)lable titleString:(NSString *)titleString textFont:(UIFont *)textFont fontRang:(NSRange)fontRang textColor:(UIColor *)textColor colorRang:(NSRange)colorRang {
    
    [AttributedLbl setRichText:lable titleString:titleString textFont:textFont fontRang:fontRang textColor:textColor colorRang:colorRang];
}

+ (void)setRichTwoText:(UILabel *)lable titleString:(NSString *)titleString textFirstFont:(UIFont *)textFirstFont fontFirstRang:(NSRange)fontFirstRang textFirstColor:(UIColor *)textFirstColor colorFirstRang:(NSRange)colorFirstRang textSecondFont:(UIFont *)textSecondFont fontSecondRang:(NSRange)fontSecondRang textSecondColor:(UIColor *)textSecondColor colorSecondRang:(NSRange)colorSecondRang {
    
    [AttributedLbl setRichTwoText:lable titleString:titleString textFirstFont:textFirstFont fontFirstRang:fontFirstRang textFirstColor:textFirstColor colorFirstRang:colorFirstRang textSecondFont:textSecondFont fontSecondRang:fontSecondRang textSecondColor:textSecondColor colorSecondRang:colorSecondRang];
}

+ (void)setRichTextTwoTypsFontAndColor:(UILabel *)lable titleString:(NSString *)titleString  textColor:(UIColor *)textColor colorRang:(NSRange)colorRang textFirstFont:(UIFont *)textFirstFont fontFirstRang:(NSRange)fontFirstRang  textSecondFont:(UIFont *)textSecondFont fontSecondRang:(NSRange)fontSecondRang {
    
    [AttributedLbl setRichTextTwoTypsFontAndColor:lable titleString:titleString textColor:textColor colorRang:colorRang textFirstFont:textFirstFont fontFirstRang:fontFirstRang textSecondFont:textSecondFont fontSecondRang:fontSecondRang];
}

+ (void)setRichTextOnlyColor:(UILabel *)lable titleString:(NSString *)titleString textColor:(UIColor *)textColor colorRang:(NSRange)colorRang {
    
    [AttributedLbl setRichTextOnlyColor:lable titleString:titleString textColor:textColor colorRang:colorRang];
}

+ (void)setRichTextOnlyFont:(UILabel *)lable titleString:(NSString *)titleString textFont:(UIFont *)textFont fontRang:(NSRange)fontRang {
    
    [AttributedLbl setRichTextOnlyFont:lable titleString:titleString textFont:textFont fontRang:fontRang];
}

+ (void)setRiChLineSpacing:(UILabel *)lable titleString:(NSString *)titleString textColor:(UIColor *)textColor colorRang:(NSRange)colorRang LineSpacing:(CGFloat )LineSpacing {
    
    [AttributedLbl setRiChLineSpacing:lable titleString:titleString textColor:textColor colorRang:colorRang LineSpacing:LineSpacing];
}

#pragma mark 弹出视图
/**
 只需要传信息 显示在 window 上
 */
+ (void)showMessage:(NSString *)msg {
    [YFToast showMessage:msg];
}

/**
 需要传信息 + View 显示在View 上
 */
+ (void)showMessage:(NSString *)msg inView:(UIView *)view {
    [YFToast showMessage:msg inView:view];
}

/**
 需要传信息 + View  + 时间显示在View 上
 */
+ (void)showMessage:(NSString *)msg inView:(UIView *)view duration:(NSTimeInterval)duration {
    [YFToast showMessage:msg inView:view duration:duration];
}

@end
