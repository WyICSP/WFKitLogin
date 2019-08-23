//
//  SKAppUpdaterView.h
//  SKKit
//
//  Created by maxin on 2017/6/2.
//  Copyright © 2017年 maxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKAppUpdaterView : UIView

/**
 更新的文本描述
 */
@property (nonatomic,copy) NSString *content;
/**更新内容*/
@property (strong, nonatomic) UILabel *contentLabel;
/**更新内容滚动效果*/
@property (nonatomic, strong) UIScrollView *scrollView;
/**版本号*/
@property (weak, nonatomic) IBOutlet UILabel *version;
/**整个背景*/
@property (weak, nonatomic) IBOutlet UIView *updateBgView;
/**消失的按钮*/
@property (weak, nonatomic) IBOutlet UIButton *disapperBtn;
/**更新内容*/
@property (weak, nonatomic) IBOutlet UIView *contentView;
/**版本内容的高度*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewCons;
/**更新的url*/
@property (nonatomic, copy) NSString *appUrl;
/**更新内容*/
@property (nonatomic, strong) NSArray *versionList;

+ (instancetype)shareInstance;

@end
