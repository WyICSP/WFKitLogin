//
//  JsApiTest.m
//
//  Created by 杜文 on 16/12/30.
//  Copyright © 2016年 杜文. All rights reserved.
//

#import "JsApiTest.h"
#import "SKSafeObject.h"
#import "WFLoginPublicAPI.h"
#import "YFMediatorManager+WFLogin.h"
#import "dsbridge.h"
#import "YFKeyWindow.h"
#import "UserData.h"
#import "YFToast.h"
#import "WKHelp.h"

@interface JsApiTest(){
    NSTimer * timer ;
    void(^hanlder)(id value,BOOL isComplete);
    int value;
    BOOL _isNotification;
}
@end

@implementation JsApiTest

/**同步*/
- (NSString *)getUserId: (NSString *) msg
{
    return [UserData userInfo].uuid;
}

- (NSString *) isIphoneX: (NSString *) msg
{
    return ISIPHONEX ? @"1" : @"0";
}

- (NSString *)getAppVersion:(NSString *)msg
{
    return APP_VERSION;
}

- (void)getToken:(NSString *)msg :(JSCallback) completionHandler
{
    completionHandler([UserData userInfo].token,YES);
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
- (void)placeOrder:(NSDictionary *)msg :(JSCallback) completionHandler
{
    if ([msg isKindOfClass:[NSDictionary class]]) {
        if (msg.count == 1) {
            NSString *result = [NSString stringWithFormat:@"%@",[msg safeJsonObjForKey:@"result"]];
            completionHandler([result intValue] == 1 ? @(1) : @(0),YES);
        } else {
            // 支付的回调
            if (!_isNotification) {
                [YFNotificationCenter addObserver:self selector:@selector(addressInfo:) name:@"payResultKeys" object:nil];
                _isNotification = YES;
            }
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
}

- (void)addressInfo:(NSNotification *)notification {
    NSDictionary *dict = notification.userInfo;
    
    [self placeOrder:dict :^(NSString * _Nullable result, BOOL complete) {
        
    }];
    
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

/**打开授信*/
- (void)openCreditPay:(NSString *)msg :(JSCallback) completionHandler
{
    [WFLoginPublicAPI openCreditPayCtrl];
    completionHandler(msg,YES);
}

/**打开奖励收入*/
- (void)toAwardsMoney:(NSString *)msg :(JSCallback) completionHandler
{
    [WFLoginPublicAPI openRewardCtrl];
    completionHandler(msg,YES);
}

/**下载图片*/
- (void)saveImg:(NSString *)msg :(JSCallback) completionHandler
{
    if (msg.length != 0) {
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:msg]]];
        if (image != nil)
        [YFMediatorManager savePhotoWithParams:@[image]];
    }
    completionHandler(msg,YES);
}

- (void)dealloc {
    [YFNotificationCenter removeObserver:self name:@"payResultKeys" object:nil];
}

@end
