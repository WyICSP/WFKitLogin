//
//  JsApiTest.m
//
//  Created by 杜文 on 16/12/30.
//  Copyright © 2016年 杜文. All rights reserved.
//

#import "JsApiTest.h"
#import "SKSafeObject.h"
#import "WFLoginPublicAPI.h"
#import "dsbridge.h"
#import "YFKeyWindow.h"
#import "UserData.h"
#import "YFToast.h"
#import "WKHelp.h"

@interface JsApiTest(){
  NSTimer * timer ;
  void(^hanlder)(id value,BOOL isComplete);
  int value;
}
@end

@implementation JsApiTest

/**同步*/
- (NSString *) getUserId: (NSString *) msg
{
    return [UserData userInfo].uuid;
}

- (NSString *) isIphoneX: (NSString *) msg
{
    return ISIPHONEX ? @"1" : @"0";
}


/**返回*/
- (void)goBack:(NSString *)msg :(JSCallback) completionHandler
{
    [[[YFKeyWindow shareInstance] getCurrentVC].navigationController popViewControllerAnimated:YES];
    completionHandler(msg,YES);
}


/**
 获取支付信息

 @param msg msg
 @param completionHandler completionHandler
 */
- (void)placeOrder:(NSDictionary *)msg
{
    if ([msg isKindOfClass:[NSDictionary class]]) {
        //金额
        NSString *money = [NSString stringWithFormat:@"%@",[msg safeJsonObjForKey:@"count"]];
        //支付方式
        NSString *payMethod = [NSString stringWithFormat:@"%@",[msg safeJsonObjForKey:@"id"]];
        //订单号
        NSString *sn = [NSString stringWithFormat:@"%@",[msg safeJsonObjForKey:@"sn"]];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params safeSetObject:money forKey:@"money"];
        [params safeSetObject:payMethod forKey:@"payMethod"];
        [params safeSetObject:sn forKey:@"sn"];
        [WFLoginPublicAPI getPaymentMsgWithParams:params];
    }
}

/**联系客服*/
- (void)phoneCilck:(NSString *)msg :(JSCallback) completionHandler
{
    [WFLoginPublicAPI callPhoneWithNumber:msg];
    completionHandler(msg,YES);
}

///**退出登录 跳转到登录页面*/
//- (void)dsBLoginOut:(NSString *)msg :(JSCallback) completionHandler
//{
//    [WFLoginPublicAPI loginOutAndJumpLogin];
//    completionHandler(msg,YES);
//}


@end
