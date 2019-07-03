//
//  YFMediatorManager.h
//  YFMainSkeletion_Example
//
//  Created by 王宇 on 2018/12/24.
//  Copyright © 2018 wyxlh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YFMediatorManager : NSObject

// 本地组件调用入口 
+ (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(id)params isRequiredReturnValue: (BOOL)isRequiredReturnValue;



@end

