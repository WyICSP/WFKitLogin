//
//  WFNewHomeAssetsDsecView.m
//  AFNetworking
//
//  Created by 王宇 on 2020/5/29.
//

#import "WFNewHomeAssetsDsecView.h"

@implementation WFNewHomeAssetsDsecView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btn.layer.cornerRadius = 20.0f;
}


- (IBAction)clickBtn:(id)sender {
    !self.clickDissaperBlock ? : self.clickDissaperBlock();
}

@end
