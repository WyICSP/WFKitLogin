//
//  WFApplyAddressModel.m
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/8/8.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import "WFApplyAddressModel.h"
#import <MJExtension/MJExtension.h>

@implementation WFApplyAddressModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Id":@"id"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"cityEntityList":@"WFHomeCityEntityListModel"};
}

@end

@implementation WFHomeCityEntityListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Id":@"id"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"areaEntityList":@"WFHomeAreaEntityListModel"};
}

@end

@implementation WFHomeAreaEntityListModel


@end
