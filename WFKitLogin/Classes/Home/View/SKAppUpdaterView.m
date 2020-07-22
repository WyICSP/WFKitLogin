//
//  SKAppUpdaterView.m
//  SKKit
//
//  Created by maxin on 2017/6/2.
//  Copyright © 2017年 maxin. All rights reserved.
//

#import "SKAppUpdaterView.h"
#import "AttributedLbl.h"
#import "UIView+Frame.h"
#import "WKHelp.h"

#import "NSString+Regular.h"

@implementation SKAppUpdaterView

+ (instancetype)shareInstance {
    static SKAppUpdaterView *updateView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        updateView = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"SKAppUpdaterView" owner:nil options:nil] firstObject];
    });
    return updateView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIColor *color = [UIColor blackColor];
    self.backgroundColor = [color colorWithAlphaComponent:0.5];
    SKViewsBorder(self.version, 8.5, 0, [UIColor redColor]);
    SKViewsBorder(self.updateBgView, 8.5, 0, [UIColor redColor]);
    self.contentsView.layer.cornerRadius = 10.0f;
    self.version.layer.backgroundColor = NavColor.CGColor;
    self.version.layer.cornerRadius = self.version.height / 2.0f;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
    self.scrollView = scrollView;
    [self.contentView addSubview:scrollView];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:scrollView.bounds];
    self.contentLabel.textColor = UIColorFromRGB(0x6A6A6A);
    self.contentLabel.numberOfLines = 4;
    self.contentLabel.font = [UIFont systemFontOfSize:13];
    [scrollView addSubview:self.contentLabel];
}


- (void)setVersionList:(NSArray *)versionList {

    self.contentLabel.numberOfLines = versionList.count;
    NSString *msg = [versionList componentsJoinedByString:@"\n"];
    //一行的高度为 20 总的高度
    CGFloat changeHeight = versionList.count * 20.0f;
    //改变 contentView 的约束 最多只能为为 80
    self.contentViewCons.constant = self.scrollView.height = changeHeight > 80.0f ? 80.0f : changeHeight+6.5;
    //间距 要减 1
    CGFloat space = (versionList.count-1) * 5;
    self.contentLabel.height = changeHeight + space;
    
    self.scrollView.contentSize = CGSizeMake(self.contentView.width, changeHeight + space);
    //设置 更新文本
    [AttributedLbl setRiChLineSpacing:self.contentLabel titleString:msg LineSpacing:5];
}


- (IBAction)closeBtn:(id)sender {
    [self dismiss];
}

-(void)dismiss{

    UIView * updateview  = [YFWindow viewWithTag:123456];
    [updateview removeFromSuperview];
    updateview = nil;
}

- (IBAction)clickUpdateBtn:(id)sender {
    NSString *appStoreURL = @"";
    if ([self.appUrl containsString:@"1394434776"]) {
        appStoreURL = [self.appUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }else {
        appStoreURL = @"https://apps.apple.com/cn/app/%E4%BA%91%E6%99%BA%E5%85%85%E5%90%88%E4%BD%9C%E7%89%88/id1394434776";
    }
    NSURL *appUrl = [NSURL URLWithString:appStoreURL];
    if ([[UIApplication sharedApplication] canOpenURL:appUrl]) {
        [[UIApplication sharedApplication] openURL:appUrl];
    }
}



@end
