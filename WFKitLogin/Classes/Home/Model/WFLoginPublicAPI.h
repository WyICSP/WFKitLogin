//
//  WFLoginPublicAPI.h
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/8/9.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFLoginViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFLoginPublicAPI : NSObject

/**
 根视图
 
 @return 登录页面
 */
+ (WFLoginViewController *)rootLoginViewController;

@end

NS_ASSUME_NONNULL_END
