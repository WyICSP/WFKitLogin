//
//  WFPayTypeMsgModel.h
//  AFNetworking
//
//  Created by 王宇 on 2019/8/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFPayTypeMsgModel : NSObject
/**支付宝支付参数*/
@property (nonatomic, copy) NSString *aliPay;
@property (nonatomic, copy) NSString *package;
/**微信APPID*/
@property (nonatomic, copy) NSString *appid;
/**appSecret*/
@property (nonatomic, copy) NSString *appSecret;
@property (nonatomic, copy) NSString *sign;
/**商户号*/
@property (nonatomic, copy) NSString *partnerid;
/**前后台约定的一个值*/
@property (nonatomic, copy) NSString *partnerKey;
/**预支付单号*/
@property (nonatomic, copy) NSString *prepayid;
@property (nonatomic, copy) NSString *noncestr;
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *rechargeId;
@end

NS_ASSUME_NONNULL_END
