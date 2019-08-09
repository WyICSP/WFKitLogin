//
//  UserData.h
//  YFKit
//
//  Created by 王宇 on 2018/5/14.
//  Copyright © 2018年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoData.h"

@interface UserData : NSObject
@property (retain, nonatomic) UserInfoData * userInfo;       //登录的用户资料
+ (UserInfoData *)userInfo;
+ (void)userInfo:(NSDictionary *)userInfo;
+ (BOOL)isUserLogin;
/**
 修改用户名

 @param UserName UserName
 */
+ (void)setUserName:(NSString *)UserName;

/**
 修改 密码
 
 @param password password description
 */
+ (void)setPassword:(NSString *)password;

/**
  是否是第一次登录

 @param loginFirstFlag 是否第一次登陆 1为第一次 0为非第一次
 */
+ (void)setLoginFirstFlag:(NSString *)loginFirstFlag;
@end

@interface NSString (extend)

+ (BOOL) isBlankString:(NSString *)string;

+ (NSString *)dictionTransformationJson:(NSDictionary *)parms;

@end
