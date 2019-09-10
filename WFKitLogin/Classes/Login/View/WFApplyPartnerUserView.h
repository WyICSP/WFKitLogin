//
//  WFApplyPartnerUserView.h
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/8/7.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFApplyPartnerUserView : UIView
/**姓名View*/
@property (weak, nonatomic) IBOutlet UIView *nameView;
/**姓名*/
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
/**电话View*/
@property (weak, nonatomic) IBOutlet UIView *phoneView;
/**电话*/
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
/**地址View*/
@property (weak, nonatomic) IBOutlet UIView *areaView;
/**地址按钮*/
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
/**申请数量*/
@property (weak, nonatomic) IBOutlet UIView *numView;
/**减号*/
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
/**数量*/
@property (weak, nonatomic) IBOutlet UITextField *numTF;
/**加号按钮*/
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
/**view的高度*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeightCons;
/**常见问题*/
@property (nonatomic, copy) void (^clickCommonProblemBlock)(void);

@end

NS_ASSUME_NONNULL_END
