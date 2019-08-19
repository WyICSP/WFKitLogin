//
//  WFHomeFirstItemCollectionViewCell.h
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/8/7.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WFHomeDataModel;

NS_ASSUME_NONNULL_BEGIN

@interface WFHomeFirstItemCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *lookBtn;
/**余额*/
@property (weak, nonatomic) IBOutlet UILabel *banlance;
/**日收入*/
@property (weak, nonatomic) IBOutlet UILabel *dayIncome;
/**充电桩数*/
@property (weak, nonatomic) IBOutlet UILabel *pileNumber;
/**使用率*/
@property (weak, nonatomic) IBOutlet UILabel *rete;
/**赋值*/
@property (nonatomic, strong) WFHomeDataModel *model;
/**初始化方法*/
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView
                             indexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
