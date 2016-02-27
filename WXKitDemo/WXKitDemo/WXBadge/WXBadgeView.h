//
//  WXBadgeView.h
//  WXKitDemo
//
//  Created by wenchao on 16/2/15.
//  Copyright © 2016年 wenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WXBadgeStyle) {
    WXBadgeStyleNone = 0 ,
    WXBadgeStyleRedDot,
    WXBadgeStyleNumber,
    WXBadgeStyleNew
};

@interface WXBadgeView : UIView

@property (nonatomic, strong) UIFont  *badgeFont;
@property (nonatomic, strong) UIColor *badgeBgColor;
@property (nonatomic, strong) UIColor *badgeTextColor;

- (void)showBadge;

- (void)showBadgeWithStyle:(WXBadgeStyle)style value:(NSInteger)value;

- (void)hideBadge;

@end
