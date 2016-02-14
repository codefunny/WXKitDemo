//
//  WXToastView.m
//  WXKitDemo
//
//  Created by wenchao on 16/2/14.
//  Copyright © 2016年 wenchao. All rights reserved.
//

#import "WXToastView.h"

#define kScreamWidth [UIScreen mainScreen].bounds.size.width
static CGFloat const kLabelMargin = 8.0;
static NSTimeInterval const kDefaultDuration = 0.5;
static CGFloat const kLabelFontSize = 13.;

@interface WXToastView () {
    BOOL _isShowing;
    CGSize _labelSize;
}

@property (strong, nonatomic) UILabel *titleLabel;

@property (nonatomic,assign) WXToastPosition    position;

@end

@implementation WXToastView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUp];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUp];
}

- (void)setUp {
    _isShowing = NO;
    _position = WXToastPositionBottom ;
    self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.85];
    self.layer.cornerRadius = 5;
    [self addSubview:self.titleLabel];
}

+ (void)toastWithMessage:(NSString *)message {
    [self toastWithMessage:message duration:kDefaultDuration];
}

+ (void)toastWithMessage:(NSString *)message duration:(NSTimeInterval)duration {
    [self toastWithMessage:message position:WXToastPositionBottom duration:duration];
}

+ (void)toastWithMessage:(NSString *)message position:(WXToastPosition)position {
    [self toastWithMessage:message position:position duration:kDefaultDuration];
}

+ (void)toastWithMessage:(NSString *)message position:(WXToastPosition)position duration:(NSTimeInterval)duration {
    WXToastView *toast = [WXToastView new];
    [toast setMessage:message];
    [toast showWithPosition:position];
    
    [toast performSelector:@selector(hide) withObject:nil afterDelay:duration];
}

- (void)setMessage:(NSString *)message{
    _titleLabel.text = message;
    
    _labelSize = [message boundingRectWithSize:CGSizeMake(kScreamWidth/2., HUGE_VAL) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:kLabelFontSize]} context:nil].size;
    
    CGRect rect = self.frame;
    rect.size.width = _labelSize.width+kLabelMargin;
    rect.size.height = _labelSize.height+kLabelMargin;
    self.frame = rect;
    
    _titleLabel.frame = CGRectMake(0, 0, _labelSize.width, _labelSize.height);
    _titleLabel.center = self.center;
}

- (void)showWithPosition:(WXToastPosition)position {
    if (_isShowing) {
        return ;
    }
    
    _isShowing = YES;
    self.position = position ;
    [self add2Window];
}

- (void)hide {
    if (!_isShowing) {
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        _isShowing = NO;
    }];
}

- (void)add2Window {
    [self.window addSubview:self];
    switch (self.position) {
        case WXToastPositionTop:{
            self.center = CGPointMake(self.window.center.x, 64);
        }
            break;
        case WXToastPositionMiddle:{
            self.center = self.window.center;
        }
            break;
        case WXToastPositionBottom: {
            self.center = CGPointMake(self.window.center.x, self.window.bounds.size.height - 44 - _labelSize.height);
        }
            break;
        default:
            break;
    }
}

#pragma mark setter/getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:kLabelFontSize];
        _titleLabel.textAlignment = NSTextAlignmentCenter ;
        _titleLabel.numberOfLines = 0;
        _titleLabel.preferredMaxLayoutWidth = kScreamWidth/2. ;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping ;

    }
    
    return _titleLabel;
}

#pragma mark -
- (UIWindow *)window {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    return window ;
}

@end
