//
//  NSTimer+WFAddition.m
//  WFKitMain_Example
//
//  Created by 王宇 on 2019/10/12.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import "NSTimer+WFAddition.h"


@implementation NSTimer (WFAddition)

- (void)pauseTime{
    //判断定时器是否有效
    if (!self.isValid)  {
        return;
    }
    //停止计时器
    [self  setFireDate:[NSDate distantFuture]];
}
- (void)webPageTime{
    //判断定时器是否有效
    if (!self.isValid)  {
        return;
    }
    //返回当期时间
    [self setFireDate:[NSDate date]];
}
- (void)webPageTimeWithTimeInterval:(NSTimeInterval)time{
    //判断定时器是否有效
    if (!self.isValid)  {
        return;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:time]];
}

@end
