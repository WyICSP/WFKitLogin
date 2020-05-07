//
//  WFNewHomeHeadView.m
//  WFKitLogin_Example
//
//  Created by 王宇 on 2020/4/23.
//  Copyright © 2020 wyxlh. All rights reserved.
//

#import "WFNewHomeHeadView.h"
#import "WFNewHomeModel.h"
#import "NSString+Regular.h"
#import "WFHorseRaceLamp.h"
#import "WKConfig.h"

@interface WFNewHomeHeadView ()
@property (nonatomic, weak) WFHorseRaceLamp *marqueeControl;
@end

@implementation WFNewHomeHeadView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bellView.layer.cornerRadius = 35.0f/2;
    
    //添加手势
    // 通告
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBellEvent:)];
    [self.bellView addGestureRecognizer:tap];
    
    // 总收入
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTotalMoneyEvent:)];
    [self.totalMoney addGestureRecognizer:tap1];
    
    // 充电收入
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickChargeEvent:)];
    [self.chargeMoney addGestureRecognizer:tap2];
    
    // 奖励收入
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRewardEvent:)];
    [self.rewardMoney addGestureRecognizer:tap3];
}

- (void)clickBellEvent:(UITapGestureRecognizer *)sender {
    !self.clickHeadEventBlock ? : self.clickHeadEventBlock(130);
}

- (void)clickTotalMoneyEvent:(UITapGestureRecognizer *)sender {
    !self.clickHeadEventBlock ? : self.clickHeadEventBlock(100);
}

- (void)clickChargeEvent:(UITapGestureRecognizer *)sender {
    !self.clickHeadEventBlock ? : self.clickHeadEventBlock(110);
}

- (void)clickRewardEvent:(UITapGestureRecognizer *)sender {
    !self.clickHeadEventBlock ? : self.clickHeadEventBlock(120);
}

- (void)setModel:(WFNewHomeIncomeModel *)model {
    NSString *totalPrice = [NSString stringWithFormat:@"%@",[NSString decimalNumberWithDouble:model.totalRevenue.doubleValue/1000]];
    self.totalMoney.text = [NSString stringWithFormat:@"%@",totalPrice];
    
    NSString *chargePrice = [NSString stringWithFormat:@"%@",[NSString decimalNumberWithDouble:model.chargingIncome.doubleValue/1000]];
    self.chargeMoney.text = [NSString stringWithFormat:@"%@",chargePrice];
    
    NSString *rewardPrice = [NSString stringWithFormat:@"%@",[NSString decimalNumberWithDouble:model.bonusIncome.doubleValue/1000]];
    self.rewardMoney.text = [NSString stringWithFormat:@"%@",rewardPrice];
    
    self.marqueeControl.marqueeLabel.text = [NSString stringWithFormat:@"%@",model.advertisementName];
    
}


- (WFHorseRaceLamp *)marqueeControl {
    if (!_marqueeControl) {
        WFHorseRaceLamp *control = [[WFHorseRaceLamp alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.logo.frame) + 10.0f, 0, ScreenWidth-67.0f, 35.0f)];
        control.backgroundColor = [UIColor clearColor];
        control.marqueeLabel.textColor = UIColorFromRGB(0xFFA213);
        control.marqueeLabel.font = [UIFont systemFontOfSize:12.0f];
        [self.bellView addSubview:control];
        
        _marqueeControl = control;
    }
    
    return _marqueeControl;
}

@end
