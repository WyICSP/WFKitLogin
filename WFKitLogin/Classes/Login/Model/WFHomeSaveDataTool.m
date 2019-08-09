//
//  WFHomeSaveDataTool.m
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/8/8.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import "WFHomeSaveDataTool.h"

@implementation WFHomeSaveDataTool

+ (instancetype)shareInstance {
    __strong static WFHomeSaveDataTool *saveData;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        saveData = [[WFHomeSaveDataTool alloc]init];
    });
    return saveData;
}

#pragma mark 读取数据
- (void)SaveAddressFile:(NSArray *)datas {
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:datas forKey:@"AddressFile"];
    [archiver finishEncoding];  //结束添加对象到data中
    [data writeToFile:[self savepath]  atomically:YES];//将data写到文件中保存在磁盘上
}

- (NSArray *)readAddressFile {
    NSData *content= [NSData dataWithContentsOfFile:[self savepath]];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:content];
    return [unarchiver decodeObjectForKey:@"AddressFile"];
}

- (NSString *)savepath {
    NSString *homeDirectory = NSHomeDirectory(); //获取根目录
    homeDirectory = [homeDirectory stringByAppendingString:@"/Library/Caches"];
    NSString *homePath = [homeDirectory stringByAppendingPathComponent:@"AddressFile"];
    return homePath;
}

- (void)deleteAddress {
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:@"" forKey:@"AddressFile"];
    [archiver finishEncoding];  //结束添加对象到data中
    [data writeToFile:[self savepath]  atomically:YES];//将data写到文件中保存在磁盘上
}

@end
