//
//  ViewController.m
//  AGCircularScrollView
//
//  Created by 吴书敏 on 16/2/24.
//  Copyright © 2016年 littledogboy. All rights reserved.
//

#define kURL @"http://app.bilibili.com/x/banner?build=2530&channel=appstore&plat=2"

#import "ViewController.h"
#import "AGCircularScrollView.h"
#import "AFNetworking.h"
#import "BannerImage.h"
#import "AGWebViewController.h"

@interface ViewController () <BannerImageViewDelegate>

@property (nonatomic, strong) NSMutableArray *bannerImageArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    AGCircularScrollView *bannerView = [[AGCircularScrollView alloc] initWithFrame:(CGRectMake(0, 64, 375, 117))];
    bannerView.delegate = self;
    
    bannerView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:bannerView];
    
    // 请求成功后进行数据，返回数据为responseObject
    // 1UL << 0  0b0000 0001  无符号长整形 左移0位
    // 使用AFN 进行网络请求：
    // AFHTTPSessionManager 为AFSessionManager的子类 遵循了<NSSecureCoding, NSCopying> 协议
    // AFSession
    // 1. 创建一个sessionManager 类似：session
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 2. 设置manager数据解析对象
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 3. session 进行get请求，返回一个dataTask，里面已经写了resume
    [manager GET:kURL parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        // 1. 解析
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
        NSArray *data = dic[@"data"];
        
        NSLog(@"%@", data);
        
        self.bannerImageArray = [NSMutableArray arrayWithCapacity:5];
        
        for (NSDictionary *model in data) {
            BannerImage *bannerImage = [[BannerImage alloc] init];
            [bannerImage setValuesForKeysWithDictionary:model];
            [self.bannerImageArray addObject:bannerImage];
        }
        
        // 2. 给bannerView 赋值
        bannerView.bannerImageModel = self.bannerImageArray;
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
    }];

    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark-
#pragma mark 点击滚动图的时候，从当前页面进入到下一级页面。
// 思想： 因为滚动页面的链接不同，有webUrl 和 App内番剧。如果是webUrl则进入的下一个页面为WKWebView，如果为番剧，则进入番剧页面。
// 因此可以考虑给外界提供要从哪个界面进入下一级接口。把push操作封装进去。

// 思想2：代理设计模式
- (void)pushViewControllerWithBannerImage:(BannerImage *)bannerImage;
{
    // 1. 判断bannerImage的type
    switch (bannerImage.type) {
        case weblink:
        {
            AGWebViewController *webVC = [[AGWebViewController alloc] init];
            webVC.urlString = bannerImage.value;
            [self.navigationController pushViewController:webVC animated:YES];
        }
            break;
        
        case bangumi:
        {
            
        }
            break;
            
        default:
            break;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
