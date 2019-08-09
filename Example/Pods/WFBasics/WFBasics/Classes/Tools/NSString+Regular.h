//
//  NSString+Regular.h
//  YFKit
//
//  Created by 王宇 on 2018/4/28.
//  Copyright © 2018年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>

@interface NSString (Regular)

/**
 *  移除空格
 */
-(NSString *)removeWhiteSpace;

-(NSString *)removeWhiteline;
/**
 计算文字宽高
 
 @param fontSize fontSize description
 @param str str description
 @param width width description
 @return return value description
 */
+(CGSize)getStringSize:(float)fontSize withString:(NSString*)str andWidth:(CGFloat)width;

//是否是数字
- (BOOL)isPureIntStr;

/**
 //邮箱
 
 @param email email description
 @return return value description
 */
+ (BOOL) validateEmail:(NSString *)email;

/**
 //手机号码验证
 
 @param mobile mobile description
 @return return value description
 */
+ (BOOL) validateMobile:(NSString *)mobile;


/**
 判断座机号
 */
+ (BOOL)isTelPhoneNumber:(NSString *)mobileNum;

/**
 用户名
 
 @param name name description
 @return return value description
 */
+ (BOOL) validateUserName:(NSString *)name;


+(NSString *)getDigitsOnly:(NSString*)s;

+(BOOL)isValidCardNumber:(NSString *)cardNumber;

/**
 *  //密码
 *
 *  @param passWord passWord description
 *
 *  @return return value description
 */
+ (BOOL) validatePassword:(NSString *)passWord;


/**
 是否包含特殊字符
 
 @param content 内容
 @return yes 包含, no 不包含
 */
+ (BOOL)JudgeTheillegalCharacter:(NSString *)content;

/**
 *  //昵称
 *
 *  @param nickname nickname description
 *
 *  @return return value description
 */
+ (BOOL) validateNickname:(NSString *)nickname;


/**
 *  //身份证号
 *
 *  @param identityCard identityCard description
 *
 *  @return return value description
 */
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

/**
 车牌号
 */
+ (BOOL)isValidCarID:(NSString *)carID;

/**
 *  //格式化时间时间
 *
 
 */
+(NSString *)fomartDate:(NSString *)Date;

/**
 获取当前时间
 */
+ (NSString *)getCurrentDate:(NSDate *)date;


/**
 * 安全获取字符串
 * @param mStr 字符串
 * @returns 若字符串为nil，则返回@""，否则直接返回字符串
 */
+ (NSString *)strOrEmpty:(NSString *)mStr;

/**
 *  // 生成随机订单ID
 *
 *
 */
+ (NSString *)generateTradeNO;

/**
 *
 *  //获取手机IP
 *
 */
+ (NSString *)getPhoneIP;

/**
 *  //第一次进App
 *
 *
 */
+ (BOOL)isFirstTimeEnterApp;

/**
 *  MD5 加密字符串
 */
+ (NSString *)MD5NSString:(NSString *)string;

/**
 *  判断字符串是否为空
 */
+ (BOOL) isBlankString:(NSString *)string;
/**
 *  弱密码判断
 */
- (BOOL)weakPswd;
/**
 *  string转nsdate
 */
+ (NSDate *)dateFromString:(NSString *)dateString;

/**
 护照
 
 */
+ (BOOL) isValidPassport:(NSString*)value;

/**
 *  判断数字
 */
- (BOOL)isNumberString;

//判断是否为整形：

+ (BOOL)isPureInt:(NSString*)string;

/**
 判断是否汉字
 */
+ (BOOL)isAllChinese:(NSString *)str;

/**
 判断是否含有汉字
 */
+ (BOOL)IsChinese:(NSString *)str;

/**
 传入两个可为空的参数 返回对应的数据
 */
+ (NSString *)getCarMessageWithFirst:(NSString *)first AndSecond:(NSString *)second;

/**
 获取版本号
 */
+ (NSString *)getAppVersion;

/**
 传入一个字符串 返回空 或者字符串
 */
+ (NSString *)getNullOrNoNull:(NSString *)StrNull;

/**
 得到 json 字符串
 */
+ (NSString *)dictionTransformationJson:(NSDictionary *)parms;

/**
 传入 一个时间  和一个分钟 返回多少秒
 */
+ (NSInteger)getSecond:(NSString *)time Minute:(NSInteger )minute;

/**
 转入多少秒 返回时分秒
 */
+ (NSString *)getMMSSFromSS:(NSString *)totalTime;

/**
 传入一个时间 返回几分钟就 就像微博一样
 */
+ (NSString *)compareCurrentTime:(NSString *)time;

/**
 判断这个时间是否是当天
 */
+ (BOOL)checkTheDate:(NSString *)string;

/**
 得到一个地址的区名
 */
+ (NSString *)getAddressAraeString:(NSString *)arae;

/**
 获取手机的 UUID
 */
+ (NSString*)getEquipmentUUID;

/**
 替换字符串
 @param replaceBefore 需要替换的string
 @param needReplaceString 需要替换的东西
 @param replaceAfterString 替换成什么
 */
+ (NSString *)getReplaceAfterWithReplaceBefore:(NSString *)replaceBefore
                             NeedReplaceString:(NSString *)needReplaceString
                            ReplaceAfterString:(NSString *)replaceAfterString;


/**
 组件化得到图片的文件路径
 @param currentBundler 图片文件存在的 bundle
 @param photoName 图片名
 @param bundlerName 当前的项目的 bundle 名
 @return 图片的路径
 */
+ (NSString *)getImagePathWithCurrentBundler:(NSBundle *)currentBundler
                                   PhotoName:(NSString *)photoName
                                 bundlerName:(NSString *)bundlerName;

/**
 获取时间戳
 
 @return getNowTimeTimestamp
 */
+(NSString *)getNowTimeTimestamp;


/**
 传入一个时间戳
 
 @return 返回一个时间
 */
+ (NSString *)getNowTimeStampDate:(NSString *)timeStamp;


/**
 获取手机型号
 
 @return getCurrentDeviceModel
 */
+ (NSString *)getCurrentDeviceModel;

@end
