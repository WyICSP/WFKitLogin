//
//  WFHomeWebViewController.h
//  AFNetworking
//
//  Created by 王宇 on 2019/8/27.
//

#import <WFKitMain/YFBaseViewController.h>
#import "YukiWebProgressLayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFHomeWebViewController : YFBaseViewController
/**
 加载url
 */
@property (nonatomic, copy) NSString *urlString;
/**
 进度条
 */
@property (nonatomic, strong) YukiWebProgressLayer *webProgressLayer;
@end

NS_ASSUME_NONNULL_END
