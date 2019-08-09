//
//  UIImage+QRCode.h
//  AFNetworking
//
//  Created by 王宇 on 2019/8/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (QRCode)

//普通的二维码
+(UIImage *)WY_ImageOfQRFromURL:(NSString *)urlStr codeSize:(CGFloat)codeSize;


@end

NS_ASSUME_NONNULL_END
