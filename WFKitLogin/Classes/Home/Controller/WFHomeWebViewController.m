//
//  WFHomeWebViewController.m
//  AFNetworking
//
//  Created by 王宇 on 2019/8/27.
//

#import "WFHomeWebViewController.h"
#import "JsApiTest.h"
#import "WKHelp.h"

@interface WFHomeWebViewController ()
@end

@implementation WFHomeWebViewController

#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.dwebview addJavascriptObject:[[JsApiTest alloc] init] namespace:nil];
    self.progressColor = NavColor;
    
    [YFNotificationCenter addObserver:self selector:@selector(reload) name:@"reloadApplyPileKeys" object:nil];
    
}

- (void)reload {
    [self.dwebview reload];
}




@end
