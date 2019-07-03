//
//  WFForgetPswViewController.m
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/4/15.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import "WFForgetPswViewController.h"

#import "NSString+Regular.h"
#import "WKHelp.h"

@interface WFForgetPswViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *nPswTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCons;

@end

@implementation WFForgetPswViewController

#pragma mark 生命周期
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
    self.saveBtn.layer.cornerRadius = 20;
    
}

/**
 忘记密码
 */
- (IBAction)clickForgetPswBtn:(id)sender {
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
    if ([NSString validateMobile:self.phoneTF.text] && ![NSString isBlankString:self.codeTF.text] && ![NSString isBlankString:self.nPswTF.text]) {
        self.saveBtn.enabled = YES;
        self.saveBtn.backgroundColor = UIColorFromRGB(0xFF6D22);
    }else{
        self.saveBtn.enabled = NO;
        self.saveBtn.backgroundColor = UIColorFromRGB(0xF6C8AC);
    }
}


@end
