//
//  UserInfoData.m
//  YFKit
//
//  Created by 王宇 on 2018/5/14.
//  Copyright © 2018年 wy. All rights reserved.
//


#import "UserInfoData.h"

@implementation UserInfoData

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"companyAddress"]] forKey:@"companyAddress"];
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"gender"]] forKey:@"gender"];
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"giveMoney"]] forKey:@"giveMoney"];
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"headImage"]] forKey:@"headImage"];
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"id"]] forKey:@"Id"];
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"idCard"]] forKey:@"idCard"];
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"uuid"]] forKey:@"uuid"];
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"lastMonthSpendMoney"]] forKey:@"lastMonthSpendMoney"];
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"lastTimeLatitude"]] forKey:@"lastTimeLatitude"];
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"lastTimeLongitude"]] forKey:@"lastTimeLongitude"];
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"mobile"]] forKey:@"mobile"];
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"nickname"]] forKey:@"nickname"];
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"points"]] forKey:@"points"];
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"password"]] forKey:@"password"];
    }
    
    return self;
}

@end
