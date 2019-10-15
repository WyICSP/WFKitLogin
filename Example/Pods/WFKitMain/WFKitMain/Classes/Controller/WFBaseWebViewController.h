//
//  WFBaseWebViewController.h
//  AFNetworking
//
//  Created by 王宇 on 2019/10/12.
//

#import <WFKitMain/YFBaseViewController.h>
#import <WebKit/WebKit.h>
#import "WFWebProgressLayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFBaseWebViewController : YFBaseViewController
/**
 进度条
 */
@property (nonatomic, strong) WFWebProgressLayer *webProgressLayer;
/**
 webView
 */
@property (nonatomic, strong) WKWebView *webView;
/**
 网址链接
 */
@property (nonatomic, copy)   NSString  *urlString;
/**
 进度条颜色
 */
@property (nonatomic, strong) UIColor   *progressColor;

@end

NS_ASSUME_NONNULL_END
