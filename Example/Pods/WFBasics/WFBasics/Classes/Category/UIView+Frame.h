//
//  UIView+Frame.h
//  SKKit
//
//  Created by GCF on 16/4/20.
//  Copyright © 2016年 maxin. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, WFRadiusRectCorner) {
    WFRadiusRectCornerTopLeft     = 1 << 0,
    WFRadiusRectCornerTopRight    = 1 << 1,
    WFRadiusRectCornerBottomLeft  = 1 << 2,
    WFRadiusRectCornerBottomRight = 1 << 3,
    WFRadiusRectCornerAllCorners  = 1 << 10
};

@interface UIView (Frame)
/**
 *  重写系统的UIView的frame下各个属性的set,get方法,方便直接修改视图的位置和大小
 */
@property (nonatomic, assign) CGFloat  x;
@property (nonatomic, assign) CGFloat  y;
@property (nonatomic, assign) CGFloat  width;
@property (nonatomic, assign) CGFloat  height;

@property (nonatomic, assign) CGFloat  maxX;
@property (nonatomic, assign) CGFloat  centerX;

@property (nonatomic, assign) CGFloat  maxY;
@property (nonatomic, assign) CGFloat  centerY;
@property (nonatomic, assign) CGPoint  origin;
@property (nonatomic, assign) CGSize  size;

/**
 *  移除子视图
 */
-(void)removeAllSubview;

- (void)setShape:(CGPathRef)shape;

/**
设置 view 圆角

 @param rect  view 的 CGRect
 @param corners 圆角方向
 @param cornerRadii 圆角大小
 */
- (void)setCornerRadiusWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

/**
 设置圆角 推荐使用 不会造成离屏渲染
 
 @param radius 半径大小
 @param rectCorner 设置的角 上下左右
 @param imageColor 图片的颜色
 @param size 图片的大小
 */
- (void)setRounderCornerWithRadius:(CGFloat)radius
                        rectCorner:(WFRadiusRectCorner)rectCorner
                        imageColor:(UIColor *)imageColor
                              size:(CGSize)size;
@end
