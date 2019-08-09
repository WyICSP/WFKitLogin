//
//  WFApplyPartnerViewController.m
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/8/7.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import "WFApplyPartnerViewController.h"
#import "WFApplyPartnerUserView.h"
#import "NSString+Regular.h"
#import "WFLoginDataTool.h"
#import "SKSafeObject.h"
#import "YFToast.h"
#import "WKHelp.h"

@interface WFApplyPartnerViewController ()
/**scrollView*/
@property (nonatomic, strong, nullable) UIScrollView *scrollView;
/**contentView*/
@property (nonatomic, strong, nullable) WFApplyPartnerUserView *applyPartnerView;
/**申请片区按钮*/
@property (nonatomic, strong, nullable) UIButton *nextBtn;
@end

@implementation WFApplyPartnerViewController

#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark 私有方法
- (void)setUI {
    self.title = @"申请成为合伙人";
    [self.view addSubview:self.scrollView];
}

/**
 提交
 */
- (void)clickNextBtn {
    
    NSString *alertMsg = @"";
    if ([NSString isBlankString:self.applyPartnerView.nameTF.text]) {
        alertMsg = @"请输入姓名";
    }else if (![NSString validateMobile:self.applyPartnerView.phoneTF.text]) {
        alertMsg = @"请输入正确的手机号";
    }else if (self.applyPartnerView.numTF.text.integerValue < 1) {
        alertMsg = @"请输入安装数量";
    }else if ([self.applyPartnerView.addressBtn.titleLabel.text isEqualToString:@"请选择地址"]) {
        alertMsg = @"请选择地址";
    }
    
    if (alertMsg.length != 0) {
        [YFToast showMessage:alertMsg inView:self.view];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params safeSetObject:self.applyPartnerView.nameTF.text forKey:@"contact"];
    [params safeSetObject:self.applyPartnerView.addressBtn.titleLabel.text forKey:@"installAddress"];
    [params safeSetObject:self.applyPartnerView.phoneTF.text forKey:@"mobile"];
    [params safeSetObject:self.applyPartnerView.numTF.text forKey:@"numbers"];
    @weakify(self)
    [WFLoginDataTool applyForPartnershipWithParams:params resultBlock:^{
        @strongify(self)
        [self submitSuccess];
    }];
}

- (void)submitSuccess {
    [YFToast showMessage:@"申请成功,请等待审核!" inView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

#pragma mark get set
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavHeight - self.nextBtn.height)];
        _scrollView.backgroundColor = UIColor.whiteColor;
        _scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight - NavHeight);
        [_scrollView addSubview:self.applyPartnerView];
    }
    return _scrollView;
}

/**
 contentView
 
 @return detailView
 */
- (WFApplyPartnerUserView *)applyPartnerView {
    if (!_applyPartnerView) {
        NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
        _applyPartnerView = [[currentBundle loadNibNamed:@"WFApplyPartnerUserView" owner:nil options:nil] firstObject];
        _applyPartnerView.frame = self.scrollView.bounds;
    }
    return _applyPartnerView;
}


/**
 申请片区按钮
 
 @return applyBtn
 */
- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _nextBtn.frame = CGRectMake(0, ScreenHeight - KHeight(45.0f) - NavHeight, ScreenWidth, KHeight(45));
        [_nextBtn setTitle:@"提交申请" forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(clickNextBtn) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        [_nextBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _nextBtn.backgroundColor = UIColorFromRGB(0xF78556);
        [self.view addSubview:_nextBtn];
    }
    return _nextBtn;
}


@end
