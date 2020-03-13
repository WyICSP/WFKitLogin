//
//  WFHomeNullCollectionViewCell.h
//  AFNetworking
//
//  Created by 王宇 on 2020/3/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFHomeNullCollectionViewCell : UICollectionViewCell
/**初始化方法*/
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView
                             indexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
