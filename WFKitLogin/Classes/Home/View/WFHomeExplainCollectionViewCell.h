//
//  WFHomeExplainCollectionViewCell.h
//  AFNetworking
//
//  Created by 王宇 on 2020/2/12.
//

#import <UIKit/UIKit.h>

@class WFHomeDataModel;

NS_ASSUME_NONNULL_BEGIN

@interface WFHomeExplainCollectionViewCell : UICollectionViewCell
/// 说明
@property (weak, nonatomic) IBOutlet UILabel *explanLbl;
/// 赋值
@property (nonatomic, strong) WFHomeDataModel *model;
/**初始化方法*/
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView
                             indexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
