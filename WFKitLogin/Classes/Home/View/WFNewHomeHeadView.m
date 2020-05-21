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
#import "AttributedLbl.h"
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
    
    // 商城收入
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickShopEvent:)];
    [self.shopIncomeMoney addGestureRecognizer:tap4];
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

- (void)clickShopEvent:(UITapGestureRecognizer *)sender {
    !self.clickHeadEventBlock ? : self.clickHeadEventBlock(140);
}

- (void)setModel:(WFNewHomeIncomeModel *)model {
    NSString *totalPrice = [NSString stringWithFormat:@"%.3f",[NSString decimalPriceWithDouble:model.totalRevenue.doubleValue/1000]];
    [AttributedLbl setRichTextOnlyFont:self.totalMoney titleString:totalPrice textFont:[UIFont boldSystemFontOfSize:16.0f] fontRang:NSMakeRange(totalPrice.length-4, 4)];
    
    NSString *chargePrice = [NSString stringWithFormat:@"%.3f",[NSString decimalPriceWithDouble:model.chargingIncome.doubleValue/1000]];
    [AttributedLbl setRichTextOnlyFont:self.chargeMoney titleString:chargePrice textFont:[UIFont boldSystemFontOfSize:14.0f] fontRang:NSMakeRange(chargePrice.length-4, 4)];
    
    NSString *rewardPrice = [NSString stringWithFormat:@"%.3f",[NSString decimalPriceWithDouble:model.bonusIncome.doubleValue/1000]];
    [AttributedLbl setRichTextOnlyFont:self.rewardMoney titleString:rewardPrice textFont:[UIFont boldSystemFontOfSize:14.0f] fontRang:NSMakeRange(rewardPrice.length-4, 4)];
    
    NSString *shopPrice = [NSString stringWithFormat:@"%.3f",[NSString decimalPriceWithDouble:model.shoppingIncome.doubleValue/1000]];
    [AttributedLbl setRichTextOnlyFont:self.shopIncomeMoney titleString:shopPrice textFont:[UIFont boldSystemFontOfSize:14.0f] fontRang:NSMakeRange(shopPrice.length-4, 4)];
    
    NSString *adver = model.advertisementName.length == 0 ? @"赚钱攻略：少安装少投入，多占点多宣传多服务" : model.advertisementName;
    self.marqueeControl.marqueeLabel.text = [NSString getNullOrNoNull:adver];
    
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
