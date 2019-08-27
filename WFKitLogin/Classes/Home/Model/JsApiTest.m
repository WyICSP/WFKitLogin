//
//  JsApiTest.m
//
//  Created by 杜文 on 16/12/30.
//  Copyright © 2016年 杜文. All rights reserved.
//

#import "JsApiTest.h"
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
- (void) goBack:(NSString *)msg :(JSCallback) completionHandler
{
    [[[YFKeyWindow shareInstance] getCurrentVC].navigationController popViewControllerAnimated:YES];
    completionHandler(msg,YES);
    
}

///**
// 异步返回用户 Id
//  */
//- (void) getUserId:(NSString *) msg :(JSCallback) completionHandler
//{
//    completionHandler([UserData userInfo].Id,YES);
//}
//
///**获取淘宝授权*/
//- (void) callTaobaoAuth:(NSString *)msg :(JSCallback) completionHandler
//{
//    DLog(@"%d",[[ALBBSession sharedInstance] isLogin]);
//    if (![[ALBBSession sharedInstance] isLogin]) {
//        [WFAlibcpPublicAPI jumpAlibabaGrantPageWithSuccessBlock:^(NSString * _Nonnull userId) {
//            completionHandler(userId,YES);
//        } failureBlock:^{
//            [YFToast showMessage:@"授权失败" inView:[[YFKeyWindow shareInstance] getCurrentVC].view];
//        }];
//    }else {
//        NSString *taobao_userId = [YFUserDefaults objectForKey:@"TAOBAO_USERID"];
//        completionHandler(taobao_userId,YES);
//    }
//}
//
///**充值*/
//- (void)recharge:(NSString *)msg :(JSCallback) completionHandler
//{
//    [WFAlibcpPublicAPI jumpAddMoney];
//    completionHandler(msg,YES);
//
//}
//
///**退出登录 跳转到登录页面*/
//- (void)dsBLoginOut:(NSString *)msg :(JSCallback) completionHandler
//{
//    [WFAlibcpPublicAPI loginOutAndJumpLogin];
//    completionHandler(msg,YES);
//}
//
///**打开二维码扫描页面*/
//- (void)createSubview:(NSString *)msg :(JSCallback) completionHandler
//{
//    [WFAlibcpPublicAPI  openScanCtrlWithResult:^(NSString * _Nonnull message) {
//        completionHandler(message,YES);
//    }];
//
//}
//
///**打开分享页面*/
//- (void)openProfit:(NSDictionary *)msg
//{
//    [WFAlibcpPublicAPI openShareViewCtrlWithParams:msg];
//}
//
///**打开淘宝页面*/
//- (void)openTBUrl:(NSDictionary *)dict
//{
//    if ([dict isKindOfClass:[NSDictionary class]]) {
//        NSString *tkUrl = [NSString stringWithFormat:@"%@",[dict objectForKey:@"tkUrl"]];
//        [WFAlibcpPublicAPI jumpAlibcAPPTradeWithUrl:tkUrl];
//    }
//}
//
///**打开正在充电页面*/
//- (void)charging:(NSDictionary *)dict
//{
//    if ([dict isKindOfClass:[NSDictionary class]]) {
//        NSString *orderNum = [NSString stringWithFormat:@"%@",[dict objectForKey:@"orderNo"]];
//        [WFAlibcpPublicAPI openChhargingCtrlWithOrderNum:orderNum];
//    }
//}
//
///**打开订单详情*/
//- (void)chargeDetail:(NSDictionary *)dict {
//    if ([dict isKindOfClass:[NSDictionary class]]) {
//        NSString *orderNum = [NSString stringWithFormat:@"%@",[dict objectForKey:@"orderNo"]];
//        [WFAlibcpPublicAPI openOrderDetailWithOrderNum:orderNum];
//    }
//}
//
///**打开开通 vip 套餐*/
//- (void)buyVipCard:(NSDictionary *)dict {
//    if ([dict isKindOfClass:[NSDictionary class]]) {
//        NSString *buyVipCard = [NSString stringWithFormat:@"%@",[dict objectForKey:@"buyVipCard"]];
//        if (buyVipCard.length == 0) {
//            [WFAlibcpPublicAPI openVipWithGroupId:buyVipCard isJoin:NO];
//        }else {
//            [WFAlibcpPublicAPI openVipWithGroupId:buyVipCard isJoin:YES];
//        }
//    }
//}
//
//
///**打开相册 上传意见反馈图片*/
//- (void)upLoadImage:(NSString *)msg :(JSCallback) completionHandler
//{
//    [WFAlibcpPublicAPI openSystemAlbumWithType:WFUpdatePhotoFeedbackType resultBlock:^(NSString * _Nonnull photoData) {
//        completionHandler(photoData,YES);
//    }];
//}
//
///**打开相机 上传意见反馈图片*/
//- (void)getImage:(NSString *)msg :(JSCallback) completionHandler
//{
//    [WFAlibcpPublicAPI openSystemCameraWithType:WFUpdatePhotoFeedbackType resyltBlock:^(NSString * _Nonnull photoData) {
//        completionHandler(photoData,YES);
//    }];
//}
//
//
///**上传头像 点击拍照*/
//- (void)getHeadImage:(NSString *)msg :(JSCallback) completionHandler
//{
//    [WFAlibcpPublicAPI openSystemCameraWithType:WFUpdatePhotoModHeadType resyltBlock:^(NSString * _Nonnull photoData) {
//        completionHandler(photoData,YES);
//    }];
//}
//
///**上传头像 点击相册*/
//- (void)upLoadHeadImage:(NSString *)msg :(JSCallback) completionHandler
//{
//    [WFAlibcpPublicAPI openSystemAlbumWithType:WFUpdatePhotoModHeadType resultBlock:^(NSString * _Nonnull photoData) {
//        completionHandler(photoData,YES);
//    }];
//}
//
///**联系客服*/
//- (void)phoneCilck:(NSString *)msg :(JSCallback) completionHandler
//{
//    [WFAlibcpPublicAPI callPhoneWithNumber:msg];
//    completionHandler(msg,YES);
//}
//
///**
// 分享微信好友
// SSDKPlatformTypeWechat 微信好友 SSDKPlatformSubTypeWechatTimeline 朋友圈
// {
// shareUrl = "http://api.jx9n.com/page/view/invitation?mobile=15618918815";
// "type:" = WeCF;
// }
// */
//- (void)shareURL:(NSDictionary *)dict :(JSCallback) completionHandler
//{
//    if ([dict isKindOfClass:[NSDictionary class]]) {
//        //分享 url
//        NSString *url = [NSString stringWithFormat:@"%@",[dict objectForKey:@"shareUrl"]];
//        //类型
//        NSString *type = [NSString stringWithFormat:@"%@",[dict objectForKey:@"type"]];
//        if ([type isEqualToString:@"WeCF"]) {
//            //微信好友
//            [WFShareHelpTool shareInvitationToWechatWithType:SSDKPlatformTypeWechat shareUrl:url];
//        } else if ([type isEqualToString:@"WeCFC"]) {
//            //微信朋友圈
//            [WFShareHelpTool shareInvitationToWechatWithType:SSDKPlatformSubTypeWechatTimeline shareUrl:url];
//        } else if ([type isEqualToString:@"QRC"]) {
//            //二维码分享
//            UIImage *image = [WFShareHelpTool screenshotForView:[[YFKeyWindow shareInstance] getCurrentVC].view];
//            [WFShareHelpTool saveImageToAlbumWithUrls:@[image]];
//        }
//    }
//    completionHandler(@"",YES);
//}




@end
