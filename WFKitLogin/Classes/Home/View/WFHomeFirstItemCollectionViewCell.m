//
//  WFHomeFirstItemCollectionViewCell.m
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/8/7.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import "WFHomeFirstItemCollectionViewCell.h"
#import "WFHomeDataModel.h"


@implementation WFHomeFirstItemCollectionViewCell

static NSString *const cellId = @"WFHomeFirstItemCollectionViewCell";

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView
                             indexPath:(NSIndexPath *)indexPath {
    WFHomeFirstItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"WFHomeFirstItemCollectionViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.rateLbl.adjustsFontSizeToFitWidth = YES;
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMoneyTapGuetureEvent:)];
    [self.banlance addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickReTapGuetureEvent:)];
    [self.rewardView addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickActivityTapGuetureEvent:)];
    [self.activityView addGestureRecognizer:tap3];
    
}

- (void)setModel:(WFHomeDataModel *)model {
    self.banlance.text = [NSString stringWithFormat:@"%@",@(model.income.integerValue/100.0f)];
    self.activityPrice.text = [NSString stringWithFormat:@"%@",@(model.activityMoney.intValue/100.0f)];
    self.rewardPrice.text = [NSString stringWithFormat:@"%@",@(model.awardsMoney.intValue/100.0f)];
    self.dayIncome.text = [NSString stringWithFormat:@"%@",@(model.dayIncome.integerValue/100.0f)];
    self.pileNumber.text = [NSString stringWithFormat:@"%ld",(long)model.count];
    self.rete.text = [NSString stringWithFormat:@"%.2f",model.usage];
}

- (void)clickMoneyTapGuetureEvent:(id)sender {
    !self.clickLookDetailBlock ? : self.clickLookDetailBlock(10);
}

- (void)clickReTapGuetureEvent:(id)sender {
    !self.clickLookDetailBlock ? : self.clickLookDetailBlock(20);
}


- (void)clickActivityTapGuetureEvent:(id)sender {
    !self.clickLookDetailBlock ? : self.clickLookDetailBlock(30);
}


@end
