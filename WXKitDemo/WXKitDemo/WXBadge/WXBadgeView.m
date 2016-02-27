//
//  WXBadgeView.m
//  WXKitDemo
//
//  Created by wenchao on 16/2/15.
//  Copyright © 2016年 wenchao. All rights reserved.
//

#import "WXBadgeView.h"

#define  kWXBadgeDefaultFont ([UIFont boldSystemFontOfSize:9])
static NSInteger const kWXBadgeMaximumBadgeNumber = 99;
static CGFloat const  kRedotDefaultWidth = 8;

@interface WXBadgeView ()

@property (nonatomic, strong) UILabel *badge;

@end

@implementation WXBadgeView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUp];
    }
    
    return self;
}

- (void)setUp {
    self.backgroundColor = [UIColor orangeColor];
    
    self.badgeBgColor = [UIColor redColor];
    self.badgeTextColor = [UIColor whiteColor];
    self.badgeFont = kWXBadgeDefaultFont;
    
    [self addSubview:self.badge];
}

- (void)showBadge {
    [self showBadgeWithStyle:WXBadgeStyleRedDot value:0];
}

- (void)showBadgeWithStyle:(WXBadgeStyle)style value:(NSInteger)value {
    
    self.badge.backgroundColor = self.badgeBgColor;
    self.badge.textColor = self.badgeTextColor;
    
    switch (style) {
        case WXBadgeStyleRedDot:
            [self showRedDotBadge];
            break;
        case WXBadgeStyleNumber:
            [self showNumberBadgeWithValue:value];
            break;
        case WXBadgeStyleNew:
            [self showNewBadge];
            break;
        default:
            break;
    }
}

- (void)hideBadge {
    self.badge.hidden = YES;
}

- (void)showRedDotBadge {

    if (self.badge.tag != WXBadgeStyleRedDot) {
        self.badge.text = @"";
        self.badge.tag = WXBadgeStyleRedDot;
        self.badge.center = CGPointMake(CGRectGetWidth(self.frame)/2., CGRectGetHeight(self.frame)/2.);
        self.badge.layer.cornerRadius = CGRectGetWidth(self.badge.frame) / 2;
    }
    self.badge.hidden = NO;
}

- (void)showNewBadge {

    if (self.badge.tag != WXBadgeStyleNew) {
        self.badge.text = @"new";
        self.badge.tag = WXBadgeStyleNew;
        self.badge.font = self.badgeFont;
        
        [self adjustLabelWidth:self.badge];
        CGRect frame = self.badge.frame;
        frame.size.width += 4;
        frame.size.height += 4;
        if(CGRectGetWidth(frame) < CGRectGetHeight(frame)) {
            frame.size.width = CGRectGetHeight(frame);
        }
        self.badge.frame = frame;
        self.badge.center = CGPointMake(CGRectGetWidth(self.frame)/2., CGRectGetHeight(self.frame)/2.);
        self.badge.layer.cornerRadius = CGRectGetHeight(self.badge.frame) / 3;
    }
    self.badge.hidden = NO;
}

- (void)showNumberBadgeWithValue:(NSInteger)value {
    if (value < 0) {
        return;
    }

    self.badge.hidden = (value == 0);
    self.badge.tag = WXBadgeStyleNumber;
    self.badge.font = self.badgeFont;
    self.badge.text = (value >= kWXBadgeMaximumBadgeNumber ?
                       [NSString stringWithFormat:@"%@+", @(kWXBadgeMaximumBadgeNumber)] :
                       [NSString stringWithFormat:@"%@", @(value)]);
    [self adjustLabelWidth:self.badge];
    CGRect frame = self.badge.frame;
    frame.size.width += 4;
    frame.size.height += 4;
    if(CGRectGetWidth(frame) < CGRectGetHeight(frame)) {
        frame.size.width = CGRectGetHeight(frame);
    }
    self.badge.frame = frame;
    self.badge.center = CGPointMake(CGRectGetWidth(self.frame)/2., CGRectGetHeight(self.frame)/2.);
    self.badge.layer.cornerRadius = CGRectGetHeight(self.badge.frame) / 2;
}

#pragma mark setter/getter

- (UILabel *)badge {
    if (!_badge) {
        CGRect frame = CGRectMake(0, 0, kRedotDefaultWidth, kRedotDefaultWidth);
        _badge = [[UILabel alloc] initWithFrame:frame];
        _badge.textAlignment = NSTextAlignmentCenter;
        _badge.text = @"";
        _badge.tag = WXBadgeStyleNone;
        _badge.layer.cornerRadius = CGRectGetWidth(_badge.frame) / 2;
        _badge.layer.masksToBounds = YES;
        _badge.hidden = NO;
    }
    
    return _badge;
}

#pragma mark --
- (void)adjustLabelWidth:(UILabel *)label {
    [label setNumberOfLines:0];
    NSString *s = label.text;
    UIFont *font = [label font];
    CGSize size = CGSizeMake(320,2000);
    CGSize labelsize;
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    
    labelsize = [s boundingRectWithSize:size
                                options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                             attributes:@{ NSFontAttributeName:font, NSParagraphStyleAttributeName : style}
                                context:nil].size;
    
    CGRect frame = label.frame;
    frame.size = CGSizeMake(ceilf(labelsize.width), ceilf(labelsize.height));
    [label setFrame:frame];
}

@end
