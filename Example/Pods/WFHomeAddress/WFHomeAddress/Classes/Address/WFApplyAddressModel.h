//
//  WFApplyAddressModel.h
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/8/8.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFApplyAddressModel : NSObject
/**省Id*/
@property (nonatomic, copy) NSString *provinceId;
/**省名*/
@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *code;
/**城市*/
@property (nonatomic, strong) NSArray *cityList;
@end

@interface WFHomeCityEntityListModel : NSObject
/**城市Id*/
@property (nonatomic, copy) NSString *cityId;
/**城市名*/
@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *parentId;
/**地区*/
@property (nonatomic, strong) NSArray *areaList;
@end


@interface WFHomeAreaEntityListModel : NSObject
@property (nonatomic, copy) NSString *parentId;
/**地区Id*/
@property (nonatomic, copy) NSString *areaId;
/**地区名*/
@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *code;
@end

NS_ASSUME_NONNULL_END
