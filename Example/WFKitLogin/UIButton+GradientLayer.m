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
                           btnSize:(CGSize)btnSize
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
    gradientLayer.frame      = CGRectMake(0, 0, btnSize.width, btnSize.height);
    gradientLayer.cornerRadius = cornerRadius;
    [self.layer addSublayer:gradientLayer];
}

@end
