//
//  WFLoginPublicAPI.m
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/8/9.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import "WFLoginPublicAPI.h"
#import "YFMediatorManager+WFLogin.h"
#import "WFSecuritySetViewController.h"
#import "WFHomeDataTool.h"
#import "WFPayTypeMsgModel.h"
#import "SKSafeObject.h"
#import "YFKeyWindow.h"
#import "UserData.h"
#import "WKHelp.h"

@implementation WFLoginPublicAPI

/**
 根视图
 
 @return 登录页面
 */
+ (WFLoginViewController *)rootLoginViewController {
    return [WFLoginViewController shareInstance];
}

/**
 发起支付

 @param params 参数
 */
+ (void)getPaymentMsgWithParams:(NSDictionary *)params {
    @weakify(self)
    [WFHomeDataTool getPayTypMessageWithParams:params resultBlock:^(WFPayTypeMsgModel * _Nonnull mdoels) {
        @strongify(self)
        [self completionHandlerWith:mdoels];
    }];
}

/**
 打电话
 
 @param phone 电话号码
 */
+ (void)callPhoneWithNumber:(NSString *)phone {
    NSString *phoneNum = [NSString stringWithFormat:@"tel:%@",phone];
    if (phone.length != 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNum]];
    }
}

/**
 处理支付接口条用完成

 @param models mdoels
 */
+ (void)completionHandlerWith:(WFPayTypeMsgModel * _Nonnull)models {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params safeSetObject:models.appid forKey:@"wxAppId"];
    [params safeSetObject:models.appSecret forKey:@"wxAppSecret"];
    [params safeSetObject:models.partnerid forKey:@"wxPartnerId"];
    [params safeSetObject:models.partnerKey forKey:@"wxPartnerKey"];
    [params safeSetObject:models.prepayid forKey:@"wxOrderNum"];
    [params safeSetObject:models.aliPay forKey:@"aliPayJson"];
    //调用支付
    [YFMediatorManager gotoPayFreightWithParams:params];
}

/**
 退出登录 跳转登录页面
 */
+ (void)loginOutAndJumpLogin {
    //退出登录
    [UserData userInfo:nil];
    //跳转登录
    NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
    WFLoginViewController *login = [[WFLoginViewController alloc] initWithNibName:@"WFLoginViewController" bundle:currentBundle];
    login.hidesBottomBarWhenPushed = YES;
    login.loginType = WFJumpLoginCtrlH5Tpye;
    [[[YFKeyWindow shareInstance] getCurrentVC].navigationController pushViewController:login animated:YES];
}


/// 修改密码
+ (void)changePassword {
    WFSecuritySetViewController *security = [[WFSecuritySetViewController alloc] initWithNibName:@"WFSecuritySetViewController" bundle:[NSBundle bundleForClass:[self class]]];
    security.setType = WFSecuritySetForgetPswType;
    [[[YFKeyWindow shareInstance] getCurrentVC].navigationController pushViewController:security animated:YES];
}

@end
