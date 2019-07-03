//
//  WKRequest.m
//  YukiFramework
//
//  Created by 王宇 on 2017/11/13.
//  Copyright © 2017年 wy. All rights reserved.
//
#ifdef DEBUG
#define DLog( s, ... )                          NSLog( @"<%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DLog( s, ... )
#endif

#define TIMEOUT 15
#define ERROE @"服务端繁忙,请稍后再试!"

#import "WKRequest.h"
#import <AFNetworking/AFNetworking.h>
#import "SVProgressHUD+YFHud.h"
#import "UserData.h"

@implementation WKRequest

//监测网络状态的方法
+ (BOOL)YFNetWorkReachability
{
    static BOOL isNetWork;
    // 开始监测
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 网络状态改变的回调
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
//                NSLog(@"蜂窝网络");
                isNetWork = YES;
                break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
//                NSLog(@"WIFI");
                isNetWork = YES;
                break;
                case AFNetworkReachabilityStatusNotReachable:
//                NSLog(@"没有网络");
                isNetWork = NO;
                break;
                case AFNetworkReachabilityStatusUnknown:
//                NSLog(@"未知");
                isNetWork = YES;
                break;
            default:
                break;
        }
    }];
    return isNetWork;
}

/**
 *  get 网络请求
 *
 *  @param urlString    请求的网址字符串
 *  @param parameters   请求的参数
 *  @param successBlock 请求成功回调
 *  @param failureBlock 请求失败回调
 */
+ (void)getWithURLString:(NSString *)urlString
             parameters:(id)parameters
               isShowHud:(BOOL)isShowHud
                success:(SuccessBlock)successBlock
                failure:(FailureBlock)failureBlock{
    
    if (isShowHud) {[SVProgressHUD showWithStatus:@"加载中..."];}
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //可以接受的类型 AFHTTPResponseSerializer 手动解析
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html",@"application/javascript",@"application/json", nil];
    
    NSString *header = [UserData userInfo].token;
//
    [manager.requestSerializer setValue:header forHTTPHeaderField:@"token"];
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    //请求超时的时间
    manager.requestSerializer.timeoutInterval = TIMEOUT;
    //把请求头进行 UTF-8编码
    NSString *path = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    DLog(@"接口 + 参数:%@-----------%@",urlString,[self dictionTransformationJson:parameters]);
    [manager GET:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        if (successBlock) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            WKBaseModel *baseModel = [[WKBaseModel alloc]initWithJsonObject:dic];
            successBlock(baseModel);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

/**
 get 请求  请求注册协议
 
 @param urlString 请求地址
 @param parameters 请求参数
 @param successBlock 请求成功回调
 @param failureBlock 请求失败回调
 */
+(void)getRegisterWithURLString:(NSString *)urlString
                     parameters:(id)parameters
                      isShowHud:(BOOL)isShowHud
                        success:(void(^)(NSString *))successBlock
                        failure:(FailureBlock)failureBlock{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //可以接受的类型 AFHTTPResponseSerializer 手动解析
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html",@"application/javascript",@"application/json", nil];
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    //请求超时的时间
    manager.requestSerializer.timeoutInterval = TIMEOUT;
    //把请求头进行 UTF-8编码
    NSString *path = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
//    DLog(@"接口 + 参数:%@-----------%@",hostUrl,[self dictionTransformationJson:parameters]);

    [manager GET:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (successBlock) {
            successBlock(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}


/**
 *  post网络请求
 *
 *  @param urlString    请求的网址字符串
 *  @param parameters   请求的参数
 *  @param isJson YES为Json  NO 不是 json
 *  @param successBlock 请求成功回调
 *  @param failureBlock 请求失败回调
 */
+ (void)postWithURLString:(NSString *)urlString
              parameters:(id)parameters
                  isJson:(BOOL)isJson
               isShowHud:(BOOL)isShowHud
                 success:(SuccessBlock)successBlock
                 failure:(FailureBlock)failureBlock{
    
    if (isShowHud) {[SVProgressHUD showWithStatus:@"加载中..."];}
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //可以接受的类型
    if (isJson) {
        //AFJSONRequestSerializer 自动解析 在我们 app 中的 post 请求必须用这个
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }else{
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html",@"application/javascript",@"application/json", nil];
    
    NSString *header = [UserData userInfo].token;
    // 注册接口 需要把把参数进行 UTF-8编码
    if ([urlString isEqualToString:@"register/regBase.do"]) {
        
        [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
    }else{
        [manager.requestSerializer setValue:header forHTTPHeaderField:@"token"];
//        [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    }
    // 请求超时时间
    manager.requestSerializer.timeoutInterval = TIMEOUT;
    //把请求头进行 UTF-8编码
    NSString *path = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableDictionary *parms = [parameters mutableCopy];

    DLog(@"接口 + 参数:%@-----------%@",urlString,[self dictionTransformationJson:parameters]);
    [manager POST:path parameters:parms progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        if (successBlock) {
            if (isJson) {
                
                WKBaseModel *baseModel = [[WKBaseModel alloc]initWithJsonObject:responseObject];
                successBlock(baseModel);
            }else{
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                WKBaseModel *baseModel = [[WKBaseModel alloc]initWithJsonObject:dic];
                successBlock(baseModel);
            }

        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    

}

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
                  failure:(FailureBlock)failureBlock{
    
    if (isShowHud) {[SVProgressHUD showWithStatus:@"加载中..."];}
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置token
    NSString *header = [UserData userInfo].token;
    [manager.requestSerializer setValue:header forHTTPHeaderField:@"token"];
    //2.上传文件
    NSString *hostUrl = urlString;
    [manager POST:hostUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
         NSData *data = UIImageJPEGRepresentation(image, 0.1);
        //上传文件参数
        [formData appendPartWithFileData:data name:@"userHeader" fileName:@"userHeader.png" mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印上传进度
        CGFloat progress = 100.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        [SVProgressHUD showProgress:progress];
        DLog(@"%.2lf%%", progress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        if (successBlock) {
            WKBaseModel *baseModel = [[WKBaseModel alloc]initWithJsonObject:responseObject];
            successBlock(baseModel);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        //请求失败
//        [YFToast showMessage:ERROE inView: [[[YFKeyWindow shareInstance] getCurrentVC] view]];
        if (failureBlock) {
            failureBlock(error);
        }
        
    }];
}

/**
 字典转 Json

 @param parms 传入的字典,
 @return 返回的 json 字符串
 */
+ (NSString *)dictionTransformationJson:(NSDictionary *)parms{
    NSError *error;
    NSString *jsonStr = @"";
    if ([parms isKindOfClass:[NSDictionary class]]) {
         NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parms options:NSJSONWritingPrettyPrinted error:&error];
         jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonStr;
}

/**
  token 失效
 @param baseModel 网络请求的返回值
 */
//+ (void)tokenInvalid:(WKBaseModel *)baseModel{
//    if (CODE_TOKEN) {
//        //token 失效
//        [UserData userInfo:nil];
////        KUSERNOTLOGIN
//    }
//}
@end
