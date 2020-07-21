//
//  WFBaseWebViewController.m
//  AFNetworking
//
//  Created by 王宇 on 2019/10/12.
//

#import "WFBaseWebViewController.h"
#import "NSString+Regular.h"
#import "UserData.h"
#import "WKHelp.h"

@interface WFBaseWebViewController () <WKNavigationDelegate,WKUIDelegate>
/// 进度条
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation WFBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

#pragma mark 设置页面
- (void)setUI {
    //添加进度条
    [self.navigationController.navigationBar addSubview:self.progressView];
    //添加 webview
    [self.dwebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    //通过 KVC 监听 webView 的 title
    [self.dwebview addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    [self.dwebview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        if (object == self.dwebview) {
            self.title = self.dwebview.title;
        }
    }else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.dwebview.estimatedProgress;
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.2f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
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
    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.2f);
    //防止progressView被网页挡住
    [self.navigationController.navigationBar bringSubviewToFront:self.progressView];
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}
// 页面加载完成之后调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //加载失败同样需要隐藏progressView
    self.progressView.hidden = YES;
}
// 页面加载失败时调用
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    //加载失败同样需要隐藏progressView
    self.progressView.hidden = YES;
}
#pragma mark webView
- (DWKWebView *)dwebview {
    if (!_dwebview) {
        _dwebview = [[DWKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NavHeight-SafeAreaBottom)];
//        [_dwebview addJavascriptObject:[[JsApiTest alloc] init] namespace:nil];
        _dwebview.navigationDelegate = self;
        [_dwebview setDebugMode:true];
        
        [self.view addSubview:_dwebview];
    }
    return _dwebview;
}

- (void)setProgressColor:(UIColor *)progressColor{
    self.progressView.progressTintColor = progressColor == nil ? NavColor : progressColor;
}

- (void)setUrlString:(NSString *)urlString {
    if ([urlString containsString:@"?"]) {
        urlString = [NSString stringWithFormat:@"%@&appVersion=%@&appMode=app&appName=partner&appType=native",urlString,APP_VERSION];
    }else {
        urlString = [NSString stringWithFormat:@"%@?appVersion=%@&appMode=app&appName=partner&appType=native",urlString,APP_VERSION];
    }
    _urlString = urlString;
}

/// 进度条
- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 2, ScreenWidth, 5)];
        _progressView.backgroundColor = [UIColor whiteColor];
        _progressView.trackTintColor = UIColor.whiteColor;
        //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
        _progressView.transform = CGAffineTransformMakeScale(1.0f, 1.2f);
    }
    return _progressView;
}

- (void)dealloc {
    if (self.progressView) {
        [self.progressView removeFromSuperview];
        self.progressView = nil;
    }
    
    [self.dwebview removeObserver:self forKeyPath:@"estimatedProgress"];
    
    [self.dwebview removeObserver:self forKeyPath:@"title"];
}

@end
