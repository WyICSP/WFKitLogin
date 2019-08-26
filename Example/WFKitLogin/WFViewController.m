//
//  WFViewController.m
//  WFKitLogin
//
//  Created by wyxlh on 04/15/2019.
//  Copyright (c) 2019 wyxlh. All rights reserved.
//

#import "WFViewController.h"
#import "WFLoginViewController.h"
#import "WKNavigationController.h"
#import "WFHomeViewController.h"
#import "SKAppUpdaterView.h"
#import "WFHomeDataTool.h"
#import "SKSafeObject.h"
#import "NSString+Regular.h"
#import "WKHelp.h"

@interface WFViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation WFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *lookBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    lookBtn.frame = CGRectMake(15, 100, ScreenWidth-30, 45);
    [lookBtn setTitle:@"查看详情" forState:(UIControlStateNormal)];
    [self.view addSubview:lookBtn];
    
    [self updateVersion];
}


#pragma mark 版本更新
- (void)updateVersion {
    @weakify(self)
    [WFHomeDataTool updateAppWithParams:@{} resultBlock:^(NSDictionary * _Nonnull models) {
        @strongify(self)
        NSString *version = [NSString stringWithFormat:@"%@",[models safeJsonObjForKey:@"updateVersion"]];
        NSArray *messageList = [models safeJsonObjForKey:@"updateMessage"];
        // 1 是强制更新  2 是非强制更新
        BOOL updateFlag = [[models safeJsonObjForKey:@"updateFlag"] boolValue];
        NSString *updateDownloadUrl = [models safeJsonObjForKey:@"updateDownloadUrl"];
        
        if ([self AppVersion:[NSString getAppVersion]] < [self AppVersion:version]) {
            [self compulsoryRenewal:updateFlag message:messageList version:version appUrl:updateDownloadUrl];
        }
    }];
}

/**去除版本号的. 得到版本号*/
- (NSInteger )AppVersion:(NSString *)version {
    NSString *appVersion = [version stringByReplacingOccurrencesOfString:@"." withString:@""];
    return [appVersion integerValue];
}

/**版本更新*/
- (void)compulsoryRenewal:(BOOL)compulsory
                  message:(NSArray *)msg
                  version:(NSString *)version
                   appUrl:(NSString *)appUrl {
    if (compulsory) {
        //强制更新
        SKAppUpdaterView *updateview   = [SKAppUpdaterView shareInstance];
        updateview.frame               = YFWindow.bounds;
        updateview.center              = YFWindow.center;
        updateview.tag                 = 123456;
        updateview.disapperBtn.hidden  = compulsory;
        updateview.versionList         = msg;
        updateview.appUrl              = appUrl;
        updateview.version.text        = [NSString stringWithFormat:@"V%@",version];
        [YFWindow addSubview:updateview];
    }else{
        //非强制更新
        SKAppUpdaterView * updateview  = [SKAppUpdaterView shareInstance];
        updateview.frame               = YFWindow.bounds;
        updateview.center              = YFWindow.center;
        updateview.tag                 = 123456;
        updateview.disapperBtn.hidden  = compulsory;
        updateview.versionList         = msg;
        updateview.appUrl              = appUrl;
        updateview.version.text        = [NSString stringWithFormat:@"V%@",version];;
        [YFWindow addSubview:updateview];
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    WFLoginViewController *login = [[WFLoginViewController alloc] initWithNibName:@"WFLoginViewController" bundle:[NSBundle bundleForClass:[self class]]];
//    WKNavigationController *navUserlogin    = [[WKNavigationController alloc]initWithRootViewController:login];
//    [self presentViewController:navUserlogin animated:YES completion:nil];
//    WFHomeViewController *login = [[WFHomeViewController alloc] init];
//    WKNavigationController *navUserlogin    = [[WKNavigationController alloc]initWithRootViewController:login];
//    [self presentViewController:navUserlogin animated:YES completion:nil];
    //    login.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:login animated:YES];
    SKAppUpdaterView *updateview   = [SKAppUpdaterView shareInstance];
    updateview.frame               = YFWindow.bounds;
    updateview.center              = YFWindow.center;
    updateview.tag                 = 123456;
//    updateview.disapperBtn.hidden  = compulsory;
//    updateview.versionList         = msg;
//    updateview.appUrl              = appUrl;
//    updateview.version.text        = [NSString stringWithFormat:@"V%@",version];
    [YFWindow addSubview:updateview];
}
- (IBAction)textFieldDidChange:(UITextField *)textField {
    if ([textField.text containsString:@"元"]) {
        
    }
    textField.text = [NSString stringWithFormat:@"%@元",textField.text];
}

@end
