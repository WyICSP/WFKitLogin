//
//  WKProxy.h
//  WFKit
//
//  Created by 王宇 on 2019/4/16.
//  Copyright © 2019 王宇. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKProxy : NSProxy

@property (weak, nonatomic) id target;

+ (instancetype)proxyWithTarget:(id)target;
@end

NS_ASSUME_NONNULL_END
