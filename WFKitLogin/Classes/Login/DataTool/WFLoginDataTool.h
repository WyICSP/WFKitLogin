//
//  WFLoginDataTool.h
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/8/8.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFLoginDataTool : NSObject

/**
 用户登录
 
 @param params 参数
 @param resultBlock 返回成功
 */
+ (void)loginWithParams:(NSDictionary *)params
            resultBlock:(void(^)(NSDictionary *models))resultBlock;


/**
 快捷登录
 
 @param params 参数
 @param resultBlock 返回
 */
+ (void)quickLoginWithParams:(NSDictionary *)params
                 resultBlock:(void(^)(NSDictionary *models))resultBlock;

/**
 通用获取验证码
 
 @param params 参数
 @param resultBlock 返回
 */
+ (void)getVerificationCodeWithParams:(NSDictionary *)params
                          resultBlock:(void(^)(void))resultBlock;

/// 获取修改密码的验证码
/// @param params 参数
/// @param resultBlock 返回结果
+ (void)getVerificationUpdatePswCodeWithParams:(NSDictionary *)params
                                   resultBlock:(void(^)(void))resultBlock;

/// 修改密码
/// @param params 参数
/// @param resultBlock 返回结果
+ (void)updatePasswordWithParams:(NSDictionary *)params
                     resultBlock:(void(^)(void))resultBlock;


/**
 申请成为合伙人

 @param params 参数
 @param resultBlock 返回
 */
+ (void)applyForPartnershipWithParams:(NSDictionary *)params
                          resultBlock:(void(^)(void))resultBlock;


/**
 获取地址信息

 @param params 参数
 @param resultBlock 返回结果
 */
+ (void)getAddressDataWithParams:(NSDictionary *)params
                     resultBlock:(void(^)(NSArray *models))resultBlock;

@end

NS_ASSUME_NONNULL_END
