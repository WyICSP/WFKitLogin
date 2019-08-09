//
//  WKRequest.h
//  YukiFramework
//
//  Created by 王宇 on 2017/11/13.
//  Copyright © 2017年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WKBaseModel.h"

typedef void(^SuccessBlock)(WKBaseModel *baseModel);
typedef void(^FailureBlock)(NSError *error);
@interface WKRequest : NSObject
/**
 请求成功
 */
@property (nonatomic, copy) SuccessBlock successBlock;
/**
 请求失败
 */
@property (nonatomic, copy) FailureBlock failureBlock;

/**
 网络监听
 */
+ (BOOL)YFNetWorkReachability;


/**
 get 请求
 
 @param urlString 请求地址
 @param parameters 请求参数
 @param successBlock 请求成功回调
 @param failureBlock 请求失败回调
 */
+ (void)getWithURLString:(NSString *)urlString
              parameters:(id)parameters
               isShowHud:(BOOL)isShowHud
                 success:(SuccessBlock)successBlock
                 failure:(FailureBlock)failureBlock;

/**
 post 请求
 
 @param urlString 请求地址
 @param parameters 请求参数
 @param isJson    YES为Json  NO 不是 json
 @param successBlock 请求成功回调
 @param failureBlock 请求失败回调
 */
+ (void)postWithURLString:(NSString *)urlString
               parameters:(id)parameters
                   isJson:(BOOL)isJson
                isShowHud:(BOOL)isShowHud
                  success:(SuccessBlock)successBlock
                  failure:(FailureBlock)failureBlock;


/**
 post 请求上传图片
 
 @param urlString 请求地址
 @param parameters 请求参数
 @param successBlock 请求成功回调
 @param failureBlock 请求失败回调
 */
+ (void)postWithUrlString:(NSString *)urlString
               parameters:(id)parameters
                isShowHud:(BOOL)isShowHud
              uploadImage:(UIImage *)image
                  success:(SuccessBlock)successBlock
                  failure:(FailureBlock)failureBlock;




@end
