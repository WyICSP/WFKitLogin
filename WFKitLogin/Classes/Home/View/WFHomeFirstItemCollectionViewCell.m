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
    self.lookBtn.layer.cornerRadius = 19.0f;
    // Initialization code
}

- (void)setModel:(WFHomeDataModel *)model {
    self.banlance.text = [NSString stringWithFormat:@"%.2f",model.income.floatValue/100];
    self.dayIncome.text = [NSString stringWithFormat:@"%.2f",model.dayIncome.floatValue/100];
    self.pileNumber.text = [NSString stringWithFormat:@"%ld",(long)model.count];
    self.rete.text = [NSString stringWithFormat:@"%.2f",model.usage];
}

@end
