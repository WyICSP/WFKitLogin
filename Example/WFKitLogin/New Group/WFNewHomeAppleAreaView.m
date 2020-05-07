//
//  WFNewHomeAppleAreaView.m
//  WFKitLogin_Example
//
//  Created by 王宇 on 2020/4/23.
//  Copyright © 2020 wyxlh. All rights reserved.
//

#import "WFNewHomeAppleAreaView.h"
#import "WKHelp.h"

@implementation WFNewHomeAppleAreaView

- (void)awakeFromNib {
    [super awakeFromNib];
    SKViewsBorder(self.applyPileBtn, 46.0f/2, 0.5, UIColorFromRGB(0xE4E4E4));
    SKViewsBorder(self.applyArea, 46.0f/2, 0.5, UIColorFromRGB(0xE4E4E4));
}
- (IBAction)clickBtn:(UIButton *)sender {
    !self.clickAreaEventBlock ? : self.clickAreaEventBlock(sender.tag);
}

@end
