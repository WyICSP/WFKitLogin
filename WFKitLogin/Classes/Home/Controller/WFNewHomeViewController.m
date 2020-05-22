//
//  WFNewHomeViewController.m
//  WFKitLogin_Example
//
//  Created by 王宇 on 2020/4/23.
//  Copyright © 2020 wyxlh. All rights reserved.
//

#import "WFNewHomeViewController.h"
#import "WFNewHomeHeadView.h"
#import "WFNewHomeTodDayProfit.h"
#import "WFNewHomeAssetsView.h"
#import "WFNewHomeAppleAreaView.h"
#import "WFBaseWebViewController.h"
#import "YFMediatorManager+WFLogin.h"
#import "WFHomeWebViewController.h"
#import "WFLoginPublicAPI.h"
#import "WFHomeDataTool.h"
#import "WFNewHomeModel.h"
#import "MLMenuView.h"
#import "WKSetting.h"
#import "MJRefresh.h"
#import "WKConfig.h"

@interface WFNewHomeViewController ()
/// 滚动 view
@property (nonatomic, strong, nullable) UIScrollView *scrollView;
/// headView
@property (nonatomic, strong, nullable) WFNewHomeHeadView *headView;
/// 今日收益
@property (nonatomic, strong, nullable) WFNewHomeTodDayProfit *todayView;
/// 资产
@property (nonatomic, strong, nullable) WFNewHomeAssetsView *assetsView;
/// 申请设备片区
@property (nonatomic, strong, nullable) WFNewHomeAppleAreaView *applyView;
/// 资产信息
@property (nonatomic, strong, nullable) WFNewHomeModel *assetsInfoModel;
/// 客服
@property (nonatomic, strong, nullable) WFNewHomeServiceModel *cModel;
/// 菜单
@property (nonatomic, strong, nullable) MLMenuView *menuView;
/// 淘宝链接
@property (nonatomic, copy, nullable) NSString *paySkipUrl;
/// 合伙人身份
@property (nonatomic, assign) NSInteger partnerRole;
///是否可以侧滑
@property (nonatomic,assign) BOOL isCanSideBack;
/**消息未读*/
@property (nonatomic, strong) UILabel *countLbl;
@end

@implementation WFNewHomeViewController

#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self disableSideBack];
    // 获取未读消息
    [self getUserUnReadMessage];
    [self.scrollView setContentOffset:CGPointZero];
}

///禁用侧滑返回
- (void)disableSideBack{
    self.isCanSideBack = NO;
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    return self.isCanSideBack;
}

#pragma mark 页面相关方法调用
- (void)setUI {
    [self addLeftImageBtn:@"new_service"];
    [self addRightImageBtn:@"new_msg"];
    self.leftImageBtn.width = self.leftImageBtn.height = 40.0f;
    [self.view addSubview:self.scrollView];
    // 获取数据
    [self netWork];
    // 获取客服信息
    [self getCustomerService];
    //注册通知：重新刷新页面
    [YFNotificationCenter addObserver:self selector:@selector(netWork) name:@"reloadUserCnter" object:nil];
}

/// 获取数据
- (void)netWork {
    // 获取总的收入
    [self getTotalIncome];
    // 获取今日收入
    [self getTodayIncome];
    // 获取资产信息
    [self getAssetsInfo];
    // 获取合伙人身份
    [self getPartnerInfo];
}

/// 获取总收入
- (void)getTotalIncome {
    @weakify(self)
    [WFHomeDataTool getHomeTotalIncomeWithParams:@{} resultBlock:^(WFNewHomeIncomeModel * _Nonnull models) {
        @strongify(self)
        self.headView.model = models;
        self.paySkipUrl = models.paySkipUrl;
        [self.scrollView.mj_header endRefreshing];
    } failureBlock:^{
        @strongify(self)
        self.headView.model = nil;
        [self.scrollView.mj_header endRefreshing];
    }];
}

