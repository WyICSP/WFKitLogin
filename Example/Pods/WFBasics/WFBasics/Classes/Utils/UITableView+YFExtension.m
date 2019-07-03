//
//  UITableView+YFExtension.m
//  YFBasicComponents_Example
//
//  Created by 王宇 on 2019/1/17.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import "UITableView+YFExtension.h"
#import <objc/runtime.h>

@implementation UIScrollView (YFNoDataView)

- (void)isShowEmptyView:(BOOL)isShow {
    self.emptyView.hidden = !isShow;
}

- (void)showEmptyViewWithImageName:(NSString *)imageName
                        lblText:(NSString *)text
                    buttonTitle:(NSString *)buttonTitle {
    
    self.emptyView = [YFEmptyDataView loadEmptyView];
    self.emptyView.frame = self.bounds;
    self.emptyView.emptyLbl.text = text;
    [self.emptyView.emptyBtn setTitle:buttonTitle forState:0];
    self.emptyView.hidden = YES;
    __weak typeof(self) weakSelf = self;
    self.emptyView.clickEmptyBtnBlock = ^{
        !weakSelf.emptyBtnClickBlock ? : weakSelf.emptyBtnClickBlock();
    };
    [self addSubview:self.emptyView];
    [self bringSubviewToFront:self.emptyView];
    
}

- (void)addEmptyView {
    [self showEmptyViewWithImageName:@"empty" lblText:@"暂无数据" buttonTitle:@"点击重试"];
}

- (void)setEmptyView:(YFEmptyDataView * _Nonnull)emptyView {
    objc_setAssociatedObject(self, @selector(emptyView), emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YFEmptyDataView *)emptyView {
    return objc_getAssociatedObject(self, _cmd);;
}

- (void)setEmptyBtnClickBlock:(void (^)(void))emptyBtnClickBlock {
    return objc_setAssociatedObject(self, @selector(emptyBtnClickBlock), emptyBtnClickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(void))emptyBtnClickBlock {
    return objc_getAssociatedObject(self, _cmd);
}

@end

@implementation UITableView (YFExtension)

/**
 刷新指定的某一行
 
 @param section 指定的一个区
 @param indexPath 指定的某一行
 */
- (void)refreshTableViewWithSection:(NSInteger )section indexPath:(NSInteger)indexPath{
    NSIndexPath *indexPathA = [NSIndexPath indexPathForRow:indexPath inSection:section];
    [self reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathA,nil] withRowAnimation:UITableViewRowAnimationNone];
}

/**
 刷新某一个区
 
 @param section 指定的某个区
 */
- (void)refreshTableViewWithSection:(NSInteger )section{
    NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:section];
    [self reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
}

@end
