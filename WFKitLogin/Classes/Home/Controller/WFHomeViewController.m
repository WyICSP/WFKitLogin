//
//  WFHomeViewController.m
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/8/7.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import "WFHomeViewController.h"
#import "WFHomeFirstItemCollectionViewCell.h"
#import "WFHomeSectionItemCollectionViewCell.h"
#import "YFMediatorManager+WFLogin.h"
#import "WFHomeDataTool.h"
#import "WFHomeDataModel.h"
#import "WKHelp.h"

@interface WFHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/**collectionView*/
@property (nonatomic, strong, nullable) UICollectionView *collectionView;
/**数据*/
@property (nonatomic, strong, nullable) WFHomeDataModel *models;
@end

@implementation WFHomeViewController

#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getHomeData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark 生命周期
- (void)getHomeData {
    @weakify(self)
    [WFHomeDataTool getHomeDataWithParams:@{} resultBlock:^(WFHomeDataModel * _Nonnull models) {
        @strongify(self)
        self.models = models;
        [self.collectionView reloadData];
    }];
}

#pragma mark UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return section == 0 ? 1 : self.models.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        WFHomeFirstItemCollectionViewCell *cell = [WFHomeFirstItemCollectionViewCell cellWithCollectionView:collectionView indexPath:indexPath];
        cell.model = self.models;
        return cell;
    }
    WFHomeSectionItemCollectionViewCell *cell = [WFHomeSectionItemCollectionViewCell cellWithCollectionView:collectionView indexPath:indexPath];
    cell.model = self.models.list[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? CGSizeMake(ScreenWidth, KHeight(335.0f)) : CGSizeMake((ScreenWidth-KWidth(22))/2, KHeight(95.0f));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return section == 0 ? UIEdgeInsetsZero : UIEdgeInsetsMake(0, KWidth(10.0f), 0, KWidth(10.0f));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return section == 1? KWidth(2.0f) : CGFLOAT_MIN;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return section == 1 ? KWidth(7.0f) : CGFLOAT_MIN;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        WFHomeDataListModel *itemModel = self.models.list[indexPath.row];
        if (itemModel.typeId == 1) {
            //我的充电桩
           [YFMediatorManager openMyChargePileCtrlWithController:self];
        }else if (itemModel.typeId == 2) {
            //我的收入
        }else if (itemModel.typeId == 3) {
            //我的钱包
        }else if (itemModel.typeId == 4) {
            //我的片区
            [YFMediatorManager openApplyAreaCtrlWithController:self];
        }else if (itemModel.typeId == 5) {
            //充电桩申请
        }else if (itemModel.typeId == 7) {
            //资料包
        }
    }
}

#pragma mark get set
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.alwaysBounceVertical = YES;
        if (@available(iOS 11.0, *))
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [_collectionView registerNib:[UINib nibWithNibName:@"WFHomeFirstItemCollectionViewCell" bundle:[NSBundle bundleForClass:[self class]]] forCellWithReuseIdentifier:@"WFHomeFirstItemCollectionViewCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"WFHomeSectionItemCollectionViewCell" bundle:[NSBundle bundleForClass:[self class]]] forCellWithReuseIdentifier:@"WFHomeSectionItemCollectionViewCell"];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

@end
