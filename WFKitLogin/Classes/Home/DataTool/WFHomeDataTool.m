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
#import "NSString+Regular.h"
#import "WFNewHomeModel.h"
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
            [YFUserDefaults setObject:[NSString dictionTransformationJson:(NSDictionary *)baseModel.data] forKey:@"HomeData"];
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

+ (void)geHomeAssetsInfoWithParams:(NSDictionary *)params
                       resultBlock:(void(^)(WFNewHomeModel *models))resultBlock
                      failureBlock:(void(^)(void))failureBlock {
    NSString *path = [NSString stringWithFormat:@"%@app-partner-setmeal/v1/home/pageInfo/assetsInfo",NEW_HOST_URL];
    [WKRequest getWithURLString:path parameters:nil isShowHud:NO success:^(WKBaseModel *baseModel) {
        if (CODE_ZERO) {
            resultBlock([WFNewHomeModel mj_objectWithKeyValues:baseModel.data]);
        }else {
            failureBlock();
        }
    } failure:^(NSError *error) {
        failureBlock();
    }];
}

+ (void)getCustomerServiceWithParams:(NSDictionary *)params
                         resultBlock:(void(^)(WFNewHomeServiceModel *cModel))resultBlock {
    NSString *path = [NSString stringWithFormat:@"%@app-partner-setmeal/v1/home/pageInfo/headAd",NEW_HOST_URL];
    [WKRequest getWithURLString:path parameters:nil isShowHud:NO success:^(WKBaseModel *baseModel) {
        if (CODE_ZERO) {
            resultBlock([WFNewHomeServiceModel mj_objectWithKeyValues:baseModel.data]);
        }
    } failure:^(NSError *error) {
        
    }];
}

+ (void)getHomeTotalIncomeWithParams:(NSDictionary *)params
                         resultBlock:(void(^)(WFNewHomeIncomeModel *models))resultBlock
                        failureBlock:(void(^)(void))failureBlock {
    NSString *path = [NSString stringWithFormat:@"%@yzc-partner-statistics-api/v1/index/getIncome",NEW_HOST_URL];
    [WKRequest getWithURLString:path parameters:nil isShowHud:NO success:^(WKBaseModel *baseModel) {
        if (CODE_ZERO) {
            resultBlock([WFNewHomeIncomeModel mj_objectWithKeyValues:baseModel.data]);
        }else{
            failureBlock();
        }
    } failure:^(NSError *error) {
        failureBlock();
    }];
}

+ (void)getHomeTodayIncomeWithParams:(NSDictionary *)params
                         resultBlock:(void(^)(WFNewHomeTodayIncomeModel *models))resultBlock
                        failureBlock:(void(^)(void))failureBlock {
    NSString *path = [NSString stringWithFormat:@"%@yzc-partner-statistics-api/v1/index/todayManage",NEW_HOST_URL];
    [WKRequest getWithURLString:path parameters:nil isShowHud:NO success:^(WKBaseModel *baseModel) {
        if (CODE_ZERO) {
            resultBlock([WFNewHomeTodayIncomeModel mj_objectWithKeyValues:baseModel.data]);
        }else {
            failureBlock();
        }
    } failure:^(NSError *error) {
        failureBlock();
    }];
}

+ (void)getMessageUnReadCountWithParams:(NSDictionary *)params
                            resultBlock:(void(^)(NSDictionary *dict))resultBlock {
    NSString *path = [NSString stringWithFormat:@"%@app-partner-setmeal/v1/message/getMessageNum",NEW_HOST_URL];
    [WKRequest getWithURLString:path parameters:params isShowHud:NO success:^(WKBaseModel *baseModel) {
        if (CODE_ZERO) {
            resultBlock(baseModel.mDictionary);
        }
    } failure:^(NSError *error) {
        
    }];
}

+ (void)getPartnerInfoWithParams:(NSDictionary *)params
                     resultBlock:(void(^)(NSDictionary *dict))resultBlock {
    NSString *path = [NSString stringWithFormat:@"%@app-partner-setmeal/v1/home/admin/getPartnerInfo",NEW_HOST_URL];
    [WKRequest getWithURLString:path parameters:params isShowHud:NO success:^(WKBaseModel *baseModel) {
        if (CODE_ZERO) {
            resultBlock(baseModel.mDictionary);
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
