//
//  WFRegisterViewController.m
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/4/15.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import "WFRegisterViewController.h"
#import "WFLoginBottomView.h"

#import "NSString+Regular.h"
#import "WKHelp.h"

@interface WFRegisterViewController ()
/**手机号*/
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
/**密码*/
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
/**发送验证码*/
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
/**发送验证码接口*/
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
/**注册按钮*/
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
/**上间距*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCons;
/**底部View*/
@property (nonatomic, strong, nullable) WFLoginBottomView *bottomView;

@end

@implementation WFRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

#pragma mark 页面调用
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma 私有方法
- (void)setUI {
    //设置页面离上面整体的高度
    self.topCons.constant = ISIPHONEX ? 162.0f - NavHeight + XHEIGHT : 162.0f - NavHeight;
    //设置圆角
    self.registerBtn.layer.cornerRadius = 20;
    //添加底部视图
    [self.view addSubview:self.bottomView];
    
}

- (void)leftImageButtonClick:(UIButton *)sender {
    [super goBack];
}

/**
 注册
 */
- (IBAction)clickRegisterBtn:(id)sender {
    [self.view endEditing:YES];
}

/**
 监听输入框
 
 @param textField textField
 */
- (IBAction)textFieldDidChange:(UITextField *)textField {
    if (textField == self.phoneTF && textField.text.length > 11) {
        textField.text = [textField.text substringWithRange:NSMakeRange(0, 11)];
    }
    
    //密码
    if ([NSString validateMobile:self.phoneTF.text] && ![NSString isBlankString:self.passwordTF.text] && ![NSString isBlankString:self.codeTF.text]) {
        self.registerBtn.enabled = YES;
        self.registerBtn.backgroundColor = UIColorFromRGB(0xFF6D22);
    }else{
        self.registerBtn.enabled = NO;
        self.registerBtn.backgroundColor = UIColorFromRGB(0xF6C8AC);
    }
}

/**
 底部 View
 
 @return WFLoginBottomView
 */
- (WFLoginBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"WFLoginBottomView" owner:nil options:nil] firstObject];
        _bottomView.frame = CGRectMake(0, ScreenHeight - 160 - NavHeight, ScreenWidth, 150);
        _bottomView.autoresizingMask = 0;
        _bottomView.lrType = WFLoginType;
        @weakify(self)
        _bottomView.jumpCtrlBlock = ^(UIViewController * _Nonnull ctrl, WFLoginAndRegisterType type) {
            @strongify(self)
            type == WFRegisterType ? [self.navigationController pushViewController:ctrl animated:YES] : [super goBack];
        };
    }
    return _bottomView;
}

@end
