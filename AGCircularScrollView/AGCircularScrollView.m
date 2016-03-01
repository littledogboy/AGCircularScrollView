//
//  AGCircularScrollView.m
//  AGCircularScrollView
//
//  Created by 吴书敏 on 16/2/24.
//  Copyright © 2016年 littledogboy. All rights reserved.
//

#define  kTotalWidth  self.frame.size.width
#define  kTotalHeight  self.frame.size.height


#import "AGCircularScrollView.h"
#import "BannerImage.h"
@interface AGCircularScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation AGCircularScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addScrollView];
    }
    
    return self;
}


#pragma mark-
#pragma mark 添加scrollView
- (void)addScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.backgroundColor = [UIColor yellowColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self; // 设置滚动代理
    [self addSubview:self.scrollView];
}

- (void)updateScrollView
{
    self.scrollView.contentSize = CGSizeMake(kTotalWidth * (self.bannerImageModel.count + 1), 44);
    self.scrollView.contentOffset = CGPointMake(kTotalWidth, 0); // 1x 偏移量
    
    // 给scrollView添加子视图
    // 循环滚动需要设置衔接图，第一张为最后一张，
    for (int i = 0; i < self.bannerImageModel.count + 1 ; i++) {
        
        // 第一张的图片为，数组中最后一张图片
        if (i == 0) {
            BannerImageView *bannerImageView = [[BannerImageView alloc] initWithFrame:CGRectMake(0, 0, kTotalWidth, kTotalHeight)];
            bannerImageView.delegate = self.delegate; // 添加代理
            bannerImageView.bannerImage = [self.bannerImageModel lastObject]; // 最后一个元素
            // target Action
            [self.scrollView addSubview:bannerImageView];
        } else {
            BannerImageView *bannerImageView = [[BannerImageView alloc] initWithFrame:CGRectMake(i * kTotalWidth, 0, kTotalWidth, kTotalHeight)];
            bannerImageView.delegate = self.delegate; // 添加代理
            bannerImageView.bannerImage = self.bannerImageModel[i - 1];
            // target action
            [self.scrollView addSubview:bannerImageView];
        }
    }
    
}

#pragma mark-
#pragma mark 添加pageControl
- (void)addPageControl
{
    CGFloat width = 13 * self.bannerImageModel.count;
    CGFloat height = 37;
    CGFloat pcX = self.frame.size.width - 20 - width;
    CGFloat pcY = self.frame.size.height  - height + 8;
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(pcX, pcY, width, height)];
    _pageControl.numberOfPages = self.bannerImageModel.count;
    _pageControl.pageIndicatorTintColor = [UIColor redColor];
    [self addSubview:_pageControl];
}


#pragma mark-
#pragma mark 重写model的set方法
// 当有model有数据了之后，根据数组长度添加scrollView子视图和添加pageControl
- (void)setBannerImageModel:(NSArray *)bannerImageModel
{
    _bannerImageModel = bannerImageModel;
    
    [self updateScrollView]; // 给scrollView添加子视图
    [self addPageControl]; // 添加pageControl
}


#pragma mark-
#pragma mark scrollViewDelegate

// 滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 当前偏移量
    CGFloat offSetX = scrollView.contentOffset.x;
    
    CGFloat maxOffSetX = scrollView.contentSize.width - kTotalWidth;
    CGFloat minOffSetX = 0;
    
    // 右循环滚动
    if (offSetX > maxOffSetX) {
        [scrollView setContentOffset:(CGPointMake(minOffSetX, 0)) animated:NO];
    } else if (offSetX < minOffSetX) { // 左循环滚动
        [scrollView setContentOffset:(CGPointMake(maxOffSetX, 0)) animated:NO];
    }
    
}

// 手动滚动停止，更改pageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 当前偏移量
    CGFloat offSetX = scrollView.contentOffset.x;
    
    NSInteger index = self.bannerImageModel.count;
    if (offSetX > 0) {
        index = offSetX / kTotalWidth - 1;
    }
    
    self.pageControl.currentPage = index;
}


#pragma mark-
#pragma mark 自动滚动

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
