//
//  WFHomeWebViewController.h
//  AFNetworking
//
//  Created by 王宇 on 2019/8/27.
//

#import <WFKitMain/YFBaseViewController.h>
#import <dsBridge/dsbridge.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFHomeWebViewController : YFBaseViewController
/**
 DWKWebView
 */
@property (nonatomic, strong) DWKWebView * dwebview;
/**
 加载url
 */
@property (nonatomic, copy) NSString *urlString;

@end

NS_ASSUME_NONNULL_END
