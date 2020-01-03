//
//  WFLoginDataTool.m
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/8/8.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import "WFLoginDataTool.h"
#import "WKRequest.h"
#import "YFKeyWindow.h"
#import "WKSetting.h"
#import "YFToast.h"
#import "WKHelp.h"

@implementation WFLoginDataTool

#pragma mark 登录
+ (void)loginWithParams:(NSDictionary *)params
            resultBlock:(void(^)(NSDictionary *models))resultBlock {
    //接口地址
    NSString *path = [NSString stringWithFormat:@"%@app-partner/loginTemplate/passwordlogin",NEW_HOST_URL];
    [WKRequest postWithURLString:path parameters:params isJson:YES isShowHud:YES success:^(WKBaseModel *baseModel) {
        if (CODE_ZERO) {
            resultBlock([baseModel.mDictionary objectForKey:@"data"]);
        }else {
            [YFToast showMessage:baseModel.message inView:[[YFKeyWindow shareInstance] getCurrentVC].view];
        }
    } failure:^(NSError *error) {
        
    }];
}

+ (void)quickLoginWithParams:(NSDictionary *)params
                 resultBlock:(void(^)(NSDictionary *models))resultBlock {
    //接口地址
    NSString *path = [NSString stringWithFormat:@"%@app-partner/loginTemplate/quickLogin",NEW_HOST_URL];
    [WKRequest postWithURLString:path parameters:params isJson:YES isShowHud:YES success:^(WKBaseModel *baseModel) {
        if (CODE_ZERO) {
            resultBlock([baseModel.mDictionary objectForKey:@"data"]);
        }else {
            [YFToast showMessage:baseModel.message inView:[[YFKeyWindow shareInstance] getCurrentVC].view];
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark 发送验证码
+ (void)getVerificationCodeWithParams:(NSDictionary *)params
                          resultBlock:(void(^)(void))resultBlock {
    //接口地址
    NSString *path = [NSString stringWithFormat:@"%@app-partner/loginTemplate/getCode",NEW_HOST_URL];
    [WKRequest postWithURLString:path parameters:params isJson:YES isShowHud:YES success:^(WKBaseModel *baseModel) {
        if (CODE_ZERO) {
            resultBlock();
        }else {
            [YFToast showMessage:baseModel.message inView:[[YFKeyWindow shareInstance] getCurrentVC].view];
        }
    } failure:^(NSError *error) {
        
    }];
}

+ (void)getVerificationUpdatePswCodeWithParams:(NSDictionary *)params
                                   resultBlock:(void(^)(void))resultBlock {
    //接口地址
    NSString *path = [NSString stringWithFormat:@"%@app-partner/loginTemplate/findCode",NEW_HOST_URL];
    [WKRequest postWithURLString:path parameters:params isJson:YES isShowHud:YES success:^(WKBaseModel *baseModel) {
        if (CODE_ZERO) {
            resultBlock();
        }else {
            [YFToast showMessage:baseModel.message inView:[[YFKeyWindow shareInstance] getCurrentVC].view];
        }
    } failure:^(NSError *error) {
        
    }];
}

+ (void)updatePasswordWithParams:(NSDictionary *)params
                     resultBlock:(void(^)(void))resultBlock {
    //接口地址
    NSString *path = [NSString stringWithFormat:@"%@app-partner/loginTemplate/updatePassword",NEW_HOST_URL];
    [WKRequest postWithURLString:path parameters:params isJson:YES isShowHud:YES success:^(WKBaseModel *baseModel) {
        if (CODE_ZERO) {
            resultBlock();
        }else {
            [YFToast showMessage:baseModel.message inView:[[YFKeyWindow shareInstance] getCurrentVC].view];
        }
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark 申请成为合伙人
+ (void)applyForPartnershipWithParams:(NSDictionary *)params
                          resultBlock:(void(^)(void))resultBlock {
    //接口地址
    NSString *path = [NSString stringWithFormat:@"%@app-partner/applyPartnerTemplate/saveApplyBusiness",NEW_HOST_URL];
    [WKRequest postWithURLString:path parameters:params isJson:YES isShowHud:YES success:^(WKBaseModel *baseModel) {
        if (CODE_ZERO) {
            resultBlock();
        }else {
            [YFToast showMessage:baseModel.message inView:[[YFKeyWindow shareInstance] getCurrentVC].view];
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark 获取地址信息
+ (void)getAddressDataWithParams:(NSDictionary *)params
                     resultBlock:(void(^)(NSArray *models))resultBlock {
    //接口地址
    NSString *path = [NSString stringWithFormat:@"%@app-partner-group/v1/area/get/area",NEW_HOST_URL];
    [WKRequest getWithURLString:path parameters:params isShowHud:NO success:^(WKBaseModel *baseModel) {
        if (CODE_ZERO) {
            resultBlock((NSArray *)baseModel.data);
        }else {
            [YFToast showMessage:baseModel.message inView:[[YFKeyWindow shareInstance] getCurrentVC].view];
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
