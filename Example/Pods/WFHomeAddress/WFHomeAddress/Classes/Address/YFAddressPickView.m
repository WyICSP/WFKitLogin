//
//  YFAddressPickView.m
//  YFKit
//
//  Created by 王宇 on 2018/5/8.
//  Copyright © 2018年 wy. All rights reserved.
//
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define windowColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]
#define navigationViewHeight 45.0f
#define pickViewViewHeight 213.0f

#import "YFAddressPickView.h"
#import "WFApplyAddressModel.h"
#import <MJExtension/MJExtension.h>

@interface YFAddressPickView ()
{
    NSString *provinceString,*cityString,*areaString,*provinceId,*cityId,*areaId;
}
/**地址*/
@property (nonatomic, strong, nullable) NSArray <WFApplyAddressModel *> *provinceModels;
@property(nonatomic,strong)NSMutableArray *DataArray;
@property(nonatomic,strong)NSDictionary   *AllCityDict;
@property(nonatomic,strong)NSMutableArray *provinceArray;
@property(nonatomic,strong)NSArray *cityArray;
@property(nonatomic,strong)NSArray *townArray;
@property(nonatomic,strong)UIView *bottomView;//包括导航视图和地址选择视图
@property(nonatomic,strong)UIPickerView *pickView;//地址选择视图
@property(nonatomic,strong)UIView *navigationView;//上面的导航视图

@end

@implementation YFAddressPickView
YFAddressPickView *shareInstance;

+ (instancetype)shareInstance
{
    //static AddressPickView *shareInstance = nil;
    //static dispatch_once_t onceToken;
    // dispatch_once(&onceToken, ^{
    //    if (!shareInstance) {
    shareInstance = [[YFAddressPickView alloc] init];
    //    }
    // });
    
    [shareInstance showBottomView];
    return shareInstance;
}

+ (void)resetPicker
{
    shareInstance = nil;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        [self addTapGestureRecognizerToSelf];
        [self createView];
    }
    return self;
    
}

#pragma mark - get data
- (void)getPickerDataWithProvince:(NSArray *)ProvinceArr CityArr:(NSDictionary *)CityArr ProvinceId:(NSString *)province CityId:(NSString *)city DistrictId:(NSString *)district
{
    
}

- (void)setAddressDatas:(NSArray *)addressDatas {
    //省的
    self.provinceModels = [WFApplyAddressModel mj_objectArrayWithKeyValuesArray:addressDatas];
    WFApplyAddressModel *pModel = [self.provinceModels firstObject];
    provinceId = pModel.provinceid;
    provinceString = pModel.province;
    //市
    self.cityArray = pModel.cityEntityList;
    WFHomeCityEntityListModel *cModel = [self.cityArray firstObject];
    cityId = cModel.cityid;
    cityString = cModel.city;
    //区
    self.townArray = cModel.areaEntityList;
    WFHomeAreaEntityListModel *aModel = [self.townArray firstObject];
    areaId = aModel.areaid;
    areaString = aModel.area;
    
    [_pickView reloadComponent:0];
    [_pickView selectRow:0 inComponent:0 animated:YES];
    [_pickView selectRow:0 inComponent:1 animated:YES];
    [_pickView selectRow:0 inComponent:2 animated:YES];
    
}

-(void)addTapGestureRecognizerToSelf
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenBottomView)];
    [self addGestureRecognizer:tap];
}
-(void)createView
{
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, navigationViewHeight+pickViewViewHeight)];
    [self addSubview:_bottomView];
    //导航视图
    _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, navigationViewHeight)];
    _navigationView.backgroundColor = [UIColor whiteColor];
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, navigationViewHeight-0.5, kScreenWidth, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1];
    [_navigationView addSubview:line];
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 0, 80, navigationViewHeight);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn setTitleColor:[UIColor colorWithWhite:0.267 alpha:1.000] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(hiddenBottomView) forControlEvents:UIControlEventTouchUpInside];
    [_navigationView addSubview:cancelBtn];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(kScreenWidth - 80, 0, 80, navigationViewHeight);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sureBtn setTitleColor:[UIColor colorWithRed:247.0/255.0 green:133.0/255.0 blue:86.0/255.0 alpha:1] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    [_navigationView addSubview:sureBtn];
    
    
    [_bottomView addSubview:_navigationView];
    //这里添加空手势不然点击navigationView也会隐藏,
    UITapGestureRecognizer *tapNavigationView = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
    [_navigationView addGestureRecognizer:tapNavigationView];
    
    _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_navigationView.frame), kScreenWidth, pickViewViewHeight)];
    _pickView.backgroundColor = [UIColor whiteColor];
    _pickView.dataSource = self;
    _pickView.delegate =self;
    
    [_bottomView addSubview:_pickView];
    
}
#pragma mark - 确定按钮点击
-(void)tapButton:(UIButton*)button
{
    //点击确定回调block
    //    if (self.DataArray) {
    //        _block(provinceString,cityString,areaString,provinceId,cityId,areaId);
    //    }
    
    NSString *address = [NSString stringWithFormat:@"%@/%@/%@",provinceString,cityString,areaString];
    !self.startPlaceBlock ? : self.startPlaceBlock (address);
    [self hiddenBottomView];
}
-(void)showBottomView
{
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomView.frame = CGRectMake(0, kScreenHeight-navigationViewHeight-pickViewViewHeight, kScreenWidth, navigationViewHeight+pickViewViewHeight);
        self.backgroundColor = windowColor;
    } completion:^(BOOL finished) {
        
    }];
    
}
-(void)hiddenBottomView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, navigationViewHeight+pickViewViewHeight);
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}

#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceModels.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return self.townArray.count;
    }
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *lable=[[UILabel alloc]init];
    lable.textAlignment=NSTextAlignmentCenter;
    lable.numberOfLines = 2;
    lable.font=[UIFont systemFontOfSize:14.0f];
    if (component == 0) {
        lable.text = [[self.provinceModels objectAtIndex:row] province];
    } else if (component == 1) {
        //加保险,防止数组越界
        lable.text = [[self.cityArray objectAtIndex:row] city];
    } else {
        //加保险,防止数组越界
        lable.text = [[self.townArray objectAtIndex:row] area];
    }
    return lable;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    //这里减五 是为了伟大的"甘肃省临夏回族自治州积石山保安族东乡族撒拉族自治县"等名字长的地方(郭长峰)
    CGFloat pickViewWidth = kScreenWidth/3-5;
    
    return pickViewWidth;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 35;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        
        //得到城市数据
        WFApplyAddressModel *pModel = self.provinceModels[row];
        self.cityArray = pModel.cityEntityList;
        //省名
        provinceString = pModel.province;
        
        //得到区的数据
        WFHomeCityEntityListModel *cModel = [self.cityArray firstObject];
        self.townArray = cModel.areaEntityList;
        //市名
        cityString = cModel.city;
        
        //区名
        WFHomeAreaEntityListModel *aModel = [self.townArray firstObject];
        areaString = aModel.area;
        
        
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    
    if (component == 1) {
        //得到区的数据逻辑
        WFHomeCityEntityListModel *cModel = [self.cityArray objectAtIndex:row];
        self.townArray = cModel.areaEntityList;
        cityString = cModel.city;
        
        WFHomeAreaEntityListModel *aModel = [self.townArray firstObject];
        //区名
        areaString = aModel.area;
        
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }else if (component == 2) {
        WFHomeAreaEntityListModel *aModel = [self.townArray objectAtIndex:row];
        areaString = aModel.area;
    }
    
}


@end
