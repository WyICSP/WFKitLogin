//
//  NSString+Regular.m
//  YFKit
//
//  Created by 王宇 on 2018/4/28.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "NSString+Regular.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
@implementation NSString (Regular)
//移除空格
-(NSString *)removeWhiteSpace
{
    NSString *resultStr=@"";
    NSArray *arr=[self componentsSeparatedByString:@" "];
    for (NSString *str in arr)
    {
        resultStr = [resultStr stringByAppendingString:str];
    }
    return resultStr;
}
//移除短线
-(NSString *)removeWhiteline
{
    NSString *resultStr=@"";
    NSArray *arr=[self componentsSeparatedByString:@"-"];
    for (NSString *str in arr)
    {
        resultStr = [resultStr stringByAppendingString:str];
    }
    return resultStr;
}

- (BOOL)isPureIntStr{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}
//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//手机号码验证。YES 是手机号
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13，14， 15，17,18开头，八个 \d 数字字符
    NSString *phoneRegex = @"(^1[3|4|5|6|7|8|9][0-9]{9}$)";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//判断座机号
+ (BOOL)isTelPhoneNumber:(NSString *)mobileNum{
    //验证输入的固话中带 "-"符号
    NSString * strNum = @"^(0\\d{2,3}-?\\d{7,8}$)";
    NSPredicate *checktest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strNum];
    BOOL isPhene = [checktest evaluateWithObject:mobileNum];
    NSString * strNum1 = @"^(\\d{7,8}$)";
    NSPredicate *checktest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strNum1];
    BOOL isPhene1 = [checktest1 evaluateWithObject:mobileNum];
    if (isPhene || isPhene1) {
        return YES;
    }
    return NO;
}

