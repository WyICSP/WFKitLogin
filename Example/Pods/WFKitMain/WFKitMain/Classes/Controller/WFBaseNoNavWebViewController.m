//
//  WFBaseNoNavWebViewController.m
//  AFNetworking
//
//  Created by 王宇 on 2019/11/4.
//

#import "WFBaseNoNavWebViewController.h"
#import "NSString+Regular.h"
#import "UserData.h"
#import "WKHelp.h"

@interface WFBaseNoNavWebViewController ()<WKNavigationDelegate,WKUIDelegate>

@end

@implementation WFBaseNoNavWebViewController

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
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark 设置页面
- (void)setUI {
    //添加 webview
    [self.dwebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    //通过 KVC 监听 webView 的 title
    [self.dwebview addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    //添加进度条
    [self.view.layer addSublayer:self.webProgressLayer];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        if (object == self.dwebview) {
            self.title = self.dwebview.title;
        }
    }
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

- (void)goBack {
    [self.dwebview canGoBack] ? [self.dwebview goBack] : [super goBack];
}

// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [self.webProgressLayer startLoad];
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    
}
// 页面加载完成之后调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.webProgressLayer finishedLoadWithError:nil];
}
// 页面加载失败时调用
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
     [self.webProgressLayer finishedLoadWithError:error];
}
#pragma mark webView
- (DWKWebView *)dwebview {
    if (!_dwebview) {
        _dwebview = [[DWKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//        [_dwebview addJavascriptObject:[[JsApiTest alloc] init] namespace:nil];
        _dwebview.navigationDelegate = self;
        [_dwebview setDebugMode:true];
        
        [self.view addSubview:_dwebview];
    }
    return _dwebview;
}

#pragma mark webProgressLayer
- (WFWebProgressLayer *)webProgressLayer{
    if (!_webProgressLayer) {
        _webProgressLayer = [[WFWebProgressLayer alloc]init];
        _webProgressLayer.frame = CGRectMake(0, NavHeight-3, ScreenWidth, 3);
        _webProgressLayer.strokeColor = self.progressColor == nil ? [UIColor blueColor].CGColor : self.progressColor.CGColor;
    }
    return _webProgressLayer;
}

- (void)setProgressColor:(UIColor *)progressColor{
    self.webProgressLayer.strokeColor = progressColor == nil ? NavColor.CGColor : progressColor.CGColor;
}

- (void)setUrlString:(NSString *)urlString {
    if ([urlString containsString:@"?"]) {
        urlString = [NSString stringWithFormat:@"%@&uuid=%@&appVersion=%@&appMode=app&appName=%@",urlString,USER_UUID,APP_VERSION,[NSString getProjectName]];
    }else {
        urlString = [NSString stringWithFormat:@"%@?uuid=%@&appVersion=%@&appMode=app&appName=%@",urlString,USER_UUID,APP_VERSION,[NSString getProjectName]];
    }
    _urlString = urlString;
}

- (void)dealloc {
    [self.webProgressLayer closeTimer];
    [_webProgressLayer removeFromSuperlayer];
    _webProgressLayer = nil;
    
    [self.dwebview removeObserver:self forKeyPath:@"title"];
}




@end
