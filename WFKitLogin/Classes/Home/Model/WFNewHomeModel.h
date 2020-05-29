//
//  WFNewHomeModel.h
//  AFNetworking
//
//  Created by 王宇 on 2020/4/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFNewHomeModel : NSObject
/// 异常充电桩
@property (nonatomic, assign) NSInteger errorNum;
/// 合伙人片区数量
@property (nonatomic, assign) NSInteger groupNum;
/// 当前合伙人在线充电桩
@property (nonatomic, assign) NSInteger onlineCdzNum;
/// 正在充电的
@property (nonatomic, assign) NSInteger onlineNum;
/// 所有已安装充电桩
@property (nonatomic, assign) NSInteger totalCdzNum;
/// 插座总数量
@property (nonatomic, assign) NSInteger totalNum;
@end

@interface WFNewHomeServiceModel : NSObject
/// 在线客服
@property (nonatomic, copy) NSString *customerServiceUrl;
/// 电话
@property (nonatomic, copy) NSString *customerMobile;
@end

@interface WFNewHomeIncomeModel : NSObject
/// 充电收入
@property (nonatomic, strong) NSNumber *chargingIncome;
/// 总收入
@property (nonatomic, strong) NSNumber *totalRevenue;
/// 奖励收入
@property (nonatomic, strong) NSNumber *bonusIncome;
/// 商城收入
@property (nonatomic, strong) NSNumber *shoppingIncome;
/// 淘宝链接
@property (nonatomic, copy) NSString *paySkipUrl;
/// 公告
@property (nonatomic, copy) NSString *advertisementName;
@end


@interface WFNewHomeTodayIncomeModel : NSObject
/// 充电收入
@property (nonatomic, strong) NSNumber *chargingIncome;
/// 昨日
@property (nonatomic, strong) NSNumber *yesterdayChargingIncome;
/// 总收入
@property (nonatomic, assign) NSInteger orderNum;
// 今日分佣  
@property (nonatomic, assign) NSInteger commissionIncome;
/// 奖励收入
@property (nonatomic, assign) double utilizationRate;
/// 上升还是下降
@property (nonatomic, assign) BOOL userRateStatus;
@end

NS_ASSUME_NONNULL_END
