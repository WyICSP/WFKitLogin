//
//  WFUserCenterViewController.m
//  WFApplyArea_Example
//
//  Created by 王宇 on 2019/8/27.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import "WFUserCenterViewController.h"
#import "YukiWebProgressLayer.h"
#import "dsbridge.h"
#import "WFJSApiTools.h"
#import <WebKit/WebKit.h>
#import "UserData.h"
#import "WKHelp.h"
#import "WKSetting.h"

@interface WFUserCenterViewController ()<WKNavigationDelegate>
/**DWKWebView*/
@property (nonatomic, strong) DWKWebView * dwebview;
/**进度条*/
@property (nonatomic, strong) YukiWebProgressLayer *webProgressLayer;
@end

@implementation WFUserCenterViewController

#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    //清空缓存
//    [self deleteWebCache];
    // 开启
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

#pragma mark 设置页面
- (void)setUI {
    //注册通知：监听充电时间变化
    [YFNotificationCenter addObserver:self selector:@selector(reloadWebData) name:@"reloadUserCnter" object:nil];
    //拼接 url
    self.urlString = [NSString stringWithFormat:@"%@yzc_business_h5/page/menu.html?uuid=%@&appVersion=v%@",H5_HOST,USER_UUID,APP_VERSION];
    //添加 webview
    [self.view addSubview:self.dwebview];
    //添加进度条
    [self.view.layer addSublayer:self.webProgressLayer];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *urlString =navigationAction.request.URL.absoluteString;
    if ([urlString containsString:@"page/menu.html"]) {
        //个人中心
        [self hideTabbar:NO];
    } else{
        //其他页面
        [self hideTabbar:YES];
    }
    
    if (navigationAction.targetFrame == nil) {
        //如果说有的网页点击数据点不了 就重新加载下这个页面
        [webView loadRequest:navigationAction.request];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

/**
 隐藏 tabbar
 
 @param hide 显示与隐藏
 */
- (void)hideTabbar:(BOOL)hide {
    // 内嵌页面 不操作tabbar
    if (![self.parentViewController isKindOfClass:[UINavigationController class]]) {
        return;
    }
    
    // 二级页面 不操作tabbar
    if (![self isEqual:self.navigationController.viewControllers[0]]) {
        return;
    }
    
    self.tabBarController.tabBar.hidden = hide;
    self.hidesBottomBarWhenPushed = hide; // 设置这个主要是用于tab间切换，切换回来的时候，保持当前页面tabbar状态不变
    
    // 调整view的大小
    //    UIView *tab = self.tabBarController.view;
    if (hide) {
        self.dwebview.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    } else {
        self.dwebview.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - TabbarHeight);
    }
}

/**
 刷新数据
 */
- (void)reloadWebData {
    //url
    self.urlString = [NSString stringWithFormat:@"%@yzc_business_h5/page/menu.html?uuid=%@&appVersion=v%@",H5_HOST,USER_UUID,APP_VERSION];
    //重新加载
    [self.dwebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
}

- (void)deleteWebCache {
    //allWebsiteDataTypes清除所有缓存
    NSSet *types = [WKWebsiteDataStore allWebsiteDataTypes];
    //你可以选择性的删除一些你需要删除的文件 or 也可以直接全部删除所有缓存的type
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:types
                                               modifiedSince:dateFrom completionHandler:^{
                                                   // code
                                               }];
}

#pragma mark WKUIDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self.webProgressLayer startLoad];
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.webProgressLayer finishedLoadWithError:nil];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.webProgressLayer finishedLoadWithError:error];
}


- (DWKWebView *)dwebview {
    if (!_dwebview) {
        _dwebview = [[DWKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-TabbarHeight)];
        [_dwebview addJavascriptObject:[[WFJSApiTools alloc] init] namespace:nil];
        [_dwebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
        _dwebview.scrollView.scrollEnabled = NO;
        _dwebview.navigationDelegate = self;
        [_dwebview setDebugMode:true];
    }
    return _dwebview;
}

#pragma mark webProgressLayer
-(YukiWebProgressLayer *)webProgressLayer{
    if (!_webProgressLayer) {
        _webProgressLayer = [[YukiWebProgressLayer alloc]init];
        _webProgressLayer.frame = CGRectMake(0, 42, ScreenWidth, 3);
        _webProgressLayer.strokeColor = NavColor.CGColor;
    }
    return _webProgressLayer;
}

- (void)goBack {
    [self.dwebview canGoBack] ? [self.dwebview goBack] : [super goBack];
}

- (void)dealloc {
    [self.webProgressLayer closeTimer];
    [_webProgressLayer removeFromSuperlayer];
    _webProgressLayer = nil;
    [YFNotificationCenter removeObserver:self name:@"reloadUserCnter" object:nil];
}


@end
