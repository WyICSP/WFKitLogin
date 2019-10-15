//
//  WFWebProgressLayer.h
//  WFKitMain_Example
//
//  Created by 王宇 on 2019/10/12.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFWebProgressLayer : CAShapeLayer
//开始加载
-(void)startLoad;
//加载完成
-(void)finishedLoadWithError:(NSError * __nullable)error;
//关闭时间
-(void)closeTimer;

- (void)webViewPathChanged:(CGFloat)estimatedProgress;
@end

NS_ASSUME_NONNULL_END
