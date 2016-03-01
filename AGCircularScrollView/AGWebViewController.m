//
//  AGWebViewController.m
//  AGCircularScrollView
//
//  Created by 吴书敏 on 16/2/29.
//  Copyright © 2016年 littledogboy. All rights reserved.
//

#import "AGWebViewController.h"
#import <WebKit/WebKit.h>

@interface AGWebViewController ()

@end

@implementation AGWebViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    // 1. 创建wkwebview
    WKWebView *webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 2. 进行网络请求
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    webView 
    // 3. 添加
    [self.view addSubview:webView];
    

    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
