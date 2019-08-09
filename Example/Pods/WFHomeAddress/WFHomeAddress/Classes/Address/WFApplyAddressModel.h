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
@property (nonatomic, copy) NSString *provinceid;
/**省名*/
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *Id;
/**城市*/
@property (nonatomic, strong) NSArray *cityEntityList;
@end

@interface WFHomeCityEntityListModel : NSObject
/**城市Id*/
@property (nonatomic, copy) NSString *cityid;
/**城市名*/
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *provinceid;
/**地区*/
@property (nonatomic, strong) NSArray *areaEntityList;
@end


@interface WFHomeAreaEntityListModel : NSObject
@property (nonatomic, copy) NSString *cityid;
/**地区Id*/
@property (nonatomic, copy) NSString *areaid;
/**地区名*/
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *Id;
@end

NS_ASSUME_NONNULL_END
