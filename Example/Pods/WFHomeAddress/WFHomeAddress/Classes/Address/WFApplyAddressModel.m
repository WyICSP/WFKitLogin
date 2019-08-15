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
    return @{@"Name":@"name"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"cityList":@"WFHomeCityEntityListModel"};
}

@end

@implementation WFHomeCityEntityListModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"areaList":@"WFHomeAreaEntityListModel"};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Name":@"name"};
}

@end

@implementation WFHomeAreaEntityListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Name":@"name"};
}

@end
