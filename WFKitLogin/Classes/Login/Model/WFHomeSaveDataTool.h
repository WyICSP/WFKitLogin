//
//  WFHomeSaveDataTool.h
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/8/8.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFHomeSaveDataTool : NSObject

/**
 初始化

 @return 初始化
 */
+ (instancetype)shareInstance;

/**
 保存数据

 @param datas json
 */
- (void)SaveAddressFile:(NSArray *)datas;

/**
 读取数据

 @return 返回数据
 */
- (NSArray *)readAddressFile;

/**
 保存地址位置

 @return 保存地址
 */
- (NSString *)savepath;


/**
 删除地址
 */
- (void)deleteAddress;

@end

NS_ASSUME_NONNULL_END
