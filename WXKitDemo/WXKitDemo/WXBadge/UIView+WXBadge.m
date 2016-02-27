//
//  UIView+WXBadge.m
//  WXKitDemo
//
//  Created by wenchao on 16/2/15.
//  Copyright © 2016年 wenchao. All rights reserved.
//

#import "UIView+WXBadge.h"
#import <objc/runtime.h>

static const char kBadgeKey ;

@implementation UIView (WXBadge)

- (void)showBadge {
    [self showBadgeWithStyle:WXBadgeStyleRedDot value:0];
}

- (void)showBadgeWithStyle:(WXBadgeStyle)style value:(NSInteger)value {
    WXBadgeView *badgeView = [WXBadgeView new];
    badgeView.center = CGPointMake(CGRectGetWidth(self.frame), 0);
    [badgeView showBadgeWithStyle:style value:value];
    [self addSubview:badgeView];
    [self setBadgeView:badgeView];
}

- (void)hideBadge {
    UIView *badge = [self badgeView];
    if (badge) {
        [badge removeFromSuperview];
    }
}

- (void)setBadgeView:(UIView *)badge {
    objc_setAssociatedObject(self, &kBadgeKey, badge, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)badgeView {
    return objc_getAssociatedObject(self, &kBadgeKey);
}

@end
