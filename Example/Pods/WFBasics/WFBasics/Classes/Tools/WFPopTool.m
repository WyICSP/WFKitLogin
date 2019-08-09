//
//  WFPopTool.m
//  WFKit
//
//  Created by 王宇 on 2019/4/24.
//  Copyright © 2019 王宇. All rights reserved.
//

#import "WFPopTool.h"

@interface WFPopTool ()
@property (nonatomic, strong) UIView *currentView;
@end

@implementation WFPopTool

+ (instancetype)sharedInstance {
    static WFPopTool *_popTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _popTool = [[WFPopTool alloc] init];
    });
    return _popTool;
}

- (void)popView:(UIView *)view animated:(BOOL)animated {
    _currentView = view;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    UIView *mainView = [[UIView alloc] initWithFrame:keyWindow.bounds];
    mainView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.5];
    mainView.tag = 123456;
    [keyWindow addSubview:mainView];
    
    CGFloat halfScreenWidth = [[UIScreen mainScreen] bounds].size.width * 0.5;
    CGFloat halfScreenHeight = [[UIScreen mainScreen] bounds].size.height * 0.5;
    // 屏幕中心
    CGPoint screenCenter = CGPointMake(halfScreenWidth, halfScreenHeight);
    view.center = screenCenter;
    [keyWindow addSubview:view];
    
    
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.6;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:popAnimation forKey:nil];
}

- (void)closeAnimated:(BOOL)animated {
    if (animated) {
        //        [UIView animateWithDuration:0.2 animations:^{
        //            _currentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
        //        } completion:^(BOOL finished) {
        //            [UIView animateWithDuration:0.3 animations:^{
        //                _currentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        //            } completion:^(BOOL finished) {
        [_currentView removeFromSuperview];
        _currentView = nil;
        //            }];
        //        }];
    } else {
        [_currentView removeFromSuperview];
        _currentView = nil;
    }
    
    //移除背景透明 View
    UIView * updateview  = [[UIApplication sharedApplication].keyWindow viewWithTag:123456];
    [updateview removeFromSuperview];
    updateview = nil;
}

@end
