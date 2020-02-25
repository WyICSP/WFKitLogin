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


/// 打开授信充值页面
/// @param controller 当前页面
+ (void)openCreditPayCtrlWithController:(UIViewController *)controller;

/// 打开奖励中心页面
/// @param controller 当前页面
+ (void)openRewardCtrlWithController:(UIViewController *)controller;

/// 打开活动收入和奖励收入页面
/// @param controller 当前页面
/// @param type 0 奖励, 1 活动金
+ (void)openActivityOrRewardCtrlWithController:(UIViewController *)controller
                                          type:(NSInteger)type;

/**
 去支付

 @param params 支付相关数据
 */
+ (void)gotoPayFreightWithParams:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
