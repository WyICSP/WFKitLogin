//
//  WFNewHomeAssetsView.m
//  WFKitLogin_Example
//
//  Created by 王宇 on 2020/4/23.
//  Copyright © 2020 wyxlh. All rights reserved.
//

#import "WFNewHomeAssetsView.h"
#import "WFNewHomeModel.h"
#import "WKHelp.h"

@implementation WFNewHomeAssetsView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentsView.layer.cornerRadius = 10.0f;
    
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTodayEvent:)];
    [self.contentsView addGestureRecognizer:tap];
}

- (void)clickTodayEvent:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.contentsView];
    CGFloat x = point.x;
    CGFloat screenWidth = ScreenWidth - 30.0f;
    if (x <= screenWidth/4) {
        // 片区数量
        !self.clickAssetsEventBlock ? : self.clickAssetsEventBlock(40);
    } else if (x > screenWidth/4 && x <= screenWidth/4*2) {
        // 设备数量
        !self.clickAssetsEventBlock ? : self.clickAssetsEventBlock(50);
    } else if (x > screenWidth/4*2 && x <= screenWidth/4*3){
        // 设备警告
        !self.clickAssetsEventBlock ? : self.clickAssetsEventBlock(60);
    }else {
        // 插座状态
        !self.clickAssetsEventBlock ? : self.clickAssetsEventBlock(70);
    }
}

- (void)setModel:(WFNewHomeModel *)model {
    // 片区数量
    self.groupNum.text = [NSString stringWithFormat:@"%ld",(long)model.groupNum];
    // 充电桩在线数量
    self.equOnlineNum.text = [NSString stringWithFormat:@"%ld",(long)model.onlineCdzNum];
    // 充电桩总数量
    self.equTotalNum.text = [NSString stringWithFormat:@"/%ld",(long)model.totalCdzNum];
    // 故障
    self.errorNum.text = [NSString stringWithFormat:@"%ld",(long)model.errorNum];
    // 插座在线
    self.sctOneLineNum.text = [NSString stringWithFormat:@"%ld",(long)model.onlineNum];
    // 插座总数量
    self.sctTotalNum.text = [NSString stringWithFormat:@"/%ld",(long)model.totalNum];
}
- (IBAction)clickPileBtn:(id)sender {
    !self.clickAssetsEventBlock ? : self.clickAssetsEventBlock(190);
}

@end
