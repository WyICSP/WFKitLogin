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
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *token;

@property (nonatomic, copy) NSString *accountId;
/**1,//是否第一次登陆 1为第一次 0为非第一次*/
@property (nonatomic, copy) NSString *loginFirstFlag;
@property (nonatomic, copy) NSString *memberType;
@property (nonatomic, copy) NSString *receiveAddress;
@property (nonatomic, copy) NSString *receiveSite;
/**结算方式 1 月结 2 到付*/
@property (nonatomic, copy) NSString *settlementMethod;
/**logo*/
@property (nonatomic, copy) NSString *shopDoorPhotoUrl;
/**店名*/
@property (nonatomic, copy) NSString *shopName;
/**店主名*/
@property (nonatomic, copy) NSString *shopkeeperName;
/**0为app账号 1 为 wms*/
@property (nonatomic, copy) NSString *type;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
NS_ASSUME_NONNULL_END
@end
