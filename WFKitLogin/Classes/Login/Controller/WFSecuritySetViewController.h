//
//  WFSecuritySetViewController.h
//  AFNetworking
//
//  Created by 王宇 on 2019/12/19.
//

#import <WFKitMain/YFBaseViewController.h>


typedef NS_ENUM(NSUInteger, WFSecuritySetType) {
    WFSecuritySetForgetPswType = 0, //修改密码
    WFSecuritySetUpgradeType = 1 //重新设置密码
};

NS_ASSUME_NONNULL_BEGIN

@interface WFSecuritySetViewController : YFBaseViewController
/// 区分类型
@property (nonatomic, assign) WFSecuritySetType setType;
/// 用户手机号
@property (nonatomic, copy) NSString *userPhone;
/// 用户信息
@property (nonatomic, strong) NSDictionary *userInfo;

@property (nonatomic, copy) WFSecuritySetViewController *(^secutityType)(WFSecuritySetType setType);
@property (nonatomic, copy) WFSecuritySetViewController *(^userMoblie)(NSString *userPhone);
@property (nonatomic, copy) WFSecuritySetViewController *(^userLoginInfo)(NSDictionary *userInfo);
/// 初始化
+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