/// 获取资产信息
- (void)getAssetsInfo {
    @weakify(self)
    [WFHomeDataTool geHomeAssetsInfoWithParams:@{} resultBlock:^(WFNewHomeModel * _Nonnull models) {
        @strongify(self)
        self.assetsView.model = models;
        [self.scrollView.mj_header endRefreshing];
    } failureBlock:^{
        @strongify(self)
        [self.scrollView.mj_header endRefreshing];
    }];
}

/// 获取今日经营
- (void)getTodayIncome {
    @weakify(self)
    [WFHomeDataTool getHomeTodayIncomeWithParams:@{} resultBlock:^(WFNewHomeTodayIncomeModel * _Nonnull models) {
        @strongify(self)
        self.todayView.model = models;
        [self.scrollView.mj_header endRefreshing];
    } failureBlock:^{
        @strongify(self)
        [self.scrollView.mj_header endRefreshing];
    }];
}

/// 获取客服
- (void)getCustomerService {
    @weakify(self)
    [WFHomeDataTool getCustomerServiceWithParams:@{} resultBlock:^(WFNewHomeServiceModel * _Nonnull cModel) {
        @strongify(self)
        self.cModel = cModel;
        self.cModel.customerMobile = cModel.customerMobile.length == 0 ? @"4008251068" : cModel.customerMobile;
        self.cModel.customerServiceUrl = cModel.customerServiceUrl.length == 0 ? @"https://chat.sobot.com/chat/h5/v2/index.html?sysnum=5671d20094344db1abd7c0386cdbd5a8&source=2" : cModel.customerServiceUrl;
    }];
}

/**
 获取用户未读消息
 */
- (void)getUserUnReadMessage {
    @weakify(self)
    [WFHomeDataTool getMessageUnReadCountWithParams:@{} resultBlock:^(NSDictionary * _Nonnull dict) {
        @strongify(self)
        NSString *dataCount = [NSString stringWithFormat:@"%@",[dict objectForKey:@"data"]];
        self.countLbl.hidden = [dataCount intValue] == 0;
    }];
}

/// 获取合伙人身份信息
- (void)getPartnerInfo {
    @weakify(self)
    [WFHomeDataTool getPartnerInfoWithParams:@{} resultBlock:^(NSDictionary * _Nonnull dict) {
        @strongify(self)
        NSString *partnerRole = [[dict safeJsonObjForKey:@"data"] stringObjectForKey:@"partnerRole"];
        self.partnerRole = [partnerRole integerValue];
        //1 市场合伙人  2 管理合伙人 3 物业
        self.applyView.hidden = [partnerRole integerValue] == 3 ? YES : NO;
    }];
}

