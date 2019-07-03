//
//  YFEmptyDataView.m
//  YFBasicComponents_Example
//
//  Created by 王宇 on 2019/1/17.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import "YFEmptyDataView.h"

@implementation YFEmptyDataView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.emptyBtn.layer.cornerRadius = 3;
}

+ (instancetype)loadEmptyView {
    
    NSBundle *currenBundle = [NSBundle bundleForClass:self];
    
    YFEmptyDataView *middleView = [[currenBundle loadNibNamed:@"YFEmptyDataView" owner:nil options:nil] firstObject];
    return middleView;
}

- (IBAction)clickEmptyBtn:(id)sender {
    !self.clickEmptyBtnBlock ? : self.clickEmptyBtnBlock();
}

@end
