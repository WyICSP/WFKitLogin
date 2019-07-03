//
//  UITableView+YFExtension.h
//  YFBasicComponents_Example
//
//  Created by 王宇 on 2019/1/17.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFEmptyDataView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (YFNoDataView)
/**
 空页面
 */
@property (nonatomic, strong) YFEmptyDataView *emptyView;

/**
 空页面按钮点击事件
 */
@property (nonatomic, copy) void(^emptyBtnClickBlock)(void);

/**
 *  是否显示空白页面
 */
- (void)isShowEmptyView:(BOOL)isShow;

/**
 显示空页面
 @param imageName 图片名字
 @param text 文字
 @param buttonTitle 按钮文字
 */
- (void)showEmptyViewWithImageName:(NSString *)imageName
                        lblText:(NSString *)text
                    buttonTitle:(NSString *)buttonTitle;
/**
 添加空白页面
 */
- (void)addEmptyView;


@end

@interface UITableView (YFExtension)

/**
 刷新指定的某一行
 
 @param section 指定的一个区
 @param indexPath 指定的某一行
 */
- (void)refreshTableViewWithSection:(NSInteger )section indexPath:(NSInteger)indexPath;

/**
 刷新某一个区
 
 @param section 指定的某个区
 */
- (void)refreshTableViewWithSection:(NSInteger )section;

@end

NS_ASSUME_NONNULL_END
