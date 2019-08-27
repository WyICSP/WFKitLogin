//
//  WFHomeWebViewController.m
//  AFNetworking
//
//  Created by 王宇 on 2019/8/27.
//

#import "WFHomeWebViewController.h"
#import "YukiWebProgressLayer.h"
#import "dsbridge.h"
#import "JsApiTest.h"
#import <WebKit/WebKit.h>
#import "WKHelp.h"

@interface WFHomeWebViewController ()
/**DWKWebView*/
@property (nonatomic, strong) DWKWebView * dwebview;
/**进度条*/
@property (nonatomic, strong) YukiWebProgressLayer *webProgressLayer;
@end

@implementation WFHomeWebViewController

#pragma mark 生命周期
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
    //清空缓存
    [self deleteWebCache];
    // 开启
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

#pragma mark 设置页面
- (void)setUI {
    //添加进度条
    [self.navigationController.navigationBar.layer addSublayer:self.webProgressLayer];
    //添加 webview
    [self.dwebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    //通过 KVC 监听 webView 的 title
    [self.dwebview addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
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
        _dwebview = [[DWKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        [_dwebview addJavascriptObject:[[JsApiTest alloc] init] namespace:nil];
        _dwebview.navigationDelegate = self;
        [_dwebview setDebugMode:true];
        
        [self.view addSubview:_dwebview];
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
    
    [self.dwebview removeObserver:self forKeyPath:@"title"];
    
    [self.webProgressLayer closeTimer];
    [_webProgressLayer removeFromSuperlayer];
    _webProgressLayer = nil;
    
    
}



@end
