//
//  WFHomeDataTool.h
//  AFNetworking
//
//  Created by 王宇 on 2019/8/19.
//

#import <Foundation/Foundation.h>

@class WFHomeDataModel;
@class WFPayTypeMsgModel;
@class WFNewHomeModel;
@class WFNewHomeServiceModel;
@class WFNewHomeIncomeModel;
@class WFNewHomeTodayIncomeModel;

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


#pragma mark 新版获取数据
/// 获取资产信息
/// @param params 参数
/// @param resultBlock 返回加过
+ (void)geHomeAssetsInfoWithParams:(NSDictionary *)params
                     resultBlock:(void(^)(WFNewHomeModel *models))resultBlock
                      failureBlock:(void(^)(void))failureBlock;


/// 获取客服联系方式
/// @param params 参数
/// @param resultBlock 返回结构
+ (void)getCustomerServiceWithParams:(NSDictionary *)params
                         resultBlock:(void(^)(WFNewHomeServiceModel *cModel))resultBlock;


/// 获取总收益
/// @param params 参数
/// @param resultBlock 返回结果
+ (void)getHomeTotalIncomeWithParams:(NSDictionary *)params
                         resultBlock:(void(^)(WFNewHomeIncomeModel *models))resultBlock
                        failureBlock:(void(^)(void))failureBlock;

/// 获取今日
/// @param params 参数
/// @param resultBlock 返回结果
+ (void)getHomeTodayIncomeWithParams:(NSDictionary *)params
                         resultBlock:(void(^)(WFNewHomeTodayIncomeModel *models))resultBlock
                        failureBlock:(void(^)(void))failureBlock;

/// 获取未读消息
/// @param params 参数
/// @param resultBlock 返回结果
+ (void)getMessageUnReadCountWithParams:(NSDictionary *)params
                            resultBlock:(void(^)(NSDictionary *dict))resultBlock;

@end

NS_ASSUME_NONNULL_END
