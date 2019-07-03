//
//  UserInfoData.m
//  YFKit
//
//  Created by 王宇 on 2018/5/14.
//  Copyright © 2018年 wy. All rights reserved.
//

//@property (nonatomic, copy) NSString *mobile;
//@property (nonatomic, copy) NSString *token;
//
//@property (nonatomic, copy) NSString *accountId;
///**1,//是否第一次登陆 1为第一次 0为非第一次*/
//@property (nonatomic, copy) NSString *loginFirstFlag;
//@property (nonatomic, copy) NSString *memberType;
//@property (nonatomic, copy) NSString *receiveAddress;
//@property (nonatomic, copy) NSString *receiveSite;
///**结算方式 1 月结 2 到付*/
//@property (nonatomic, copy) NSString *settlementMethod;
///**logo*/
//@property (nonatomic, copy) NSString *shopDoorPhotoUrl;
///**店名*/
//@property (nonatomic, copy) NSString *shopName;
///**店主名*/
//@property (nonatomic, copy) NSString *shopkeeperName;
///**0为app账号 1 为 wms*/
//@property (nonatomic, copy) NSString *type;

#import "UserInfoData.h"

@implementation UserInfoData

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"mobile"]] forKey:@"mobile"];
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"token"]] forKey:@"token"];
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"accountId"]] forKey:@"accountId"];
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"loginFirstFlag"]] forKey:@"loginFirstFlag"];
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"memberType"]] forKey:@"memberType"];
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"receiveAddress"]] forKey:@"receiveAddress"];
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"receiveSite"]] forKey:@"receiveSite"];
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"settlementMethod"]] forKey:@"settlementMethod"];
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"shopDoorPhotoUrl"]] forKey:@"shopDoorPhotoUrl"];
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"shopName"]] forKey:@"shopName"];
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"shopkeeperName"]] forKey:@"shopkeeperName"];
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"type"]] forKey:@"type"];
        
    }
    
    return self;
}

@end
