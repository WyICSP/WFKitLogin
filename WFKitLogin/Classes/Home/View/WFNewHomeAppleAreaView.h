//
//  WFNewHomeAppleAreaView.h
//  WFKitLogin_Example
//
//  Created by 王宇 on 2020/4/23.
//  Copyright © 2020 wyxlh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFNewHomeAppleAreaView : UIView
/// 申请设备
@property (weak, nonatomic) IBOutlet UIButton *applyPileBtn;
/// 申请片区
@property (weak, nonatomic) IBOutlet UIButton *applyArea;

@property (copy, nonatomic) void (^clickAreaEventBlock)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
