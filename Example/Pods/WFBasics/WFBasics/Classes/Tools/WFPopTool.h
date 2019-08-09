//
//  WFPopTool.h
//  WFKit
//
//  Created by 王宇 on 2019/4/24.
//  Copyright © 2019 王宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFPopTool : NSObject

+ (instancetype)sharedInstance;

/**
 *
 *  弹出视图
 *
 *  @param view     被弹出的视图
 *  @param animated 是否需要动画
 */
- (void)popView:(UIView *)view animated:(BOOL)animated;

/**
 *
 *  关闭视图
 *
 *  @param animated 是否需要动画
 */
- (void)closeAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
