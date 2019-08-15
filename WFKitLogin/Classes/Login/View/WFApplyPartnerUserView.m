//
//  WFApplyPartnerUserView.m
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/8/7.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import "WFApplyPartnerUserView.h"
#import "WFHomeSaveDataTool.h"
#import "YFAddressPickView.h"
#import "WKHelp.h"

@interface WFApplyPartnerUserView()
@property (nonatomic, assign) int num;
@end

@implementation WFApplyPartnerUserView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.num = 0;
    self.nameView.layer.cornerRadius = self.phoneView.layer.cornerRadius = self.areaView.layer.cornerRadius = self.viewHeightCons.constant/2;
    self.numView.layer.borderColor = UIColorFromRGB(0xDCDCDC).CGColor;
    self.numView.layer.borderWidth = 0.8f;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

/**
 按钮点击事件
 
 @param sender 10 减 20 加 30 常见问题
 */
- (IBAction)clickBtn:(UIButton *)sender {
    if (sender.tag == 10) {
        //减
        if (self.num == 0) return;
        self.num --;
        self.numTF.text = [NSString stringWithFormat:@"%d",self.num];
    }else if (sender.tag == 20) {
        //加
        self.num ++;
        self.numTF.text = [NSString stringWithFormat:@"%d",self.num];
    }else if (sender.tag == 30) {
        
    }
}

- (IBAction)clickAddressBtn:(id)sender {
    
    YFAddressPickView *addressPickView = [YFAddressPickView shareInstance];
    addressPickView.addressDatas = [[WFHomeSaveDataTool shareInstance] readAddressFile];
    WS(weakSelf)
    addressPickView.startPlaceBlock = ^(NSString *address, NSString *addressId) {
        DLog(@"地址=%@-addressId=%@",address,addressId);
        [weakSelf.addressBtn setTitle:address forState:UIControlStateNormal];
        [weakSelf.addressBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    };
    [YFWindow addSubview:addressPickView];
}


@end
