//
//  YFKeyWindow.h
//  YFKit
//
//  Created by 王宇 on 2018/5/16.
//  Copyright © 2018年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YFKeyWindow : NSObject

+ (instancetype) shareInstance;
//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC;

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController;

@end
