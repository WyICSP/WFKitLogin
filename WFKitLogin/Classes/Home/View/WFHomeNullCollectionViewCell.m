//
//  WFHomeNullCollectionViewCell.m
//  AFNetworking
//
//  Created by 王宇 on 2020/3/13.
//

#import "WFHomeNullCollectionViewCell.h"

@implementation WFHomeNullCollectionViewCell

static NSString *const cellId = @"WFHomeNullCollectionViewCell";

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView
                             indexPath:(NSIndexPath *)indexPath {
    WFHomeNullCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"WFHomeNullCollectionViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
