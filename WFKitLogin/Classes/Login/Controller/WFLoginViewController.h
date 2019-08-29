//
//  WFLoginViewController.h
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/4/15.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import <WFKitMain/YFBaseViewController.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WFJumpLoginCtrlType) {
    WFJumpLoginCtrlAppTpye = 0,//原生
    WFJumpLoginCtrlH5Tpye //H5
};

@interface WFLoginViewController : YFBaseViewController

@property (nonatomic, assign) WFJumpLoginCtrlType loginType;

+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
