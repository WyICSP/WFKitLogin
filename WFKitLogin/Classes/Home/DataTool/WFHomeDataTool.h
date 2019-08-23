//
//  WFHomeDataTool.h
//  AFNetworking
//
//  Created by 王宇 on 2019/8/19.
//

#import <Foundation/Foundation.h>

@class WFHomeDataModel;

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

@end

NS_ASSUME_NONNULL_END
