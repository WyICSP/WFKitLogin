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
+ (void)openApplyAreaCtrlWithController:(UIViewController *)controller
                            partnerRole:(NSInteger)partnerRole {
    NSArray *params = @[controller,@(partnerRole)];
    [self performTarget:@"WFApplyAreaPublicAPI" action:@"openApplyAreaCtrlWithController:" params:params isRequiredReturnValue:NO];
}

+ (void)openMyChargePileCtrlWithController:(UIViewController *)controller {
    [self performTarget:@"WFApplyAreaPublicAPI" action:@"openMyChargePileCtrlWithController:" params:controller isRequiredReturnValue:NO];
}

/// 打开授信充值页面
+ (void)openCreditPayCtrlWithController:(UIViewController *)controller
                                   type:(NSInteger)type {
    NSArray *params = @[controller,@(type)];
    [self performTarget:@"WFApplyAreaPublicAPI" action:@"openCreditPayCtrlWithController:" params:params isRequiredReturnValue:NO];
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
    [self performTarget:@"WFRewardPublicAPI" action:@"openActivityOrRewardCtrlWithParams:" params:params isRequiredReturnValue:NO];
}

/// 直接打开申请片区
+ (void)gotoAppleAreaCtrlWithController:(UIViewController *)controller {
    [self performTarget:@"WFApplyAreaPublicAPI" action:@"gotoAppleAreaCtrlWithController:" params:controller isRequiredReturnValue:NO];
}

+ (void)gotoCommunityServicePageWithController:(UIViewController *)controller {
    [self performTarget:@"WFApplyAreaPublicAPI" action:@"gotoCommunityServicePageWithController:" params:controller isRequiredReturnValue:NO];
}

+ (void)gotoPayFreightWithParams:(NSDictionary *)params {
    [self performTarget:@"WFPayPublicAPI" action:@"gotoPayWithParams:" params:params isRequiredReturnValue:NO];
}

+ (void)savePhotoWithParams:(NSArray *)params {
    [self performTarget:@"WFShareHelpTool" action:@"saveImageToAlbumWithUrls:" params:params isRequiredReturnValue:NO];
}

+ (void)bindUserUuid {
    [self performTarget:@"WFPushDataTool" action:@"bindUserUuid" params:@{} isRequiredReturnValue:NO];
}

@end
