//
//  WKHelp.h
//  YFKit
//
//  Created by 王宇 on 2018/4/28.
//  Copyright © 2018年 wy. All rights reserved.
//

#ifndef WKHelp_h
#define WKHelp_h

//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
//导航栏高度
#define NavHeight ((44.0 + [[UIApplication sharedApplication] statusBarFrame].size.height == 88.0) ? 88.0f : 64.0f)
// Tabbar 高度
#define TabbarHeight (NavHeight == 88.0 ? 83.0f : 49.0f)

#define ISIPHONEX   (NavHeight == 88.0 ? YES : NO)

#define XHEIGHT     24

#define BTNFONT     [UIFont systemFontOfSize:16]

//适配高度
#define KHeight(height) height*ScreenWidth/375.0f
//适配宽度
#define KWidth(width) KHeight(width)

//百度地图  fUpYctPLjNGLR77Ni7WIdpYpPsF36hkv
#define APIKey  @"ef4b045ea93d99c51307da309f0ada76"

//Bugly
#define BuglyAppId   @"5fc78052b3"

//阿里百川
#define AlibcAppkey  @"25989026"

//友盟
#define UmengAppKey   @"5cb579e60cafb28bc70014f2"
#define UmengURL      @"http://www.umeng.com/social"

//微信的Key
#define WXAppId            @"wx55cdec5c462c13af"
#define WXappSecret        @"0d47df340f75baf8950db58bb39afa58"
#define WeiXinPartnerId    @"1503466011"
#define WeiXinPartnerKey   @"12AsdAsd88888273hashdjdhASHDSHDD"

//个推
#define kGtAppId           @"NWYKWe3CCf8fk6TkpKKB56"
#define kGtAppKey          @"yufa0IzJSk6owhjKo4Mua1"
#define kGtAppSecret       @"p4gJFpoMXj6ZHqdYPO3U26"

//加密公钥
#define  RSA_Public_Key @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDKElEBrpz7lY7ADUqDKusCKWLrYHYmRNX5EM1tW8fyu3oRQHiNQqCzviI9W89e5k+v/48oGfA/wr5xlnXjr8ZEgZ4BXQU5qpGP1qzsX9S6MU/wHM2GFadkkXLwx2d/cP4Wvg35pOQmkXCIT+B2LaFBIx070B19XmY9NhIvly9VTwIDAQAB"
//加密常量
#define RSA_CONS_KEY @"502880496058fbb7016068fc201e0019"

//项目名
#define APP_NAME ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"])
//版本号
#define APP_VERSION ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])

//自定义颜色
#define CustomColor(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//主题色
#define NavColor UIColorFromRGB(0xF78556)

#define YFWindow        [UIApplication sharedApplication].keyWindow

// 设置view的圆角和边框
#define SKViewsBorder(View,radius,width,color)\
\
[View.layer setCornerRadius:(radius)];\
[View.layer setBorderWidth:(width)];\
[View.layer setBorderColor:[color CGColor]];

#pragma mark ---------------------------------LOG--------------------------------------------------
//打印Log
#ifdef DEBUG
#define DLog( s, ... )                          NSLog( @"<%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DLog( s, ... )
#endif

#pragma mark --------------------weakify-------------
#ifndef    weakify
#if __has_feature(objc_arc)

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")

#else

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __block __typeof__(x) __block_##x##__ = x; \
_Pragma("clang diagnostic pop")

#endif
#endif

#ifndef    strongify
#if __has_feature(objc_arc)

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")

#else

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __block_##x##__; \
_Pragma("clang diagnostic pop")


#endif
#endif

#pragma mark --------------------------------------Notification and UserDefaults-------------------

#define  YFNotificationCenter [NSNotificationCenter defaultCenter]
#define  YFUserDefaults       [NSUserDefaults  standardUserDefaults]

#pragma mark ------------------------------Bolck Self--------------------------------------------------
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
//常用的宏
#define CODE_ZERO (baseModel.code.integerValue == 0 || baseModel.code.integerValue == 200)
//默认时间, 6分钟类不需要付钱
#define DEFAULT_TIME 360

//判断登录
#define IsLogin [UserData isUserLogin]
//用户 UUID
#define USER_UUID [UserData userInfo].uuid

// 用户没有登录
#define KUSERNOTLOGIN if (![UserData isUserLogin]) {\
[[YFKeyWindow shareInstance] login];\
return ;\
}

//alert Title 提示语
#define wenxinTitle @"温馨提示"
#define errorMsg @"请检查网络连接"

#pragma mark ----------------------------------尺寸---------------------------------------------
#define IS_IPHONE6P         CGSizeEqualToSize([[UIScreen mainScreen] preferredMode].size,CGSizeMake(1242, 2208))
#define IS_IPHONE6          CGSizeEqualToSize([[UIScreen mainScreen] preferredMode].size,CGSizeMake(750, 1334))
#define IS_IPHONE5          CGSizeEqualToSize([[UIScreen mainScreen] preferredMode].size,CGSizeMake(640, 1136))

#endif /* WKHelp_h */
