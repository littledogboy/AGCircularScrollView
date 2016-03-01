//
//  AGCircularScrollView.h
//  AGCircularScrollView
//
//  Created by 吴书敏 on 16/2/24.
//  Copyright © 2016年 littledogboy. All rights reserved.
//

// 此控件为轮播图，主要功能：
// 手动轮播、自动轮播
// 点击轮播图片，进入相应页面。
// 轮播的网络图片，从网络获取，使用AFNetWorking进行网络请求 和 SDWebImage 获取网络图片
#import <UIKit/UIKit.h>
#import "BannerImageView.h"

@interface AGCircularScrollView : UIView
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
}

// 图片网络链接数组
@property (nonatomic, copy) NSArray *bannerImageModel;

// 点击图片后要执行的Value

// 图片代理
@property (nonatomic, assign) id<BannerImageViewDelegate> delegate;




@end
