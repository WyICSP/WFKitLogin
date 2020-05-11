//
//  WFSecuritySetViewController.m
//  AFNetworking
//
//  Created by 王宇 on 2019/12/19.
//

#import "WFSecuritySetViewController.h"
#import "YFMediatorManager+YFKitMain.h"
#import "WFLoginViewController.h"
#import "YFMediatorManager.h"
#import "WFLoginDataTool.h"
#import "WKConfig.h"
#import "WKProxy.h"
#import "WKTimer.h"

@interface WFSecuritySetViewController ()
/// title
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
///  手机号
@property (weak, nonatomic) IBOutlet UILabel *phone;
/// 验证码
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
/// 密码
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
/// 发送验证码
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
/// 提交按钮
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
/**定时器*/
@property (copy, nonatomic) NSString *task;
/**倒计时*/
@property (nonatomic, assign) NSInteger countIndex;

@end

@implementation WFSecuritySetViewController

#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [WKTimer cancelTask:self.task];
    [self userEnableBtn];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark 私有方法
- (void)setUI {
    self.countIndex = 60;
    self.submitBtn.layer.cornerRadius = 20.0f;
    if (self.userPhone.length == 11) {
        //登录 过来
        self.phone.text = [self.userPhone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }else {
        //修改密码
        self.userPhone = [UserData userInfo].mobile;
        if (self.userPhone.length == 11)
        self.phone.text = [self.userPhone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    self.titleLbl.text = self.setType == WFSecuritySetForgetPswType ? @"设置新的登录密码" : @"系统安全升级,请重设密码";
}

#pragma mark 绑定事件
///发送验证码
- (IBAction)clickCodeTFBtn:(id)sender {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params safeSetObject:self.userPhone forKey:@"mobile"];
    @weakify(self)
    [WFLoginDataTool getVerificationUpdatePswCodeWithParams:params resultBlock:^{
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
    [self.codeBtn setTitle:[NSString stringWithFormat:@"%ld秒可重发",(long)self.countIndex] forState:UIControlStateNormal];
    [self.codeBtn setTitleColor:UIColorFromRGB(0x999999) forState:0];
    self.codeBtn.userInteractionEnabled = NO;
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
    [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeBtn setTitleColor:UIColorFromRGB(0xF78556) forState:0];
    self.codeBtn.userInteractionEnabled = YES;
    self.countIndex = 60;
}

///提交
- (IBAction)clickSubmitBtn:(id)sender {
    if ([self.passwordTF.text isEqualToString:self.userPhone]) {
        [YFToast showMessage:@"密码不能和手机号一致" inView:self.view];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params safeSetObject:self.passwordTF.text forKey:@"newPassword"];
    [params safeSetObject:self.codeTF.text forKey:@"code"];
    [params safeSetObject:self.userPhone forKey:@"mobile"];
    @weakify(self)
    [WFLoginDataTool updatePasswordWithParams:params resultBlock:^{
        @strongify(self)
        [YFToast showMessage:@"密码设置成功" inView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self modifyPasswordSuccess];
        });
    }];
}

/// 修改密码成功
- (void)modifyPasswordSuccess {
    if (self.setType == WFSecuritySetUpgradeType) {
        // 是重新设置密码
        //存储用户信息
        [UserData userInfo:self.userInfo];
        //存储用户账号信息
        [YFUserDefaults setObject:self.userPhone forKey:@"USERPHONE"];
        [YFUserDefaults synchronize];
        
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
        
    }else if (self.setType == WFSecuritySetForgetPswType) {
        //修改密码
        //直接返回
        [self.navigationController popToRootViewControllerAnimated:YES];
        //刷新个人中心
        [YFNotificationCenter postNotificationName:@"reloadUserCnter" object:nil];
    }else {
        //H5-退出登录, 登录其他账号
        //存储用户信息
        [UserData userInfo:self.userInfo];
        //直接返回
        [self.navigationController popToRootViewControllerAnimated:YES];
        //刷新个人中心
        [YFNotificationCenter postNotificationName:@"reloadUserCnter" object:nil];
    }
}

/// 监听输入框变化
- (IBAction)textFieldDidChange:(UITextField *)textField {
    if (textField == self.passwordTF && self.passwordTF.text.length > 20) {
        textField.text = [textField.text substringWithRange:NSMakeRange(0, 20)];
    }
    
    if (self.codeTF.text.length != 0 && self.passwordTF.text.length >= 6) {
        self.submitBtn.enabled = YES;
        self.submitBtn.alpha = 1;
    }else {
        self.submitBtn.enabled = NO;
        self.submitBtn.alpha = 0.6;
    }
}

/**
 设置主页面
 */
- (void)addChildViewControllers {
    
    [YFMediatorManager setGlobalBackGroundColor:UIColor.whiteColor];
    [YFMediatorManager setTabbarTitleColor:NavColor titleFont:11];
    
    NSArray *ClassArray = [NSArray arrayWithObjects:@"WFNewHomeViewController",@"WFBusSchoolViewController",@"WFPersonCenterViewController", nil];
    NSArray *titleArray = [NSArray arrayWithObjects:@"首页",@"商学院",@"我的", nil];
    NSArray *normalImgArray = [NSArray arrayWithObjects:@"homeNoSelect",@"schoolNoSelect",@"mineNoSelect", nil];
    NSArray *selectImgArray = [NSArray arrayWithObjects:@"homeSelect",@"schoolSelect",@"mineSelect", nil];
    for (int i = 0; i < ClassArray.count; i++) {
        NSString *className = ClassArray[i];
        Class class = NSClassFromString(className);
        if (class) {
            YFBaseViewController *ctrl = class.new;
            [YFMediatorManager addChildVC:ctrl normalImageName:normalImgArray[i] selectedImageName:selectImgArray[i] title:titleArray[i]];
        }
    }
}

#pragma mark 链式编程
- (WFSecuritySetViewController * _Nonnull (^)(WFSecuritySetType))secutityType {
    return ^(WFSecuritySetType setType) {
        self.setType = setType;
        return self;
    };
}

- (WFSecuritySetViewController * _Nonnull (^)(NSString * _Nonnull))userMoblie {
    return ^(NSString *userMobile){
        self.userPhone = userMobile;
        return self;
    };
}

- (WFSecuritySetViewController * _Nonnull (^)(NSDictionary * _Nonnull))userLoginInfo {
    return ^(NSDictionary *userInfo) {
        self.userInfo = userInfo;
        return self;
    };
}

@end
