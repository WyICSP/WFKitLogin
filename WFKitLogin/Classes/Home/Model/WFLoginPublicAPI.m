//
//  WFLoginPublicAPI.m
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/8/9.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import "WFLoginPublicAPI.h"
#import "WFHomeDataTool.h"
#import "WFPayTypeMsgModel.h"
#import "SKSafeObject.h"
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
}

@end
