//
//  UserData.m
//  YFKit
//
//  Created by 王宇 on 2018/5/14.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "UserData.h"

@implementation UserData

+(UserInfoData *)userInfo{
    
    NSString *dicStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"Info"];
    if (dicStr.length == 0) {
        return nil;
    }
    NSData *data = [dicStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    UserInfoData *infodata = nil;
    if ([dic isKindOfClass:[NSDictionary class]]) {
        infodata = [[UserInfoData alloc] initWithDictionary:dic];
    }else{
        return nil;
    }
    return infodata;
}

+(void)userInfo:(NSDictionary *)userInfo{
    
    if ([userInfo isKindOfClass:[NSDictionary class]]) {
        NSString *userInfoStr = [NSString dictionTransformationJson:userInfo];
        [[NSUserDefaults standardUserDefaults] setObject:userInfoStr forKey:@"Info"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"Info"];
        [[NSUserDefaults standardUserDefaults] setObject:@[] forKey:@"TAOBAO_USERID"];
        [[NSUserDefaults standardUserDefaults] setObject:@[] forKey:@"SearchHistoryArray"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
    }
}

+ (BOOL)isUserLogin{
    NSString *dicStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"Info"];
    if ([NSString isBlankString:dicStr]) {
        return NO;
    }
    NSData *data = [dicStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if ([dic isKindOfClass:[NSDictionary class]]) {
        NSString *Id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
        if (![NSString isBlankString:Id]) {
            return YES;
        }
    }
    return NO;
}

+ (void)setUserName:(NSString *)UserName{
    NSString *dicStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"Info"];
    if ([NSString isBlankString:dicStr]) {
        return;
    }
    NSData *data = [dicStr dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    [dict setObject:UserName forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"Info"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    dict = nil;
}

+ (void)setPassword:(NSString *)password {
    NSString *dicStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"Info"];
    if ([NSString isBlankString:dicStr]) {
        return;
    }
    NSData *data = [dicStr dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil]];
    [dict setObject:password forKey:@"password"];
    NSString *userInfoStr = [NSString dictionTransformationJson:dict];
    [[NSUserDefaults standardUserDefaults] setObject:userInfoStr forKey:@"Info"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    dict = nil;
}

+ (void)setLoginFirstFlag:(NSString *)loginFirstFlag {
    NSString *dicStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"Info"];
    if ([NSString isBlankString:dicStr]) {
        return;
    }
    NSData *data = [dicStr dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil]];
    [dict setObject:loginFirstFlag forKey:@"loginFirstFlag"];
    NSString *userInfoStr = [NSString dictionTransformationJson:dict];
    [[NSUserDefaults standardUserDefaults] setObject:userInfoStr forKey:@"Info"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    dict = nil;
}




@end

@implementation NSString (extend)

+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (NSString *)dictionTransformationJson:(NSDictionary *)parms{
    NSError *error;
    NSString *jsonStr = @"";
    if ([parms isKindOfClass:[NSDictionary class]]) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parms options:NSJSONWritingPrettyPrinted error:&error];
        jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonStr;
}

@end;
