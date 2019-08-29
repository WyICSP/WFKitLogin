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

+ (void)gotoPayFreightWithParams:(NSDictionary *)params {
    [self performTarget:@"WFPayPublicAPI" action:@"gotoPayWithParams:" params:params isRequiredReturnValue:NO];
}

@end