/// 处理搜索点击事件
/// @param index 每个点击事件的 tag
- (void)clickItemEventWithIndex:(NSInteger)index {
    if (index == 10) {
        // 今日收入
        WFHomeWebViewController *web = [[WFHomeWebViewController alloc] init];
        web.urlString = [NSString stringWithFormat:@"%@yzc-app-partner/#/home/chargingOrderList",H5_HOST];
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
    }else if (index == 20) {
        // 充电订单
        WFHomeWebViewController *web = [[WFHomeWebViewController alloc] init];
        web.urlString = [NSString stringWithFormat:@"%@yzc-app-partner/#/home/chargingOrderList",H5_HOST];
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
    }else if (index == 30) {
        // 近 7 日使用率
        WFHomeWebViewController *web = [[WFHomeWebViewController alloc] init];
        web.urlString = [NSString stringWithFormat:@"%@yzc-app-partner/#/home/utilizationRate",H5_HOST];
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
    }else if (index == 40) {
        // 片区数量
        [YFMediatorManager openApplyAreaCtrlWithController:self partnerRole:self.partnerRole];
    }else if (index == 50) {
        // 设备数量
        [YFMediatorManager openMyChargePileCtrlWithController:self];
    }else if (index == 60) {
        // 设备警告
        WFHomeWebViewController *web = [[WFHomeWebViewController alloc] init];
        web.urlString = [NSString stringWithFormat:@"%@yzc-app-partner/#/warningDevice/index",H5_HOST];
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
    }else if (index == 70) {
        // 插座状态
        WFHomeWebViewController *web = [[WFHomeWebViewController alloc] init];
        web.urlString = [NSString stringWithFormat:@"%@yzc-app-partner/#/slot/index",H5_HOST];
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
    }else if (index == 80) {
        //申请充电桩
        WFHomeWebViewController *web = [[WFHomeWebViewController alloc] init];
        web.urlString = [NSString stringWithFormat:@"%@yzc-app-partner/#/apply/list",H5_HOST];
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
    }else if (index == 90) {
        //申请片区
        [YFMediatorManager gotoAppleAreaCtrlWithController:self];
    }else if (index == 91) {
        //打开浏览器
        if (self.paySkipUrl.length != 0)
            [self jumpToAnotherApp];
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.paySkipUrl]];
        
    }else if (index == 100 || index == 110) {
        //总收入 充电收入
        WFHomeWebViewController *web = [[WFHomeWebViewController alloc] init];
        web.urlString = [NSString stringWithFormat:@"%@yzc-app-partner/#/myIncome/index",H5_HOST];
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
    }else if (index == 120) {
        //奖励收入
        [YFMediatorManager openActivityOrRewardCtrlWithController:self type:0];
    }else if (index == 130) {
        //公告
    }else if (index == 140) {
        //商城收入
        [YFMediatorManager gotoCommunityServicePageWithController:self];
    }
}


// 客服
- (void)leftImageButtonClick:(UIButton *)sender {
    sender.selected =! sender.selected;
    if (sender.selected) {
        [self.menuView showMenuEnterAnimation:MLEnterAnimationStyleRight];
    }else {
        [self.menuView hidMenuExitAnimation:MLEnterAnimationStyleRight];
    }
}

/// 跳转到淘宝
- (void)jumpToAnotherApp {
    NSArray *pathArray = [self.paySkipUrl componentsSeparatedByString:@"//"];
    NSString *path;
    if (pathArray.count != 0)
        path = [NSString stringWithFormat:@"tbopen://%@",pathArray.lastObject];
    
    NSURL *url = [NSURL URLWithString:path];
    BOOL isCanOpen = [[UIApplication sharedApplication] canOpenURL:url];
    if (isCanOpen) {
        #ifdef NSFoundationVersionNumber_iOS_10_0
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                
            }];
        #else
            [[UIApplication sharedApplication] openURL:url];
        #endif
        DLog(@"App1打开App2");
    }else{
        DLog(@"设备没有安装App2");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.paySkipUrl]];
    }
}

// 消息
- (void)rightImageButtonClick:(UIButton *)sender {
    WFHomeWebViewController *web = [[WFHomeWebViewController alloc] init];
    web.urlString = [NSString stringWithFormat:@"%@yzc-app-partner/#/msg/index",H5_HOST];
    web.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:web animated:YES];
}

- (void)customerServiceCompleleWithIndex:(NSInteger)index {
    // 设置按钮选中情况
    self.leftImageBtn.selected = NO;
    
    if (index == 0) {
        // 在线客服
        WFBaseWebViewController *web = [[WFBaseWebViewController alloc] init];
        web.urlString = self.cModel.customerServiceUrl;
        web.hidesBottomBarWhenPushed = YES;
        web.progressColor = NavColor;
        [self.navigationController pushViewController:web animated:YES];
    }else {
        // 电话客服
        [WFLoginPublicAPI callPhoneWithNumber:self.cModel.customerMobile];
    }
}

#pragma mark get set
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = UIColorFromRGB(0xF5F5F5);
        _scrollView.contentSize = CGSizeMake(ScreenWidth, self.view.bounds.size.height+20);
        @weakify(self)
        _scrollView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self netWork];
        }];
        [_scrollView addSubview:self.headView];
        [_scrollView addSubview:self.todayView];
        [_scrollView addSubview:self.assetsView];
        [_scrollView addSubview:self.applyView];
    }
    return _scrollView;;
}

