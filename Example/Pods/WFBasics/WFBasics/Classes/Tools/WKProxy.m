//
//  WKProxy.m
//  WFKit
//
//  Created by 王宇 on 2019/4/16.
//  Copyright © 2019 王宇. All rights reserved.
//

#import "WKProxy.h"

@implementation WKProxy

+ (instancetype)proxyWithTarget:(id)target
{
    // NSProxy对象不需要调用init，因为它本来就没有init方法
    WKProxy *proxy = [WKProxy alloc];
    proxy.target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation invokeWithTarget:self.target];
}

@end
