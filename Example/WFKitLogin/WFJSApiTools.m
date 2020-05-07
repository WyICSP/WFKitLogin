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

- (void)changePassword:(NSString *)msg :(JSCallback) completionHandler {
//    [WFUserCenterPublicAPI changePassword];
    completionHandler(msg,YES);
}


@end
