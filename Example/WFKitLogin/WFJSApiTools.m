//
//  WFJSApiTools.m
//  AFNetworking
//
//  Created by 王宇 on 2019/8/27.
//

#import "WFJSApiTools.h"
//#import "WFUserCenterPublicAPI.h"
//#import "WFShareHelpTool.h"
#import "NSString+Regular.h"
#import "dsbridge.h"
#import "YFKeyWindow.h"
#import "UserData.h"
#import "YFToast.h"
#import "WKHelp.h"

@implementation WFJSApiTools

/**同步*/
- (NSString *)getUUID: (NSString *) msg
{
    return [UserData userInfo].uuid;
}

- (NSString *)isIphoneX: (NSString *) msg
{
    return ISIPHONEX ? @"1" : @"0";
}


/**返回*/
- (void)goBack:(NSString *)msg :(JSCallback) completionHandler
{
    [[[YFKeyWindow shareInstance] getCurrentVC].navigationController popViewControllerAnimated:YES];
    completionHandler(msg,YES);
    
}

///**上传头像 点击拍照*/
//- (void)getHeadImage:(NSString *)msg :(JSCallback) completionHandler
//{
//    [WFUserCenterPublicAPI openSystemCameraWithType:WFUpdatePhotoModHeadType resyltBlock:^(NSString * _Nonnull photoData) {
//        completionHandler(photoData,YES);
//    }];
//}
//
///**上传头像 点击相册*/
//- (void)upLoadHeadImage:(NSString *)msg :(JSCallback) completionHandler
//{
//    [WFUserCenterPublicAPI openSystemAlbumWithType:WFUpdatePhotoModHeadType resultBlock:^(NSString * _Nonnull photoData) {
//        completionHandler(photoData,YES);
//    }];
//}
//
///**联系客服*/
//- (void)phoneCilck:(NSString *)msg :(JSCallback) completionHandler
//{
//    [WFUserCenterPublicAPI callPhoneWithNumber:msg];
//    completionHandler(msg,YES);
//}
//
///**退出登录 跳转到登录页面*/
//- (void)dsBLoginOut:(NSString *)msg :(JSCallback) completionHandler
//{
//    [WFUserCenterPublicAPI loginOutAndJumpLogin];
//    completionHandler(msg,YES);
//}
//
///**分享微信好友*/
//- (void)shareWeixin:(NSString *)msg :(JSCallback) completionHandler
//{
//    if (msg.length != 0) {
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:msg]]];
//        [WFShareHelpTool shareImagesToWechatWithUrls:@[image] successBlock:^{} failBlock:^{}];
//    }
//    completionHandler(msg,YES);
//}
//
///**分享朋友圈*/
//- (void)shareCircle:(NSString *)msg :(JSCallback) completionHandler
//{
//    if (msg.length != 0) {
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:msg]]];
//        [WFShareHelpTool shareImagesToWechatWithUrls:@[image] successBlock:^{} failBlock:^{}];
//    }
//    completionHandler(msg,YES);
//}
//
///**复制 url*/
//- (void)copyUrl:(NSString *)msg :(JSCallback) completionHandler
//{
//    if (msg.length != 0) {
//        @weakify(self)
//        [WFShareHelpTool copyByContentText:msg resultBlock:^{
//            @strongify(self)
//            [YFToast showMessage:@"复制成功" inView:[[YFKeyWindow shareInstance] getCurrentVC].view];
//        }];
//    }
//    completionHandler(msg,YES);
//}
//
///**下载图片*/
//- (void)saveImg:(NSString *)msg :(JSCallback) completionHandler
//{
//    if (msg.length != 0) {
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:msg]]];
//        [WFShareHelpTool saveImageToAlbumWithUrls:@[image]];
//    }
//    completionHandler(msg,YES);
//}
//
/////**分享领取优惠券*/
//- (void)shareWeixinUrl:(NSString *)msg:(JSCallback) completionHandler
//{
//    if (msg.length != 0) {
//        [WFShareHelpTool shareTextBySystemWithText:@"领取充电券" shareUrl:msg shareImage:[UIImage imageNamed:@"shareIcon"]];
//    }
//    completionHandler(msg,YES);
//}
//
/////升级片区
//- (void)upgradeArea:(NSString *)msg
//{
//    [WFUserCenterPublicAPI upgradeAreaWithGroupId:msg];
//}

- (void)changePassword:(NSString *)msg :(JSCallback) completionHandler {
//    [WFUserCenterPublicAPI changePassword];
    completionHandler(msg,YES);
}


@end
