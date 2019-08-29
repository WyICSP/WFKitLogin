//
//  WFHomeDataTool.h
//  AFNetworking
//
//  Created by 王宇 on 2019/8/19.
//

#import <Foundation/Foundation.h>

@class WFHomeDataModel;
@class WFPayTypeMsgModel;

NS_ASSUME_NONNULL_BEGIN

@interface WFHomeDataTool : NSObject

#pragma mark 获取首页数据
/**
 获取首页数据

 @param params 参数
 @param resultBlock 返回结果
 */
+ (void)getHomeDataWithParams:(NSDictionary *)params
                  resultBlock:(void(^)(WFHomeDataModel *models))resultBlock;


#pragma mark 更新版本
/**
 更新版本
 
 @param params 参数
 @param resultBlock 返回结果
 */
+ (void)updateAppWithParams:(NSDictionary *)params
                resultBlock:(void(^)(NSDictionary *models))resultBlock;


#pragma mark 获取支付参数接口
/**
 获取支付信息

 @param params 参数
 @param resultBlock 返回结果
 */
+ (void)getPayTypMessageWithParams:(NSDictionary *)params
                       resultBlock:(void(^)(WFPayTypeMsgModel *mdoels))resultBlock;

@end

NS_ASSUME_NONNULL_END