/// headView
- (WFNewHomeHeadView *)headView {
    if (!_headView) {
        _headView = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"WFNewHomeHeadView" owner:nil options:nil] firstObject];
        _headView.frame = CGRectMake(0, 0, ScreenWidth, KHeight(172.0f)+58.0f);
        @weakify(self)
        _headView.clickHeadEventBlock = ^(NSInteger index) {
            @strongify(self)
            [self clickItemEventWithIndex:index];
        };
    }
    return _headView;
}

/// 今日收益
- (WFNewHomeTodDayProfit *)todayView {
    if (!_todayView) {
        _todayView = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"WFNewHomeTodDayProfit" owner:nil options:nil] firstObject];
        _todayView.frame = CGRectMake(0, self.headView.maxY + 10.0f, ScreenWidth, 105.0f);
        @weakify(self)
        _todayView.clickTodayEventBlock = ^(NSInteger index) {
            @strongify(self)
            [self clickItemEventWithIndex:index];
        };
    }
    return _todayView;
}

/// 资产
- (WFNewHomeAssetsView *)assetsView {
    if (!_assetsView) {
        _assetsView = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"WFNewHomeAssetsView" owner:nil options:nil] firstObject];
        _assetsView.frame = CGRectMake(0, self.todayView.maxY + 10.0f, ScreenWidth, 105.0f);
        @weakify(self)
        _assetsView.clickAssetsEventBlock = ^(NSInteger index) {
            @strongify(self)
            [self clickItemEventWithIndex:index];
        };
    }
    return _assetsView;
}

/// 申请片区设备
- (WFNewHomeAppleAreaView *)applyView {
    if (!_applyView) {
        _applyView = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"WFNewHomeAppleAreaView" owner:nil options:nil] firstObject];
        _applyView.frame = CGRectMake(0, self.assetsView.maxY + 10.0f, ScreenWidth, 75.0f);
        @weakify(self)
        _applyView.clickAreaEventBlock = ^(NSInteger index) {
            @strongify(self)
            [self clickItemEventWithIndex:index];
        };
    }
    return _applyView;
}

/// 菜单
- (MLMenuView *)menuView {
    NSArray *titles = @[@"在线客服",self.cModel.customerMobile];
    NSArray *images = @[@"new_pop_service",@"new_phone"];
    if (!_menuView) {
        _menuView = [[MLMenuView alloc] initWithFrame:CGRectMake(10, 0, 130, 44 * 4) WithTitles:titles WithImageNames:images WithMenuViewOffsetTop:NavHeight WithTriangleOffsetLeft:20];
        _menuView.showType = WFShowHasNavBarType;
        @weakify(self)
        _menuView.didSelectBlock = ^(NSInteger index) {
            @strongify(self)
            [self customerServiceCompleleWithIndex:index];
        };
        _menuView.dissaperBlock = ^{
            @strongify(self)
            // 设置按钮选中情况
            self.leftImageBtn.selected = NO;
        };
    }
    return _menuView;
}

/**
 消息数量

 @return countLbl
 */
- (UILabel *)countLbl {
    if (!_countLbl) {
        _countLbl = [[UILabel alloc] initWithFrame:CGRectMake(8, -4, 10, 10)];
        _countLbl.textColor = [UIColor whiteColor];
        _countLbl.backgroundColor = UIColorFromRGB(0xFC3712);
        _countLbl.layer.masksToBounds = YES;
        _countLbl.layer.cornerRadius = 5;
        _countLbl.hidden = YES;
        _countLbl.font = [UIFont systemFontOfSize:9];
        _countLbl.textAlignment = NSTextAlignmentCenter;
        [self.rightImageBtn addSubview:_countLbl];
    }
    return _countLbl;
}

@end
