//
//  WFNewHomeHeadView.h
//  WFKitLogin_Example
//
//  Created by 王宇 on 2020/4/23.
//  Copyright © 2020 wyxlh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WFNewHomeIncomeModel;

NS_ASSUME_NONNULL_BEGIN

@interface WFNewHomeHeadView : UIView
/// 公告
@property (weak, nonatomic) IBOutlet UIView *bellView;
/// 总收入
@property (weak, nonatomic) IBOutlet UILabel *totalMoney;
/// 充电收入
@property (weak, nonatomic) IBOutlet UILabel *chargeMoney;
/// 奖励收入
@property (weak, nonatomic) IBOutlet UILabel *rewardMoney;
/// 小铃铛
@property (weak, nonatomic) IBOutlet UIImageView *logo;
/// 点击事件
@property (copy, nonatomic) void (^clickHeadEventBlock)(NSInteger index);
/// 赋值
@property (strong, nonatomic) WFNewHomeIncomeModel *model;
@end

NS_ASSUME_NONNULL_END
