//
//  WFNewHomeTodDayProfit.m
//  WFKitLogin_Example
//
//  Created by 王宇 on 2020/4/23.
//  Copyright © 2020 wyxlh. All rights reserved.
//

#import "WFNewHomeTodDayProfit.h"
#import "NSString+Regular.h"
#import "WFNewHomeModel.h"
#import "AttributedLbl.h"
#import "WKConfig.h"

@implementation WFNewHomeTodDayProfit

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentsView.layer.cornerRadius = 10.0f;
    self.nearLbl.adjustsFontSizeToFitWidth = YES;
    
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTodayEvent:)];
    [self.contentsView addGestureRecognizer:tap];
}

- (void)clickTodayEvent:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.contentsView];
    CGFloat x = point.x;
    CGFloat screenWidth = ScreenWidth - 30.0f;
    if (x <= screenWidth/3) {
        // 今日收入
        !self.clickTodayEventBlock ? : self.clickTodayEventBlock(10);
    } else if (x > screenWidth/3 && x < screenWidth/3*2) {
        //充电订单
        !self.clickTodayEventBlock ? : self.clickTodayEventBlock(20);
    } else {
        // 7日使用率
        !self.clickTodayEventBlock ? : self.clickTodayEventBlock(30);
    }
}

- (void)setModel:(WFNewHomeTodayIncomeModel *)model {
    // 今日收入
    NSString *chargingIncome = [NSString stringWithFormat:@"%.3f",[NSString decimalPriceWithDouble:model.chargingIncome.doubleValue/1000]];
    
    [AttributedLbl setRichTextOnlyFont:self.todayIncome titleString:chargingIncome textFont:[UIFont boldSystemFontOfSize:12.0f] fontRang:NSMakeRange(chargingIncome.length-4, 4)];
    
    // 昨日收入
    NSString *yesterdayIncome = [NSString stringWithFormat:@"%.3f",[NSString decimalPriceWithDouble:model.yesterdayChargingIncome.doubleValue/1000]];
    
    [AttributedLbl setRichTextOnlyFont:self.yesterdayIncome titleString:yesterdayIncome textFont:[UIFont boldSystemFontOfSize:12.0f] fontRang:NSMakeRange(yesterdayIncome.length-4, 4)];
    
    self.chargeNum.text = [NSString stringWithFormat:@"%ld",model.orderNum];
    
    self.nearRate.text = [NSString stringWithFormat:@"%@",[NSString decimalNumberWithDouble:model.utilizationRate]];
    
    // yes 表示上升
    self.updateBtn.selected = model.userRateStatus;
}

@end
