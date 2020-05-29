//
//  WFNewHomeTodayDescView.m
//  AFNetworking
//
//  Created by 王宇 on 2020/5/29.
//

#import "WFNewHomeTodayDescView.h"

@implementation WFNewHomeTodayDescView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btn.layer.cornerRadius = 20.0f;
}

- (IBAction)clickBtn:(id)sender {
    !self.clickDissaperBlock ? : self.clickDissaperBlock();
}
@end
