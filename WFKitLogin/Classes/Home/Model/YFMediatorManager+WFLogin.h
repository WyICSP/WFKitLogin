//
//  YFMediatorManager+WFLogin.h
//  AFNetworking
//
//  Created by 王宇 on 2019/8/9.
//

#import <WFBasics/YFMediatorManager.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFMediatorManager (WFLogin)

/**
 打开片区申请页面
 */
+ (void)openApplyAreaCtrlWithController:(UIViewController *)controller;

/**
 开发我的片区页面

 @param controller 当前页面
 */
+ (void)openMyChargePileCtrlWithController:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END
