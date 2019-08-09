//
//  UIButton+GradientLayer.h
//  WFKit
//
//  Created by 王宇 on 2019/7/19.
//  Copyright © 2019 王宇. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WFButtonGradientType) {
    WFButtonGradientTypeLeftToRight = 0,//上到下
    WFButtonGradientTypeTopToBottom //左到右
};

@interface UIButton (GradientLayer)

/**
 设置按钮颜色渐变

 @param colors 需要渐变的颜色数组 暂时只支持 2 种颜色
 @param btnSize 按钮的大小
 @param cornerRadius 圆角大小 默认为 0
 @param gradientType 渐变的方向
 */
- (void)setGradientLayerWithColors:(NSArray <UIColor *> *)colors
                           btnSize:(CGSize)btnSize
                      cornerRadius:(CGFloat)cornerRadius
                      gradientType:(WFButtonGradientType)gradientType;

@end

NS_ASSUME_NONNULL_END
