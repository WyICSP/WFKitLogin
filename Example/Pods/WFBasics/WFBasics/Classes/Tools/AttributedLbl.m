//
//  AttributedLbl.m
//  Demo
//
//  Created by 王宇 on 2017/4/25.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "AttributedLbl.h"

@implementation AttributedLbl

+(void)setRichText:(UILabel *)lable titleString:(NSString *)titleString textFont:(UIFont *)textFont fontRang:(NSRange)fontRang textColor:(UIColor *)textColor colorRang:(NSRange)range{
    
    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    [Attributed addAttribute:NSFontAttributeName value:textFont range:fontRang];
    
    [Attributed addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    
    [lable setAttributedText:Attributed];
    
}

+(void)setRichTwoText:(UILabel *)lable titleString:(NSString *)titleString textFirstFont:(UIFont *)textFirstFont fontFirstRang:(NSRange)fontFirstRang textFirstColor:(UIColor *)textFirstColor colorFirstRang:(NSRange)colorFirstRang textSecondFont:(UIFont *)textSecondFont fontSecondRang:(NSRange)fontSecondRang textSecondColor:(UIColor *)textSecondColor colorSecondRang:(NSRange)colorSecondRang{
    
    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    [Attributed addAttribute:NSFontAttributeName value:textFirstFont range:fontFirstRang];
    
    [Attributed addAttribute:NSFontAttributeName value:textSecondFont range:fontSecondRang];
    
    [Attributed addAttribute:NSForegroundColorAttributeName value:textFirstColor range:colorFirstRang];
    
    [Attributed addAttribute:NSForegroundColorAttributeName value:textSecondColor range:colorSecondRang];
    
    [lable setAttributedText:Attributed];
}

+(void)setRichTextTwoTypsFontAndColor:(UILabel *)lable titleString:(NSString *)titleString  textColor:(UIColor *)textColor colorRang:(NSRange)colorRang textFirstFont:(UIFont *)textFirstFont fontFirstRang:(NSRange)fontFirstRang  textSecondFont:(UIFont *)textSecondFont fontSecondRang:(NSRange)fontSecondRang{
    
    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    [Attributed addAttribute:NSFontAttributeName value:textFirstFont range:fontFirstRang];
    
    [Attributed addAttribute:NSFontAttributeName value:textSecondFont range:fontSecondRang];
    
    [Attributed addAttribute:NSForegroundColorAttributeName value:textColor range:colorRang];
    
    [lable setAttributedText:Attributed];
}



+(void)setRichTextOnlyColor:(UILabel *)lable titleString:(NSString *)titleString  textColor:(UIColor *)textColor colorRang:(NSRange)colorRang{
    
    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    [Attributed addAttribute:NSForegroundColorAttributeName value:textColor range:colorRang];
    
    [lable setAttributedText:Attributed];
}

+(void)setRichTextOnlyFont:(UILabel *)lable titleString:(NSString *)titleString  textFont:(UIFont *)textFont fontRang:(NSRange)fontRang{
    
    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    [Attributed addAttribute:NSFontAttributeName value:textFont range:fontRang];
    
    
    [lable setAttributedText:Attributed];
}

+ (void)setProductPriceWithLable:(UILabel *)lable titleString:(NSString *)titleString textSize:(CGFloat)textSize{
    //仿照淘宝的价格显示 不保留整数后面小数位
//    if ([titleString containsString:@".00"] && ![titleString containsString:@"x"]) {
//        //商品价格为整数//如:66.01
//        NSString *price = [NSString stringWithFormat:@"¥ %ld",(long)[titleString integerValue]];
//        NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:price];
//
//        [lable setAttributedText:Attributed];
//    }else if ([titleString containsString:@"."] && ![titleString containsString:@"x"]){
//        //商品价格有小数点//如:66.01
//        NSString *price = [NSString stringWithFormat:@"¥ %.2f",titleString.doubleValue];
//        NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:price];
//        [Attributed addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:textSize * 0.8] range:NSMakeRange(price.length-2, 2)];
//
//        [lable setAttributedText:Attributed];
//    }else if ([titleString containsString:@"x"] && [titleString containsString:@"."] && ![titleString containsString:@".00"]) {
//        //如:66.01x3
//        NSArray *arrays = [titleString componentsSeparatedByString:@"x"];
//        NSString *price = [NSString stringWithFormat:@"¥ %@",titleString];
//        NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:price];
//        [Attributed addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:textSize * 0.8] range:NSMakeRange([[arrays firstObject] length], 2)];
//        [lable setAttributedText:Attributed];
//    }else if ([titleString containsString:@"x"] && [titleString containsString:@".00"]) {
//        //如:66.00x3
//        NSArray *arrays = [titleString componentsSeparatedByString:@"x"];
//        NSString *price = [NSString stringWithFormat:@"¥ %ldx%@",[[arrays firstObject] integerValue],[arrays lastObject]];
//        NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:price];
//        [lable setAttributedText:Attributed];
//    }else {
//        //商品价格为整数
//        NSString *price = [NSString stringWithFormat:@"¥ %@",titleString];
//        NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:price];
//
//        [lable setAttributedText:Attributed];
//    }
    
    //保留整数后面的小数位
    if (![titleString containsString:@"x"]){
        //商品价格有小数点//如:66.01
        NSString *price = [NSString stringWithFormat:@"¥ %.2f",titleString.doubleValue];
        NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:price];
        [Attributed addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:textSize * 0.8] range:NSMakeRange(price.length-2, 2)];
        
        [lable setAttributedText:Attributed];
    }else if ([titleString containsString:@"x"]) {
        //如:66.01x3
        NSArray *arrays = [titleString componentsSeparatedByString:@"x"];
        NSString *price = [NSString stringWithFormat:@"¥ %.2fx%@",[[arrays firstObject] doubleValue],[arrays lastObject]];
        NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:price];
        if ([titleString containsString:@"."]) {
            [Attributed addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:textSize * 0.8] range:NSMakeRange([[arrays firstObject] length], 2)];
        }else {
            //如果是价格为整数, 那么需要加上.00 就多了3位 所以需要 [[arrays firstObject] length] + 3
            [Attributed addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:textSize * 0.8] range:NSMakeRange([[arrays firstObject] length] + 3, 2)];
        }
        
        [lable setAttributedText:Attributed];
    }
}

+(void)setRiChLineSpacing:(UILabel *)lable titleString:(NSString *)titleString textColor:(UIColor *)textColor colorRang:(NSRange)colorRang LineSpacing:(CGFloat )LineSpacing{
    
    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    [Attributed addAttribute:NSForegroundColorAttributeName value:textColor range:colorRang];
    
    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 行间距设置为4
    [paragraphStyle  setLineSpacing:5];
    
    [Attributed  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [titleString length])];
    //    设置之后 为了让位子居中显示
    [paragraphStyle setAlignment:NSTextAlignmentLeft];
    
    [lable setAttributedText:Attributed];
}

@end
