//
//  NSTimer+WFAddition.h
//  WFKitMain_Example
//
//  Created by 王宇 on 2019/10/12.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (WFAddition)

/** 暂停时间 */
- (void)pauseTime;
/** 获取内容所在当前时间 */
- (void)webPageTime;
/** 当前时间 time 秒后的时间 */
- (void)webPageTimeWithTimeInterval:(NSTimeInterval)time;

@end

NS_ASSUME_NONNULL_END
