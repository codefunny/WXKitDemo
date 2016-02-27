//
//  UIView+WXBadge.h
//  WXKitDemo
//
//  Created by wenchao on 16/2/15.
//  Copyright © 2016年 wenchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXBadgeView.h"

@interface UIView (WXBadge)

- (void)showBadge;

- (void)showBadgeWithStyle:(WXBadgeStyle)style value:(NSInteger)value;

- (void)hideBadge;

@end
