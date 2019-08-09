//
//  UIView+Frame.m
//  SKKit
//
//  Created by GCF on 16/4/20.
//  Copyright © 2016年 maxin. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
@dynamic maxX;
@dynamic centerX;

@dynamic maxY;
@dynamic centerY;

/**
 *   xx
 */

- (CGFloat)maxX		{	return CGRectGetMaxX(self.frame);	}
- (CGFloat)centerX	{	return self.center.x;				}
/**
 *   yy
 */

- (CGFloat)maxY		{	return CGRectGetMaxY(self.frame);	}
- (CGFloat)centerY	{	return self.center.y;				}

/**
 *  基本参数
 */
- (CGFloat)x		{	return self.frame.origin.x;			}
- (CGFloat)y		{	return self.frame.origin.y;			}
- (CGFloat)width	{   return CGRectGetWidth(self.frame);  }
- (CGFloat)height	{   return CGRectGetHeight(self.frame); }
- (CGPoint)origin	{   return self.frame.origin;           }
- (CGSize)size		{   return self.frame.size;             }


// 移除所有子视图
- (void)removeAllSubview
{
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}



// xx
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

// yy
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

// width
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

// height
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

// origin
- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

// size
-(void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
-(void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}


- (void)setShape:(CGPathRef)shape
{
    if (shape == nil)
    {
        self.layer.mask = nil;
    }
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = shape;
    self.layer.mask = maskLayer;
}

- (void)setCornerRadiusWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii {
    // 创建贝塞尔曲线，指定绘制区域、角和角半径
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
    // 初始化shapeLayer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    // 设置绘制路径
    shapeLayer.path = bezierPath.CGPath;
    // 将shapeLayer设置为imageView2的layer的mask(遮罩)
    self.layer.mask = shapeLayer;
}

/**
 设置圆角

 @param radius 半径大小
 @param rectCorner 设置的角 上下左右
 @param imageColor 图片的颜色
 @param size 图片的大小
 */
- (void)setRounderCornerWithRadius:(CGFloat)radius
                        rectCorner:(WFRadiusRectCorner)rectCorner
                        imageColor:(UIColor *)imageColor
                              size:(CGSize)size {
    //默认为 0
    CGFloat top_leftRadius = 0.0f;
    CGFloat top_rightRadius = 0.0f;
    CGFloat bottom_leftRadius = 0.0f;
    CGFloat bottom_RightRadius = 0.0f;
    //设置半径值
    if (rectCorner & WFRadiusRectCornerAllCorners) {
        //4个角都设置圆角
        top_leftRadius = top_rightRadius = bottom_leftRadius = bottom_RightRadius = radius;
    }
    
    if (rectCorner & WFRadiusRectCornerTopLeft) {
        //设置左上角圆角
        top_leftRadius = radius;
    }
    if (rectCorner & WFRadiusRectCornerTopRight) {
        //设置右上角圆角
        top_rightRadius = radius;
    }
    if (rectCorner & WFRadiusRectCornerBottomLeft) {
        //设置左下角圆角
        bottom_leftRadius = radius;
    }
    if (rectCorner & WFRadiusRectCornerBottomRight) {
        //设置右上角圆角
        bottom_RightRadius = radius;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef cxt = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(cxt, imageColor.CGColor);
    CGContextSetStrokeColorWithColor(cxt, imageColor.CGColor);
    
    CGContextMoveToPoint(cxt, size.width, size.height-radius);
    CGContextAddArcToPoint(cxt, size.width, size.height, size.width-bottom_RightRadius, size.height, bottom_RightRadius);//右下角
    CGContextAddArcToPoint(cxt, 0, size.height, 0, size.height-bottom_leftRadius, bottom_leftRadius);//左下角
    CGContextAddArcToPoint(cxt, 0, 0, top_leftRadius, 0, top_leftRadius);//左上角
    CGContextAddArcToPoint(cxt, size.width, 0, size.width, top_rightRadius, top_rightRadius);//右上角
    CGContextClosePath(cxt);
    CGContextDrawPath(cxt, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //防止重复添加图片
    for (UIView *view in self.subviews) {
        if (view.tag == 1234) {
            [view removeFromSuperview];
        }
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    imageView.tag = 1234;
    [imageView setImage:image];
    
    //带圆角图像的绘制方法
    [self insertSubview:imageView atIndex:0];
    
}

@end
