//
//  WFHomeSectionItemCollectionViewCell.h
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/8/7.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WFHomeDataListModel;

NS_ASSUME_NONNULL_BEGIN

@interface WFHomeSectionItemCollectionViewCell : UICollectionViewCell
/**图片*/
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detailTitle;


/**赋值*/
@property (nonatomic, strong) WFHomeDataListModel *model;
/**初始化方法*/
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView
                             indexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
