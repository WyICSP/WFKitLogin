//
//  WFStartUpViewController.m
//  WFKitMain_Example
//
//  Created by 王宇 on 2019/4/16.
//  Copyright © 2019 wyxlh. All rights reserved.
//
#define WFImageCount 3

#import "WFStartUpViewController.h"

#import "WKHelp.h"

@interface WFStartUpViewController ()<UIScrollViewDelegate>
@property(nonatomic, weak)UIScrollView *scrollView;
@property(nonatomic, weak)UIPageControl *pageControll;
@end

@implementation WFStartUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 初始化scrollView
    [self setupScrollView];
    
    // 初始化UIPageControl
    [self setupPageControl];
}

// 初始化ScrollView
- (void)setupScrollView
{
    UIScrollView *scroView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scroView.contentSize = CGSizeMake(WFImageCount*self.view.frame.size.width, 0);
    scroView.pagingEnabled = YES;
    scroView.showsHorizontalScrollIndicator = NO;
    scroView.delegate = self;
    scroView.bounces = NO;
    [self.view addSubview:scroView];
    self.scrollView = scroView;
    
    for (int i = 0 ; i< WFImageCount; i ++) {
        NSString *name;
        if (ISIPHONEX) {
            name = [NSString stringWithFormat:@"beginX%d",i+1];
        }else{
            name = [NSString stringWithFormat:@"begin%d",i+1];
        }
        UIImage *image = [UIImage imageNamed:name];
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*i, 0, self.view.frame.size.width, self.view.frame.size.height)];
        imageview.image = image;
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        [scroView addSubview:imageview];
        imageview.userInteractionEnabled = YES;
        if (i == WFImageCount-1) {
            [imageview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeControll)]];
            UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn2 setImage:[UIImage imageNamed:@"experienceLogo"] forState:0];
            CGFloat btn2W = 0;
            CGFloat btn2H = 0;
            CGFloat btn2Y = self.view.frame.size.height;
            CGFloat btn2X = self.view.frame.size.width;
            [btn2 setTitle:@"立即体验" forState:UIControlStateNormal];
            btn2.frame = CGRectMake(btn2X, btn2Y, btn2W, btn2H);
            [btn2 addTarget:self action:@selector(changeControll) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:btn2];
        }
    }
}

// 初始化pageController
- (void)setupPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 20);
    pageControl.numberOfPages = WFImageCount;
    pageControl.currentPageIndicatorTintColor = NavColor;
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self.view addSubview:pageControl];
    self.pageControll = pageControl;
}


#pragma mark - UIScrollViewDelegate代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControll.currentPage = (scrollView.contentOffset.x+self.view.frame.size.width/2)/self.view.frame.size.width;
}

- (void)changeControll
{
    
    //如果没有登录
//    [self setRootViewController];
}



@end
