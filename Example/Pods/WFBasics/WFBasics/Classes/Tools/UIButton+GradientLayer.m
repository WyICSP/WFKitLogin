//
//  UIButton+GradientLayer.m
//  WFKit
//
//  Created by 王宇 on 2019/7/19.
//  Copyright © 2019 王宇. All rights reserved.
//

#import "UIButton+GradientLayer.h"

@implementation UIButton (GradientLayer)

- (void)setGradientLayerWithColors:(NSArray <UIColor *> *)colors
                            cornerRadius:(CGFloat)cornerRadius
                            gradientType:(WFButtonGradientType)gradientType {
    //将颜色转为CGColor
    NSMutableArray *ags = [[NSMutableArray alloc] init];
    for(UIColor *c in colors) {
        [ags addObject:(id)c.CGColor];
    }
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors     = ags;
    //设置渐变的区域
    gradientLayer.locations  = @[@0.0, @1.0];
    if (gradientType == WFButtonGradientTypeLeftToRight) {
        //起始点
        gradientLayer.startPoint = CGPointMake(0, 0);
        //终点
        gradientLayer.endPoint   = CGPointMake(1.0, 0);
    }else {
        //起始点
        gradientLayer.startPoint = CGPointMake(0, 0);
        //终点
        gradientLayer.endPoint   = CGPointMake(0, 1.0);
    }
    //设置渐变的frame
//    gradientLayer.frame      = CGRectMake(0, 0, 95, 22);
    // 20191020   frame (0, 0, 95, 22) 修改为 self.bounds
    gradientLayer.frame        = self.bounds;
    gradientLayer.cornerRadius = cornerRadius;
    [self.layer addSublayer:gradientLayer];
}




/**
 设置按钮颜色渐变  适配xib 画的button

 @param colors 需要渐变的颜色数组 暂时只支持 2 种颜色
 @param cornerRadius 圆角大小 默认为 0
 @param gradientType 渐变的方向
 @param size 宽高
 */

- (void)setGradientLayerWithColors:(NSArray <UIColor *> *)colors
                            cornerRadius:(CGFloat)cornerRadius
                      gradientType:(WFButtonGradientType)gradientType withSize:(CGSize)size {
    
        //将颜色转为CGColor
        NSMutableArray *ags = [[NSMutableArray alloc] init];
        for(UIColor *c in colors) {
            [ags addObject:(id)c.CGColor];
        }
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors     = ags;
        //设置渐变的区域
        gradientLayer.locations  = @[@0.0, @1.0];
        if (gradientType == WFButtonGradientTypeLeftToRight) {
            //起始点
            gradientLayer.startPoint = CGPointMake(0, 0);
            //终点
            gradientLayer.endPoint   = CGPointMake(1.0, 0);
        }else {
            //起始点
            gradientLayer.startPoint = CGPointMake(0, 0);
            //终点
            gradientLayer.endPoint   = CGPointMake(0, 1.0);
        }
        //设置渐变的frame
       
        gradientLayer.frame =  (size.width == 0&&size.height ==0) ? self.bounds : CGRectMake(0, 0, size.width, size.height);
    
        gradientLayer.cornerRadius = cornerRadius;
        [self.layer addSublayer:gradientLayer];
    
    
    
}



@end
