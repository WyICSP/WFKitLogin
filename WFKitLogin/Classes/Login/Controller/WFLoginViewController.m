//
//  WFLoginViewController.m
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/4/15.
//  Copyright © 2019 wyxlh. All rights reserved.
//
#define USERPHONE [YFUserDefaults objectForKey:@"USERPHONE"]

#import "WFLoginViewController.h"
#import "WFApplyPartnerViewController.h"
#import "YFMediatorManager+YFKitMain.h"
#import "WFSecuritySetViewController.h"
#import "WFHomeSaveDataTool.h"
#import "NSString+Regular.h"
#import "WFLoginDataTool.h"
#import "SKSafeObject.h"
#import "UserData.h"
#import "YFToast.h"
#import "WKProxy.h"
#import "WKTimer.h"
#import "WKHelp.h"


@interface WFLoginViewController ()
/**背景 view*/
@property (weak, nonatomic) IBOutlet UIView *contentView;
/**验证码登录 view*/
@property (weak, nonatomic) IBOutlet UIView *codeView;
/**titlelbl*/
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
/**手机号*/
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
/**密码*/
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
/**验证码*/
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
/**验证码登录*/
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
/**登录按钮*/
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
/**加入云智充*/
@property (weak, nonatomic) IBOutlet UIButton *addYzcBtn;
/**交换登录方式 btn*/
@property (weak, nonatomic) IBOutlet UIButton *exChangeBtn;
/**验证码 lbl*/
@property (weak, nonatomic) IBOutlet UILabel *codeLbl;
/**定时器*/
@property (copy, nonatomic) NSString *task;
/**倒计时*/
@property (nonatomic, assign) NSInteger countIndex;

@end

@implementation WFLoginViewController

#pragma mark 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 开启
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    [WKTimer cancelTask:self.task];
    [self userEnableBtn];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark 接口
+ (instancetype)shareInstance {
    static WFLoginViewController *login;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        login = [[WFLoginViewController alloc] initWithNibName:@"WFLoginViewController" bundle:[NSBundle bundleForClass:[self class]]];
    });
    return login;
}

#pragma mark 页面调用
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma 私有方法
- (void)setUI {
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    self.contentView.layer.cornerRadius = 6.0f;
    //设置圆角
    self.loginBtn.layer.cornerRadius = self.addYzcBtn.layer.cornerRadius = 20.0f;
    //设置边框
    self.addYzcBtn.layer.borderColor = UIColorFromRGB(0xE4E4E4).CGColor;
    self.addYzcBtn.layer.borderWidth = 1.0f;
    //设置手机号
    self.phoneTF.text = [NSString isBlankString:USERPHONE] ? @"" : USERPHONE;
    //添加返回按钮
//    [self addLeftImageBtn:@"Back"];
    //倒计时初始值
    self.countIndex = 60;
    //获取地址信息
    if ([[WFHomeSaveDataTool shareInstance] readAddressFile].count == 0) [self getAddress];
    
}

//- (void)leftImageButtonClick:(UIButton *)sender {
//    [super goBack];
//}

#pragma mark 登录操作
- (IBAction)clickLoginBtn:(id)sender {
    [self.view endEditing:YES];
    
    if (!self.exChangeBtn.selected) {
        //密码登录
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params safeSetObject:self.phoneTF.text forKey:@"mobile"];
        [params safeSetObject:self.passwordTF.text forKey:@"password"];
        @weakify(self)
        [WFLoginDataTool loginWithParams:params resultBlock:^(NSDictionary * _Nonnull models) {
            @strongify(self)
            [self loginSuccessWithmDictionary:models];
        }];
    }else {
        //验证码登录
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params safeSetObject:self.phoneTF.text forKey:@"mobile"];
        [params safeSetObject:self.codeTF.text forKey:@"code"];
        @weakify(self)
        [WFLoginDataTool quickLoginWithParams:params resultBlock:^(NSDictionary * _Nonnull models) {
            @strongify(self)
            [self loginSuccessWithmDictionary:models];
        }];
    }
}

- (void)loginSuccessWithmDictionary:(NSDictionary *)mDictionary {
    if (!self.exChangeBtn.selected && [self.phoneTF.text isEqualToString:self.passwordTF.text]) {
        //密码登录的时候 手机号和密码相同 需要重新设置密码
        WFSecuritySetViewController *security = [[WFSecuritySetViewController alloc] initWithNibName:@"WFSecuritySetViewController" bundle:[NSBundle bundleForClass:[self class]]];
        WFSecuritySetType sType = self.loginType == WFJumpLoginCtrlH5Tpye ? WFSecuritySetComType : WFSecuritySetUpgradeType;
        security.secutityType(sType).userMoblie(self.phoneTF.text).userLoginInfo(mDictionary);
        [self.navigationController pushViewController:security animated:YES];
    }else {
        //存储用户信息
        [UserData userInfo:mDictionary];
        //存储用户账号信息
        [YFUserDefaults setObject:self.phoneTF.text forKey:@"USERPHONE"];
        [YFUserDefaults synchronize];
                
        if (self.loginType == WFJumpLoginCtrlH5Tpye) {
            [self.tabBarController setSelectedIndex:0];
            [self.navigationController popToRootViewControllerAnimated:YES];
            //刷新个人中心
            [YFNotificationCenter postNotificationName:@"reloadUserCnter" object:nil];
        }else {
            //作为跟视图的时候
            UITabBarController *rootVC = [YFMediatorManager rootTabBarCcontroller];
            [self addChildViewControllers];
            [UIApplication sharedApplication].keyWindow.rootViewController = rootVC;
            
            CATransition *anim = [CATransition animation];
            ////转场动画持续时间
            anim.duration = 0.5;
            anim.type = @"cube";
            //转场动画将去的方向
            anim.subtype = kCATransitionFromRight;
            [[UIApplication sharedApplication].keyWindow.layer addAnimation:anim forKey:nil];
        }
    }
}

