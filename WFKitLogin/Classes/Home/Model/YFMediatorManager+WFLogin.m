//
//  YFMediatorManager+WFLogin.m
//  AFNetworking
//
//  Created by 王宇 on 2019/8/9.
//

#import "YFMediatorManager+WFLogin.h"

@implementation YFMediatorManager (WFLogin)

/**
 打开片区申请页面
 */
+ (void)openApplyAreaCtrlWithController:(UIViewController *)controller {
    [self performTarget:@"WFApplyAreaPublicAPI" action:@"openApplyAreaCtrlWithController:" params:controller isRequiredReturnValue:NO];
}

+ (void)openMyChargePileCtrlWithController:(UIViewController *)controller {
    [self performTarget:@"WFApplyAreaPublicAPI" action:@"openMyChargePileCtrlWithController:" params:controller isRequiredReturnValue:NO];
}

/// 打开授信充值页面
+ (void)openCreditPayCtrlWithController:(UIViewController *)controller {
    [self performTarget:@"WFApplyAreaPublicAPI" action:@"openCreditPayCtrlWithController:" params:controller isRequiredReturnValue:NO];
}

/// 打开奖励中心页面
/// @param controller 当前页面
+ (void)openRewardCtrlWithController:(UIViewController *)controller {
    [self performTarget:@"WFRewardPublicAPI" action:@"openRewardCtrlWithController:" params:controller isRequiredReturnValue:NO];
}

/// 打开活动收入和奖励收入页面
+ (void)openActivityOrRewardCtrlWithController:(UIViewController *)controller
                                          type:(NSInteger)type {
    NSArray *params = @[controller,@(type)];
    [self performTarget:@"WFRewardPublicAPI" action:@"openActivityOrRewardCtrlWithParams" params:params isRequiredReturnValue:NO];
}

+ (void)gotoPayFreightWithParams:(NSDictionary *)params {
    [self performTarget:@"WFPayPublicAPI" action:@"gotoPayWithParams:" params:params isRequiredReturnValue:NO];
}

@end
