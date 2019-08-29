//
//  WFHomeDataTool.m
//  AFNetworking
//
//  Created by 王宇 on 2019/8/19.
//

#import "WFHomeDataTool.h"
#import <MJExtension/MJExtension.h>
#import "WFHomeDataModel.h"
#import "WFPayTypeMsgModel.h"
#import "WKRequest.h"
#import "YFKeyWindow.h"
#import "WKSetting.h"
#import "YFToast.h"
#import "WKHelp.h"

@implementation WFHomeDataTool

+ (void)getHomeDataWithParams:(NSDictionary *)params
                  resultBlock:(void(^)(WFHomeDataModel *models))resultBlock {
    //接口地址
    NSString *path = [NSString stringWithFormat:@"%@app-partner/home/page/pageInfo",NEW_HOST_URL];
    [WKRequest getWithURLString:path parameters:params isShowHud:NO success:^(WKBaseModel *baseModel) {
        if (CODE_ZERO) {
            resultBlock([WFHomeDataModel mj_objectWithKeyValues:baseModel.data]);
            //存储数据
            [YFUserDefaults setObject:baseModel.data forKey:@"HomeData"];
        }else {
            [YFToast showMessage:baseModel.message inView:[[YFKeyWindow shareInstance] getCurrentVC].view];
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark 版本更新

+ (void)updateAppWithParams:(NSDictionary *)params
                resultBlock:(void(^)(NSDictionary *models))resultBlock {
    NSString *path = [NSString stringWithFormat:@"%@app-system/app-system/v1/get/app/version",NEW_HOST_URL];
    [WKRequest getWithURLString:path parameters:nil isShowHud:NO success:^(WKBaseModel *baseModel) {
        if (CODE_ZERO) {
            resultBlock([baseModel.mDictionary objectForKey:@"data"]);
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark 获取支付参数接口

+ (void)getPayTypMessageWithParams:(NSDictionary *)params
                       resultBlock:(void(^)(WFPayTypeMsgModel *models))resultBlock {
    //接口地址
    NSString *path = [NSString stringWithFormat:@"%@app-partner/applyTemplate/unifiedOrder",NEW_HOST_URL];
    [WKRequest postWithURLString:path parameters:params isJson:YES isShowHud:YES success:^(WKBaseModel *baseModel) {
        if (CODE_ZERO) {
            resultBlock([WFPayTypeMsgModel mj_objectWithKeyValues:baseModel.data]);
        }else {
            [YFToast showMessage:baseModel.message inView:[[YFKeyWindow shareInstance] getCurrentVC].view];
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
