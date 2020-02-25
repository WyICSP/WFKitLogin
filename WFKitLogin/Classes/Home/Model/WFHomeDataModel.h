//
//  WFHomeDataModel.h
//  AFNetworking
//
//  Created by 王宇 on 2019/8/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFHomeDataModel : NSObject
/**收入*/
@property (nonatomic, strong) NSNumber *income;
/// 活动收入
@property (nonatomic, strong) NSNumber *activityMoney;
/// 奖励收入
@property (nonatomic, strong) NSNumber *awardsMoney;
/**使用率*/
@property (nonatomic, assign) CGFloat usage;
/**已发货充电桩台数*/
@property (nonatomic, assign) NSInteger count;
/**昨日收入 分*/
@property (nonatomic, strong) NSNumber *dayIncome;
/**数据*/
@property (nonatomic, strong) NSArray *list;
@end

@interface WFHomeDataListModel : NSObject
/**标识*/
@property (nonatomic, assign) NSInteger typeId;
/**title*/
@property (nonatomic, copy) NSString *title;
/**详细描述*/
@property (nonatomic, copy) NSString *detail;
/**图片*/
@property (nonatomic, copy) NSString *imgUrl;
/**url*/
@property (nonatomic, copy) NSString *goUrl;
@end

NS_ASSUME_NONNULL_END
