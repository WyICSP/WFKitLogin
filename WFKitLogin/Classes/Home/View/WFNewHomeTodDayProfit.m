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
    
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTodayEvent:)];
    [self.contentsView addGestureRecognizer:tap];
}

- (void)clickTodayEvent:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.contentsView];
    CGFloat x = point.x;
    CGFloat screenWidth = ScreenWidth - 30.0f;
    if (x <= screenWidth/3) {
        // 充电收入
        !self.clickTodayEventBlock ? : self.clickTodayEventBlock(10);
    } else if (x > screenWidth/3 && x < screenWidth/3*2) {
        // 分佣订单
        !self.clickTodayEventBlock ? : self.clickTodayEventBlock(10);
    }else {
        // 7日使用率
        !self.clickTodayEventBlock ? : self.clickTodayEventBlock(30);
    }
}

- (void)setModel:(WFNewHomeTodayIncomeModel *)model {
    // 今日收入
    NSString *chargingIncome = [NSString stringWithFormat:@"%.3f",[NSString decimalPriceWithDouble:model.chargingIncome.doubleValue/1000]];
    
    [AttributedLbl setRichTextOnlyFont:self.todayIncome titleString:chargingIncome textFont:[UIFont boldSystemFontOfSize:12.0f] fontRang:NSMakeRange(chargingIncome.length-4, 4)];
    
    // 昨日收
    self.yesterdayIncome.text = [NSString stringWithFormat:@"%ld",model.commissionOrderNum];
    
//    self.chargeNum.text = [NSString stringWithFormat:@"%ld",model.orderNum];
    
    self.nearRate.text = [NSString stringWithFormat:@"%@",[NSString decimalNumberWithDouble:model.utilizationRate]];
    
    // yes 表示上升
    self.updateBtn.selected = model.userRateStatus;
}

- (IBAction)clickDescBtn:(id)sender {
    !self.clickTodayEventBlock ? : self.clickTodayEventBlock(180);
}

@end
