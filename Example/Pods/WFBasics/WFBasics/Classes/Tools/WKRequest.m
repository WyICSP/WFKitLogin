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

//加密公钥
#define  RSA_Public_Key @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDKElEBrpz7lY7ADUqDKusCKWLrYHYmRNX5EM1tW8fyu3oRQHiNQqCzviI9W89e5k+v/48oGfA/wr5xlnXjr8ZEgZ4BXQU5qpGP1qzsX9S6MU/wHM2GFadkkXLwx2d/cP4Wvg35pOQmkXCIT+B2LaFBIx070B19XmY9NhIvly9VTwIDAQAB"
//加密常量
#define RSA_CONS_KEY @"502880496058fbb7016068fc201e0019"

//项目名
#define APP_NAME ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"])
//版本号
#define APP_VERSION ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])

#define TIMEOUT 15
#define ERROE @"请检查网络连接"

#import "WKRequest.h"
#import <AFNetworking/AFNetworking.h>
#import "SVProgressHUD+YFHud.h"

#import "YFKeyWindow.h"
#import "NSString+Regular.h"
#import "WFLocationTools.h"
#import "RSAEncryptor.h"
#import "Reachability.h"
#import "UserData.h"
#import "YFToast.h"



@implementation WKRequest

//监测网络状态的方法
+ (BOOL)YFNetWorkReachability
{
    BOOL netState = NO;
    Reachability *reMan = [Reachability reachabilityForInternetConnection];
    NetworkStatus  Status = [reMan currentReachabilityStatus];
    
    switch (Status) {
        case NotReachable:
            DLog(@"网络未连接");
            netState = NO;
            break;
            
        case ReachableViaWiFi:
            DLog(@"WIFI网络");
            netState = YES;
            break;
            
        case ReachableViaWWAN:
            DLog(@"2G,3G,4G网络");
            netState = YES;
            break;
            
        default:
            netState = NO;
            break;
    }
    
    return netState;
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
    
    AFHTTPSessionManager *manager = [self manager:NO];
    
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
        [YFToast showMessage:ERROE inView: [[[YFKeyWindow shareInstance] getCurrentVC] view]];
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
    
    AFHTTPSessionManager *manager = [self manager:isJson];
    
    if ([urlString containsString:@"DeviceCommand/sendChargeCommand"]) {
        manager.requestSerializer.timeoutInterval = 60;
    }else {
        // 请求超时时间
        manager.requestSerializer.timeoutInterval = TIMEOUT;
    }
    //把请求头进行 UTF-8编码
    NSString *path = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    DLog(@"接口 + 参数:%@-----------%@",urlString,[self dictionTransformationJson:parameters]);
    [manager POST:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
        [YFToast showMessage:ERROE inView: [[[YFKeyWindow shareInstance] getCurrentVC] view]];
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
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html",@"application/javascript",@"application/json", nil];
    //2.上传文件
    NSString *hostUrl = urlString;
    DLog(@"接口 + 参数:%@-----------%@",urlString,[self dictionTransformationJson:parameters]);
    [manager POST:hostUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *data = UIImageJPEGRepresentation(image, 0.1);
        //上传文件参数
        [formData appendPartWithFileData:data name:parameters fileName:@"flogo.png" mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印上传进度
        CGFloat progress = 100.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        [SVProgressHUD showProgress:progress];
        DLog(@"%.2lf%%", progress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        if (successBlock) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            WKBaseModel *baseModel = [[WKBaseModel alloc] initWithJsonObject:dic];
            successBlock(baseModel);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        //请求失败
        [YFToast showMessage:ERROE inView: [[[YFKeyWindow shareInstance] getCurrentVC] view]];
        
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

+ (AFHTTPSessionManager *)manager:(BOOL)isJson {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //可以接受的类型
    if (isJson) {
        //AFJSONRequestSerializer 自动解析 在我们 app 中的 post 请求必须用这个
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }else{
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html",@"application/javascript",@"application/json", nil];
    
    NSString *timestamp = [NSString getNowTimeTimestamp];
    
    NSString *headerStr = [NSString stringWithFormat:@"%@%@",timestamp,RSA_CONS_KEY];
    NSString *encryptStr = [RSAEncryptor encryptString:headerStr publicKey:RSA_Public_Key];
    
    [manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"appType"];
    [manager.requestSerializer setValue:APP_VERSION forHTTPHeaderField:@"appVersion"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"certType"];
    [manager.requestSerializer setValue:@"yzc-baidu" forHTTPHeaderField:@"channel"];
    [manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"deviceToken"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"isTest"];
    [manager.requestSerializer setValue:encryptStr forHTTPHeaderField:@"certification"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%f",[WFLocationTools shareInstace].latitude] forHTTPHeaderField:@"latitude"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%f",[WFLocationTools shareInstace].longitude] forHTTPHeaderField:@"longitude"];
    [manager.requestSerializer setValue:[NSString getCurrentDeviceModel] forHTTPHeaderField:@"osInformation"];
    [manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"plat"];
    [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"timestamp"];
    [manager.requestSerializer setValue:[UserData userInfo].uuid forHTTPHeaderField:@"userId"];
    [manager.requestSerializer setValue:[UserData userInfo].uuid forHTTPHeaderField:@"uuid"];
    [manager.requestSerializer setValue:@"1.0.0" forHTTPHeaderField:@"version"];
    
    return manager;
}
@end
