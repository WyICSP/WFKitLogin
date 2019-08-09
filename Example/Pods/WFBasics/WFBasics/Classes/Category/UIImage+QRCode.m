//
//  UIImage+QRCode.m
//  AFNetworking
//
//  Created by 王宇 on 2019/8/5.
//

#import "UIImage+QRCode.h"

@implementation UIImage (QRCode)

+(UIImage *)WY_ImageOfQRFromURL:(NSString *)urlStr codeSize:(CGFloat)codeSize{
    
    if (urlStr ==nil || [urlStr isEqualToString:@""]) {
        return  nil;
    }
    
    //限制大小
    codeSize = [self limitCodeSize:codeSize];
    
    CIImage *outputImage = [self QRFromUrl:urlStr];
    
    UIImage *finalImage =  [self createUIImageFormCIImage:outputImage withSize:codeSize];
    
    return finalImage;
}

//限制大小
+(CGFloat)limitCodeSize:(CGFloat)codeSize
{
    codeSize = MAX(160, codeSize);
    codeSize = MIN(CGRectGetWidth([UIScreen mainScreen].bounds) - 80, codeSize);
    return codeSize;
}
//根据url 创建CIImage
+(CIImage *)QRFromUrl:(NSString *)urlStr{
    // 1、创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 恢复滤镜的默认属性
    [filter setDefaults];
    
    // 2、设置数据
    NSString *info = urlStr;
    // 将字符串转换成
    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    
    // 通过KVC设置滤镜inputMessage数据
    [filter setValue:infoData forKeyPath:@"inputMessage"];
    
    // 3、获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    return outputImage;
}

/** 根据CIImage生成指定大小的UIImage */
+ (UIImage *)createUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


@end
