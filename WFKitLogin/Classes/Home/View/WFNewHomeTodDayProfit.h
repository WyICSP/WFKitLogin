//
//  WFNewHomeTodDayProfit.h
//  WFKitLogin_Example
//
//  Created by 王宇 on 2020/4/23.
//  Copyright © 2020 wyxlh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WFNewHomeTodayIncomeModel;

NS_ASSUME_NONNULL_BEGIN

@interface WFNewHomeTodDayProfit : UIView
/// contents
@property (weak, nonatomic) IBOutlet UIView *contentsView;
/// 今日收入
@property (weak, nonatomic) IBOutlet UILabel *todayIncome;
/// 充电数量
@property (weak, nonatomic) IBOutlet UILabel *chargeNum;
///  7 日使用率
@property (weak, nonatomic) IBOutlet UILabel *nearRate;
/// 更新 btn
@property (weak, nonatomic) IBOutlet UIButton *updateBtn;

/// 点击事件
@property (copy, nonatomic) void (^clickTodayEventBlock)(NSInteger index);
/// 赋值
@property (strong, nonatomic) WFNewHomeTodayIncomeModel *model;
@end

NS_ASSUME_NONNULL_END
