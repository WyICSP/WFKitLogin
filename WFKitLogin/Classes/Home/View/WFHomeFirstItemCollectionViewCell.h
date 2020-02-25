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
/// 活动金 view
@property (weak, nonatomic) IBOutlet UIView *activityView;
/// 奖励 view
@property (weak, nonatomic) IBOutlet UIView *rewardView;
/// 奖励金额
@property (weak, nonatomic) IBOutlet UILabel *rewardPrice;
/// 活动金额
@property (weak, nonatomic) IBOutlet UILabel *activityPrice;
/**余额*/
@property (weak, nonatomic) IBOutlet UILabel *banlance;
/**日收入*/
@property (weak, nonatomic) IBOutlet UILabel *dayIncome;
/**充电桩数*/
@property (weak, nonatomic) IBOutlet UILabel *pileNumber;
/**使用率*/
@property (weak, nonatomic) IBOutlet UILabel *rete;
@property (weak, nonatomic) IBOutlet UILabel *rateLbl;

/**赋值*/
@property (nonatomic, strong) WFHomeDataModel *model;
/**点击查看详情 10 钱包 20 奖励 30活动*/
@property (nonatomic, copy) void (^clickLookDetailBlock)(NSInteger index);
/**初始化方法*/
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView
                             indexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
