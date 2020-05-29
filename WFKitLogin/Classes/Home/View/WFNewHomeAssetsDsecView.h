//
//  WFNewHomeAssetsDsecView.h
//  AFNetworking
//
//  Created by 王宇 on 2020/5/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFNewHomeAssetsDsecView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btn;
/// 消失
@property (copy, nonatomic) void(^clickDissaperBlock)(void);
@end

NS_ASSUME_NONNULL_END
