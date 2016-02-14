//
//  WXLoadingView.h
//  WXKitDemo
//
//  Created by wenchao on 16/2/14.
//  Copyright © 2016年 wenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,WXLoadingType) {
    WXLoadingTypeDefault = 0,
    WXLoadingTypeDashPattern,
};

@interface WXLoadingView : UIView

//loadingtype
@property (nonatomic,assign) WXLoadingType  loadingType;
//背景颜色
@property (nonatomic,strong) UIColor    *backViewColor;
//loading颜色
@property (nonatomic,strong) UIColor    *loadingColor;

@property (nonatomic,copy) NSString     *message;

- (void)show ;
- (void)hide ;

@end