/**
 获取地址
 */
- (void)getAddress {
    [WFLoginDataTool getAddressDataWithParams:@{} resultBlock:^(NSArray * _Nonnull models) {
        if (models.count != 0) {
            [[WFHomeSaveDataTool shareInstance] SaveAddressFile:models];
        }
    }];
}

/**
 切换登录方式

 @param sender sender
 */
- (IBAction)clickSwitchBtn:(UIButton *)sender {
    [self.view endEditing:YES];
    sender.selected = !sender.selected;
    [sender setTitle:sender.selected ? @"密码登录" : @"手机快捷登录" forState:0];
    self.titleLbl.text = sender.selected ? @"手机快捷登录" : @"登录";
    self.codeLbl.text = sender.selected ? @"验证码" : @"密码";
    self.codeView.hidden = !sender.selected;
}

- (IBAction)clickCodeBtn:(id)sender {
    [self.view endEditing:YES];
    if ([NSString isBlankString:self.phoneTF.text] || self.phoneTF.text.length < 11) {
        [YFToast showMessage:@"请输入正确的手机号" inView:self.view];
        return;
    }
    
    @weakify(self)
    [WFLoginDataTool getVerificationCodeWithParams:@{@"mobile":self.phoneTF.text} resultBlock:^{
        @strongify(self)
        [YFToast showMessage:@"验证码发送成功" inView:self.view];
        self.task = [WKTimer execTask:[WKProxy proxyWithTarget:self]
                             selector:@selector(doTask)
                                start:0.0
                             interval:1.0
                              repeats:YES
                                async:NO];
    }];
}

- (void)doTask {
    self.countIndex --;
    [self.codeButton setTitle:[NSString stringWithFormat:@"%ld秒可重发",(long)self.countIndex] forState:UIControlStateNormal];
    [self.codeButton setTitleColor:UIColorFromRGB(0x999999) forState:0];
    self.codeButton.userInteractionEnabled = NO;
    if (self.countIndex == 0)
    {
        [self userEnableBtn];
        [WKTimer cancelTask:self.task];
        
    }
}

/**
 能用 button
 */
- (void)userEnableBtn {
    [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeButton setTitleColor:UIColorFromRGB(0xF78556) forState:0];
    self.codeButton.userInteractionEnabled = YES;
    self.countIndex = 60;
}

/**
 申请成为合伙人

 @param sender sender
 */
- (IBAction)clickAddYZCBtn:(id)sender {
    WFApplyPartnerViewController *apply = [[WFApplyPartnerViewController alloc] init];
    [self.navigationController pushViewController:apply animated:YES];
}

/// 忘记密码
/// @param sender 按钮对象
- (IBAction)clickForgetPswBtn:(id)sender {
    WFSecuritySetViewController *security = [[WFSecuritySetViewController alloc] initWithNibName:@"WFSecuritySetViewController" bundle:[NSBundle bundleForClass:[self class]]];
    security.setType = WFSecuritySetForgetPswType;
    [self.navigationController pushViewController:security animated:YES];
}

/**
 监听输入框

 @param textField textField
 */
- (IBAction)textFieldDidChange:(UITextField *)textField {
    if (textField == self.phoneTF && textField.text.length > 11) {
        textField.text = [textField.text substringWithRange:NSMakeRange(0, 11)];
    }
    
    if (!self.exChangeBtn.selected) {
        //密码登录
        if (self.phoneTF.text.length >= 11 && ![NSString isBlankString:self.passwordTF.text]) {
            self.loginBtn.enabled = YES;
            self.loginBtn.alpha = 1;
        }else{
            self.loginBtn.enabled = NO;
            self.loginBtn.alpha = 0.6;
        }
    }else {
        //验证码登录
        if (self.phoneTF.text.length >= 11 && ![NSString isBlankString:self.codeTF.text]) {
            self.loginBtn.enabled = YES;
            self.loginBtn.alpha = 1;
        }else{
            self.loginBtn.enabled = NO;
            self.loginBtn.alpha = 0.6;
        }
    }
}

/**
 设置主页面
 */
- (void)addChildViewControllers {
    
    [YFMediatorManager setGlobalBackGroundColor:UIColor.whiteColor];
    [YFMediatorManager setTabbarTitleColor:NavColor titleFont:11];
    
    NSArray *ClassArray = [NSArray arrayWithObjects:@"WFHomeViewController",@"WFShopMallViewController",@"WFBusSchoolViewController",@"WFUserCenterViewController", nil];
    NSArray *titleArray = [NSArray arrayWithObjects:@"首页",@"服务",@"商学院",@"我的", nil];
    NSArray *normalImgArray = [NSArray arrayWithObjects:@"homeNoSelect",@"shopNoSelect",@"schoolNoSelect",@"mineNoSelect", nil];
    NSArray *selectImgArray = [NSArray arrayWithObjects:@"homeSelect",@"shopSelect",@"schoolSelect",@"mineSelect", nil];
    for (int i = 0; i < ClassArray.count; i++) {
        NSString *className = ClassArray[i];
        Class class = NSClassFromString(className);
        if (class) {
            YFBaseViewController *ctrl = class.new;
            [YFMediatorManager addChildVC:ctrl normalImageName:normalImgArray[i] selectedImageName:selectImgArray[i] title:titleArray[i]];
        }
    }
}

@end
