//
//  ViewController.m
//  WXKitDemo
//
//  Created by wenchao on 16/2/14.
//  Copyright © 2016年 wenchao. All rights reserved.
//

#import "ViewController.h"
#import "WXLoadingView.h"
#import "WXToastView.h"

#import "UIView+WXBadge.h"

@interface ViewController () {
    WXLoadingView *_loadingView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor cyanColor];
    UIButton *button1 = ({
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(10, 30, 50, 40);
        [btn setTitle:@"loading" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onLoadClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 101;
        btn ;
    });
    [self.view addSubview:button1];
    
    UIButton *button2 = ({
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(60, 30, 50, 40);
        [btn setTitle:@"dash" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onLoadClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 102;
        btn ;
    });
    [self.view addSubview:button2];
    
    UIButton *button3 = ({
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(180, 30, 80, 40);
        [btn setTitle:@"activity" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onLoadClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 103;
        btn ;
    });
    [self.view addSubview:button3];
    
    UIButton *button4 = ({
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(260, 30, 80, 40);
        [btn setTitle:@"acti1" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onLoadClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 104;
        btn ;
    });
    [self.view addSubview:button4];
    
    
    
    UIButton *button5 = ({
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(10, 80, 80, 40);
        [btn setTitle:@"toasttop" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onToastClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 105;
        btn ;
    });
    [self.view addSubview:button5];
    
    UIButton *button6 = ({
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(100, 80, 80, 40);
        [btn setTitle:@"toastmid" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onToastClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 106;
        btn ;
    });
    [self.view addSubview:button6];
    
    UIButton *button7 = ({
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(180, 80, 80, 40);
        [btn setTitle:@"toastbot" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onToastClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 107;
        btn ;
    });
    [self.view addSubview:button7];
    
    UIButton *button8 = ({
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(10, 200, 50, 40);
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btn setTitle:@"badge" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor blueColor]];
        [btn addTarget:self action:@selector(onBadgeClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 108;
        btn ;
    });
    [self.view addSubview:button8];
    [button8 showBadge];
    
    UIButton *button9 = ({
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(100, 200, 50, 40);
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btn setTitle:@"badge" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor blueColor]];
        [btn addTarget:self action:@selector(onBadgeClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 109;
        btn ;
    });
    [self.view addSubview:button9];
    [button9 showBadgeWithStyle:WXBadgeStyleNew value:0];
    
    UIButton *button10 = ({
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(190, 200, 50, 40);
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btn setTitle:@"badge" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor blueColor]];
        [btn addTarget:self action:@selector(onBadgeClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 110;
        btn ;
    });
    [self.view addSubview:button10];
    [button10 showBadgeWithStyle:WXBadgeStyleNumber value:90];
    
    UIButton *button11 = ({
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(280, 200, 50, 40);
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btn setTitle:@"badge" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor blueColor]];
        [btn addTarget:self action:@selector(onBadgeClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 111;
        btn ;
    });
    [self.view addSubview:button11];
    [button11 showBadgeWithStyle:WXBadgeStyleNumber value:190];
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
    } else if (sender.tag == 103) {
        _loadingView.loadingType = WXLoadingTypeActivity;
    }
    
    [_loadingView show];
    
    [_loadingView performSelector:@selector(hide) withObject:nil afterDelay:5.];
}

- (void)onToastClick:(UIButton *)sender {
    if (sender.tag == 107) {
        [WXToastView toastWithMessage:@"广州市天河区"];
        
    } else if (sender.tag == 105) {
        [WXToastView toastWithMessage:@"今天是传说中的情人节" position:WXToastPositionTop];
    } else {
    [WXToastView toastWithMessage:@"today is 2016/2/14,\nhehehehhehhehehehehehehehehehehehehehehhehehehehe" position:WXToastPositionMiddle];
    }
}

- (void)onBadgeClick:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        [sender hideBadge];
    } else {
        switch (sender.tag) {
            case 108:
                [sender showBadge];
                break;
            case 109:
                [sender showBadgeWithStyle:WXBadgeStyleNew value:0];
                break;
            case 110:
                [sender showBadgeWithStyle:WXBadgeStyleNumber value:90];
                break;
            case 111:
                [sender showBadgeWithStyle:WXBadgeStyleNumber value:190];
                break;
            default:
                break;
        }
        
    }
    
}

@end
