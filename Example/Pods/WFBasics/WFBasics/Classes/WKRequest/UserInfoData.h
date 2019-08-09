//
//  UserInfoData.h
//  YFKit
//
//  Created by 王宇 on 2018/5/14.
//  Copyright © 2018年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoData : NSObject
NS_ASSUME_NONNULL_BEGIN
/**公司地址*/
@property (nonatomic, copy) NSString *companyAddress;
/**性别*/
@property (nonatomic, copy) NSString *gender;
/**用户充值赠送金额*/
@property (nonatomic, copy) NSString *giveMoney;
/**头像*/
@property (nonatomic, copy) NSString *headImage;
/**记录ID*/
@property (nonatomic, copy) NSString *Id;
/**实名认证的身份证号*/
@property (nonatomic, copy) NSString *idCard;
/**uuid*/
@property (nonatomic, copy) NSString *uuid;
/**上月花费总金额*/
@property (nonatomic, copy) NSString *lastMonthSpendMoney;
/**经纬度*/
@property (nonatomic, copy) NSString *lastTimeLatitude;
/**经纬度*/
@property (nonatomic, copy) NSString *lastTimeLongitude;
/**手机*/
@property (nonatomic, copy) NSString *mobile;
/**用户充值余额*/
@property (nonatomic, copy) NSString *money;
/**昵称*/
@property (nonatomic, copy) NSString *nickname;
/**密码*/
@property (nonatomic, copy) NSString *password;
/**积分*/
@property (nonatomic, copy) NSString *points;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
NS_ASSUME_NONNULL_END
@end
