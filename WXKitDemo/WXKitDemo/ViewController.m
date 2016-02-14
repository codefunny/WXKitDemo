//
//  ViewController.m
//  WXKitDemo
//
//  Created by wenchao on 16/2/14.
//  Copyright © 2016年 wenchao. All rights reserved.
//

#import "ViewController.h"
#import "WXLoadingView.h"

@interface ViewController () {
    WXLoadingView *_loadingView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button1 = ({
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(10, 30, 80, 40);
        [btn setTitle:@"loading" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onLoadClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 101;
        btn ;
    });
    [self.view addSubview:button1];
    
    UIButton *button2 = ({
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(100, 30, 80, 40);
        [btn setTitle:@"dash" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onLoadClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 102;
        btn ;
    });
    [self.view addSubview:button2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onLoadClick:(UIButton *)sender {
    _loadingView = [WXLoadingView new];
    _loadingView.message = @"正在加载";
    
    if (sender.tag == 102) {
        _loadingView.loadingType = WXLoadingTypeDashPattern;
        _loadingView.loadingColor = [UIColor orangeColor];
    }
    
    [_loadingView show];
    
    [_loadingView performSelector:@selector(hide) withObject:nil afterDelay:5.];
}

@end
