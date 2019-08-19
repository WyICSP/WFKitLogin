//
//  WFHomeSectionItemCollectionViewCell.m
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/8/7.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import "WFHomeSectionItemCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+Regular.h"
#import "WFHomeDataModel.h"

@implementation WFHomeSectionItemCollectionViewCell

static NSString *const cellId = @"WFHomeSectionItemCollectionViewCell";

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView
                             indexPath:(NSIndexPath *)indexPath {
    WFHomeSectionItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"WFHomeSectionItemCollectionViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.title.adjustsFontSizeToFitWidth = self.detailTitle.adjustsFontSizeToFitWidth = YES;
    // Initialization code
}

- (void)setModel:(WFHomeDataListModel *)model {
    //当前文件的 bundle
    NSBundle *currentBundler = [NSBundle bundleForClass:[self class]];
    //得到图片的路径
    NSString *imgPath = [NSString getImagePathWithCurrentBundler:currentBundler PhotoName:@"itemImgLogo" bundlerName:@"WFKitLogin.bundle"];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageWithContentsOfFile:imgPath]];
    
    self.title.text = model.title;
    self.detailTitle.text = model.detail;
}

@end
