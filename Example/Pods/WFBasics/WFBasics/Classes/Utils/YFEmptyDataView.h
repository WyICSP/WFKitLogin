//
//  YFEmptyDataView.h
//  YFBasicComponents_Example
//
//  Created by 王宇 on 2019/1/17.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFEmptyDataView : UIView
/**空图片*/
@property (weak, nonatomic) IBOutlet UIImageView *emptyImg;
/**文字描述*/
@property (weak, nonatomic) IBOutlet UILabel *emptyLbl;
/**按钮*/
@property (weak, nonatomic) IBOutlet UIButton *emptyBtn;
/**按钮点击事件*/
@property (nonatomic, copy) void (^clickEmptyBtnBlock)(void);
/**加载当前视图*/
+ (instancetype)loadEmptyView;

@end

NS_ASSUME_NONNULL_END
