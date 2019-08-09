//
//  WFLocationTools.h
//  WFBasics_Example
//
//  Created by 王宇 on 2019/7/17.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFLocationTools : NSObject
@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;
+ (WFLocationTools *)shareInstace;
@end

NS_ASSUME_NONNULL_END
