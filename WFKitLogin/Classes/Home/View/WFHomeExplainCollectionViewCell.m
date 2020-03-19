//
//  WFHomeExplainCollectionViewCell.m
//  AFNetworking
//
//  Created by 王宇 on 2020/2/12.
//

#import "WFHomeExplainCollectionViewCell.h"
#import "WFHomeDataModel.h"
#import "WFHorseRaceLamp.h"
#import "WKHelp.h"

@interface WFHomeExplainCollectionViewCell()

@property (nonatomic, weak) WFHorseRaceLamp *marqueeControl;

@end

@implementation WFHomeExplainCollectionViewCell

static NSString *const cellId = @"WFHomeExplainCollectionViewCell";

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView
                             indexPath:(NSIndexPath *)indexPath {
    WFHomeExplainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"WFHomeExplainCollectionViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.explanLbl.adjustsFontSizeToFitWidth = YES;
}


#pragma mark - Getter Setter
- (void)setModel:(WFHomeDataModel *)model {
    self.marqueeControl.marqueeLabel.text = [NSString stringWithFormat:@"%@",model.advertisement];
}

- (WFHorseRaceLamp *)marqueeControl {
    if (!_marqueeControl) {
        WFHorseRaceLamp *control = [[WFHorseRaceLamp alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.img.frame) + 5.0f, 0, ScreenWidth-60.0f, KHeight(55.0f))];
        control.backgroundColor = [UIColor whiteColor];
        control.marqueeLabel.textColor = UIColorFromRGB(0x333333);
        control.marqueeLabel.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:control];
        
        _marqueeControl = control;
    }
    
    return _marqueeControl;
}

@end
