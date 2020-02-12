//
//  WFHomeExplainCollectionViewCell.m
//  AFNetworking
//
//  Created by 王宇 on 2020/2/12.
//

#import "WFHomeExplainCollectionViewCell.h"

@implementation WFHomeExplainCollectionViewCell

static NSString *const cellId = @"WFHomeExplainCollectionViewCell";

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView
                             indexPath:(NSIndexPath *)indexPath {
    WFHomeExplainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"WFHomeExplainCollectionViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.explanLbl.adjustsFontSizeToFitWidth = YES;
}

@end
