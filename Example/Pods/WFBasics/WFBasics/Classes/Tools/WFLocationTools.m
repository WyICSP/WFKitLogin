//
//  WFLocationTools.m
//  WFBasics_Example
//
//  Created by 王宇 on 2019/7/17.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import "WFLocationTools.h"

@implementation WFLocationTools

+ (WFLocationTools *)shareInstace{
    __strong static WFLocationTools *locationTools;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationTools = [[WFLocationTools alloc]init];
    });
    return locationTools;
}

@end
