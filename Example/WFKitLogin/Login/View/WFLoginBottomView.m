//
//  WFLoginBottomView.m
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/4/15.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import "WFLoginBottomView.h"
#import "WFRegisterViewController.h"
#import "WFForgetPswViewController.h"

#import "WKHelp.h"

@interface WFLoginBottomView()
@property (weak, nonatomic) IBOutlet UIButton *registerOrLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *LRBtn;

@end

@implementation WFLoginBottomView

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setLrType:(WFLoginAndRegisterType)lrType {
    _lrType = lrType;
    [self.LRBtn setTitle:lrType == WFRegisterType ? @"注册" : @"登录" forState:0];
}

- (IBAction)clickBtn:(UIButton *)sender {
    if (sender.tag == 10) {
        //微信登录
        
    } else if (sender.tag == 20) {
        //忘记密码
        WFForgetPswViewController *registerUser = [[WFForgetPswViewController alloc] initWithNibName:@"WFForgetPswViewController" bundle:[NSBundle bundleForClass:[self class]]];
        !self.jumpCtrlBlock ? : self.jumpCtrlBlock(registerUser,self.lrType);
    } else {
        //注册
        WFRegisterViewController *forget = [[WFRegisterViewController alloc] initWithNibName:@"WFRegisterViewController" bundle:[NSBundle bundleForClass:[self class]]];
        !self.jumpCtrlBlock ? : self.jumpCtrlBlock(forget,self.lrType);
    }
}

@end
