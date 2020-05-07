//
//  WFNewHomeAssetsView.h
//  WFKitLogin_Example
//
//  Created by 王宇 on 2020/4/23.
//  Copyright © 2020 wyxlh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WFNewHomeModel;

NS_ASSUME_NONNULL_BEGIN

@interface WFNewHomeAssetsView : UIView
/// contentsView
@property (weak, nonatomic) IBOutlet UIView *contentsView;
/// 片区数量
@property (weak, nonatomic) IBOutlet UILabel *groupNum;
/// 设备在线数量
@property (weak, nonatomic) IBOutlet UILabel *equOnlineNum;
/// 设备总数量
@property (weak, nonatomic) IBOutlet UILabel *equTotalNum;
/// 故障数量
@property (weak, nonatomic) IBOutlet UILabel *errorNum;
/// 插座在线数量
@property (weak, nonatomic) IBOutlet UILabel *sctOneLineNum;
/// 插座总数量
@property (weak, nonatomic) IBOutlet UILabel *sctTotalNum;
/// 点击事件
@property (copy, nonatomic) void (^clickAssetsEventBlock)(NSInteger index);
/// 赋值
@property (nonatomic, strong) WFNewHomeModel *model;
@end

NS_ASSUME_NONNULL_END
