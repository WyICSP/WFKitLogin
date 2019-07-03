//
//  WFLoginBottomView.h
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/4/15.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WFLoginAndRegisterType) {
    WFRegisterType = 0,//注册
    WFLoginType//登录
};

@interface WFLoginBottomView : UIView
/**注册还是登录*/
@property (nonatomic, assign) WFLoginAndRegisterType  lrType;
/**点击事件的同意处理*/
@property (nonatomic, copy) void (^jumpCtrlBlock)(UIViewController *ctrl,WFLoginAndRegisterType type);
@end

NS_ASSUME_NONNULL_END