// 计算文字宽高
+(CGSize)getStringSize:(float)fontSize withString:(NSString*)str andWidth:(CGFloat)width
{
    if (str.length==0) {
        return CGSizeMake(0, 0);
    }
    return [str boundingRectWithSize:CGSizeMake(width, LONG_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
}


//用户名
+ (BOOL) validateUserName:(NSString *)name{
    
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamePredicate evaluateWithObject:name];
    
}


+(NSString *)getDigitsOnly:(NSString*)s{
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < s.length; i++)
    {
        c = [s characterAtIndex:i];
        if (isdigit(c))
        {
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    return digitsOnly;
}

#pragma  mark - 验证银行卡
+(BOOL)isValidCardNumber:(NSString *)cardNumber
{
    NSString *digitsOnly = [self getDigitsOnly:cardNumber];
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (int i = digitsOnly.length  - 1.0; i >= 0; i--)
    {
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}

//密码
+ (BOOL) validatePassword:(NSString *)passWord{
    
    NSString *passWordRegex = @"^(?![0-9]+$)(?![A-Za-z]+$)[0-9A-Za-z]{6,15}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
    
}


//昵称
+ (BOOL) validateNickname:(NSString *)nickname{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}


//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard{
    
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

//车牌号
+ (BOOL)isValidCarID:(NSString *)carID {
    if (carID.length!=7) {
        return NO;
    }
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-zA-HJ-Z]{1}[a-hj-zA-HJ-Z_0-9]{4}[a-hj-zA-HJ-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:carID];
    
    return YES;
}


//格式化时间
+(NSString *)fomartDate:(NSString *)Date{
    long long time=[Date doubleValue];
    NSDate *nd = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy/MM/dd"];
    NSString *dateString = [dateFormat stringFromDate:nd];
    return dateString;
}

/**
 * 安全获取字符串
 * @param mStr 字符串
 * @returns 若字符串为nil，则返回@""，否则直接返回字符串
 */
+ (NSString *)strOrEmpty:(NSString *)mStr {
    return (!mStr || [mStr class] == [NSNull class] ) ? @"": mStr;
}


// 生成随机订单ID
+ (NSString *)generateTradeNO
{
    static int kNumber = 15;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((int)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

//获取手机IP
+ (NSString *)getPhoneIP {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    if ([address isEqualToString:@"error"])
    {
        address = @"192.168.1.1";
    }
    return address;
    
}

//第一次进App
+ (BOOL)isFirstTimeEnterApp
{
    static NSString *fristTimeEnterAppKey = @"fristTimeEnterAppKey";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if([userDefaults objectForKey:fristTimeEnterAppKey])
    {
        return (NO);
    }
    [userDefaults setValue:@"" forKey:fristTimeEnterAppKey];
    return (YES);
}

/**
 *  MD5 加密字符串
 */
+ (NSString *)MD5NSString:(NSString *)string{
    
    if (string == nil || [string length] == 0) {
        return nil;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
    
}

/**
 *  判断字符串是否为空
 */

+(BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
//判断是否为弱密码
-(BOOL)weakPswd{
    NSString *pswdEx =@"^(?=.*\\d.*)(?=.*[a-zA-Z].*).{6,15}$";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pswdEx];
    return [regExPredicate evaluateWithObject:self];
}
//string转date
+ (NSDate *)dateFromString:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    
    return destDate;
    
}

#pragma mark - 校验护照
+ (BOOL) isValidPassport:(NSString*)value
{
    const char *str = [value UTF8String];
    char first = str[0];
    NSInteger length = strlen(str);
    if (!(first == 'P' || first == 'G'))
    {
        return FALSE;
    }
    if (first == 'P')
    {
        if (length != 8)
        {
            return FALSE;
        }
    }
    if (first == 'G')
    {
        if (length != 9)
        {
            return FALSE;
        }
    }
    BOOL result = TRUE;
    for (NSInteger i = 1; i < length; i++)
    {
        if (!(str[i] >= '0' && str[i] <= '9'))
        {
            result = FALSE;
            break;
        }
    }
    return result;
}

-(BOOL)isNumberString
{
    NSCharacterSet *numberSet = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:self];
    if ([numberSet isSupersetOfSet:stringSet])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//判断是否为整形：
+ (BOOL)isPureInt:(NSString *)string{
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

/**
 判断是否是汉字
 */
+ (BOOL)isAllChinese:(NSString *)str{
    NSInteger count = str.length;
    NSInteger result = 0;
    for(int i=0; i< [str length];i++)
    {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)//判断输入的是否是中文
        {
            result++;
        }
    }
    if (count == result) {//当字符长度和中文字符长度相等的时候
        return YES;
    }
    return NO;
    
}

//1、判断输入的字符串是否有中文

+ (BOOL)IsChinese:(NSString *)str
{
    for(int i=0; i< [str length];i++)
    {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)//判断输入的是否是中文
        {
            return YES;
        }
    }
    return NO;
}

/**
 传入两个可为空的参数 返回对应的数据
 */
+ (NSString *)getCarMessageWithFirst:(NSString *)first AndSecond:(NSString *)second{
    if ([NSString isBlankString:first]&&![NSString isBlankString:second]) {
        //第一个为空 第二个不为空
        return second;
    }else if (![NSString isBlankString:first]&&[NSString isBlankString:second]){
        //第一个不为空  第二个为空
        return first;
    }else if ([NSString isBlankString:first]&&[NSString isBlankString:second]){
        //两着都为空
        return @"";
    }else{
        //两者都不为空
        return [NSString stringWithFormat:@"%@/%@",first,second];
    }
}

/**
 获取版本号
 */
+ (NSString *)getAppVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
//    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}


/**
 传入一个字符串 返回空 或者字符串
 */
+ (NSString *)getNullOrNoNull:(NSString *)StrNull{
    if ([NSString isBlankString:StrNull]) {
        return @"";
    }
    return StrNull;
}

/**
 得到 json 字符串
 */
+ (NSString *)dictionTransformationJson:(NSDictionary *)parms{
    NSError *error;
    NSString *jsonStr = @"";
    if ([parms isKindOfClass:[NSDictionary class]]) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parms options:NSJSONWritingPrettyPrinted error:&error];
        jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonStr;
}




/**
 传入 一个时间 返回多少秒  传入 一个时间  和一个分钟 返回多少秒
 */
+ (NSInteger)getSecond:(NSString *)time Minute:(NSInteger)minute{
    //获取当前时间
    NSDate *nowDate = [NSDate date];
    //创建一个日期格式化格式
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    // 截止时间字符串格式
    NSString *expireDateStr = time;
    // 当前时间字符串格式
    NSString *nowDateStr = [dateFomatter stringFromDate:nowDate];
    // 截止时间data格式
    NSDate *expireDate = [dateFomatter dateFromString:expireDateStr];
    // 当前时间data格式
    nowDate = [dateFomatter dateFromString:nowDateStr];
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:expireDate toDate:nowDate options:0];
    
    if (dateCom.hour == 0 && dateCom.minute <= 30) {
        return minute*60 - (dateCom.minute * 60 + dateCom.second);
    }
    return 0;
}

/**
 转入多少秒 返回时分秒
 */
+ (NSString *)getMMSSFromSS:(NSString *)totalTime{
    
    NSInteger seconds = [totalTime integerValue];
    
    //format of hour
//    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(long)(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",(long)seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    
    return format_time;
}

/**
 传入一个时间 返回几分钟就 就像微博一
 */
+ (NSString *)compareCurrentTime:(NSString *)time
{
    
    //把字符串转为NSdate
    //    str=@"2017-02-01 14:34:31";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:time];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    timeInterval = timeInterval - 8*60*60;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}
/**
 判断这个时间是否是当天
 */
+ (BOOL)checkTheDate:(NSString *)string{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *date = [format dateFromString:string];
    BOOL isToday = [[NSCalendar currentCalendar] isDateInToday:date];
    return isToday;
}

/**
 得到一个地址的区名
 */
+ (NSString *)getAddressAraeString:(NSString *)arae{
    NSArray *areaArr = [arae componentsSeparatedByString:@"/"];
    return [areaArr lastObject];
}

/**
 替换字符串
 */

+ (NSString *)getReplaceAfterWithReplaceBefore:(NSString *)replaceBefore
                             NeedReplaceString:(NSString *)needReplaceString
                            ReplaceAfterString:(NSString *)replaceAfterString{
    return [replaceBefore stringByReplacingOccurrencesOfString:needReplaceString withString:replaceAfterString];  //去掉空格
}

/**
 组件化得到图片的文件路径
 @param currentBundler 图片文件存在的 bundle
 @param photoName 图片名
 @param bundlerName 当前的项目的 bundle 名
 @return 图片的路径
 */
+ (NSString *)getImagePathWithCurrentBundler:(NSBundle *)currentBundler
                                   PhotoName:(NSString *)photoName
                                 bundlerName:(NSString *)bundlerName {
    //获取屏幕 pt 和 px 之间的比例
    NSInteger scale = [UIScreen mainScreen].scale;
    NSString *imgName = [NSString stringWithFormat:@"%@@%zdx.png",photoName,scale];
    //得到图片的路径
    NSString *imgPath = [currentBundler pathForResource:imgName ofType:nil inDirectory:bundlerName];
    return imgPath;
}



@end
