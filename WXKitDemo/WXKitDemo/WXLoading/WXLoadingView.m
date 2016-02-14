//
//  WXLoadingView.m
//  WXKitDemo
//
//  Created by wenchao on 16/2/14.
//  Copyright © 2016年 wenchao. All rights reserved.
//

#import "WXLoadingView.h"

static CGFloat const kShapeLayerLineWidth = 2.5;
static CGFloat const kShapeLayerMarginTop = 10.;
static CGFloat const kMessageLabelHeight = 30.;

static NSTimeInterval const kAnimationDurationTime = 1.;
static NSString* const kAnimationKey = @"loadingAnimation";

@interface WXLoadingView (){
    BOOL _isShowing;
}


@property (nonatomic,strong) UIView     *backgroundView;
@property (nonatomic,strong) UILabel    *messageLabel;

@property (nonatomic,strong) CAShapeLayer   *backLayer;
@property (nonatomic,strong) CAShapeLayer   *loadingLayer;

@property (nonatomic,strong) UIActivityIndicatorView *activity;

@end

@implementation WXLoadingView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUp];
    }
    
    return self;
}

- (void)setUp {
    _isShowing = NO;
    self.loadingType = WXLoadingTypeDefault;
    self.backViewColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.8];
    self.loadingColor = [UIColor redColor];
    [self addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.messageLabel];
}

- (void)loadShapeLayer:(UIView *)view {
    [view.layer addSublayer:self.backLayer];
    [view.layer addSublayer:self.loadingLayer];
}

- (void)startAnimate {
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @(-1);
    strokeStartAnimation.toValue = @(1);
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(0);
    strokeEndAnimation.toValue = @(1);
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[strokeStartAnimation,strokeEndAnimation];
    groupAnimation.duration = kAnimationDurationTime;
    groupAnimation.repeatCount = HUGE;
    groupAnimation.fillMode = kCAFillModeForwards;
    groupAnimation.removedOnCompletion = NO;
    
    [self.loadingLayer addAnimation:groupAnimation forKey:kAnimationKey];
}

- (void)stopAnimation {
    [self.loadingLayer removeAnimationForKey:kAnimationKey];
}

- (void)show {
    if (_isShowing) {
        return;
    }
    
    _isShowing = YES;
    if (self.loadingType == WXLoadingTypeDefault) {
        [self loadShapeLayer:self.backgroundView];
        self.loadingLayer.strokeColor = self.loadingColor.CGColor;
    } else if (self.loadingType == WXLoadingTypeDashPattern) {
        [self loadShapeLayer:self.backgroundView];
        self.loadingLayer.lineDashPattern = @[@5,@5];
        self.loadingLayer.strokeColor = self.loadingColor.CGColor;
    } else if (self.loadingType == WXLoadingTypeActivity){
        [self.backgroundView addSubview:self.activity];
        self.activity.color = self.loadingColor;
    }
    
    if (self.message) {
        self.messageLabel.text = self.message ;
    }
    
    self.backgroundView.backgroundColor = self.backViewColor;
    
    [self updateCustomConstraints];
    [self addToWindow];
    
    if (self.loadingType == WXLoadingTypeDefault || self.loadingType == WXLoadingTypeDashPattern) {
        [self updateLayerPathInView:self.backgroundView];
        [self startAnimate];
    } else if (self.loadingType == WXLoadingTypeActivity) {
        CGFloat cricleHeiht = self.backgroundView.bounds.size.height - kMessageLabelHeight - kShapeLayerMarginTop;
        CGFloat cricleX = (self.backgroundView.bounds.size.width - cricleHeiht)/2.;
        CGRect cricleRect = CGRectMake(cricleX, kShapeLayerMarginTop, cricleHeiht, cricleHeiht);
        self.activity.frame = cricleRect;
        [self.activity startAnimating];
    }
}

- (void)hide {
    if (!_isShowing) {
        return;
    }
    
    [self removeFromSuperview];
    _isShowing = NO;
}

- (void)updateCustomConstraints {
    
    [self.backgroundView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1. constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1. constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.25 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.backgroundView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    
    UIView *otherItem = self.backgroundView;
    [self.messageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.messageLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:otherItem attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.messageLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:otherItem attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.messageLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:otherItem attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.messageLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:kMessageLabelHeight]];
}

- (void)addToWindow {
    [self.window addSubview:self];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self.window addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self.window addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self.window addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self.window addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
}

- (void)updateLayerPathInView:(UIView *)view {
    
    CGFloat cricleHeiht = self.backgroundView.bounds.size.height - kMessageLabelHeight - kShapeLayerMarginTop;
    CGFloat cricleX = (self.backgroundView.bounds.size.width - cricleHeiht)/2.;
    CGRect cricleRect = CGRectMake(cricleX, kShapeLayerMarginTop, cricleHeiht, cricleHeiht);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:cricleRect cornerRadius:cricleHeiht/2.];
    
    self.backLayer.path = self.loadingLayer.path = path.CGPath;
}

#pragma mark setter/getter
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        _backgroundView.layer.cornerRadius = 5.;
        _backgroundView.layer.masksToBounds = YES;
    }
    
    return _backgroundView;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        [_messageLabel sizeToFit];
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.font = [UIFont systemFontOfSize:14];
        _messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _messageLabel.textAlignment = NSTextAlignmentCenter ;
    }
    
    return _messageLabel;
}

- (CAShapeLayer *)backLayer {
    if (!_backLayer) {
        _backLayer = [CAShapeLayer layer];
        _backLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        _backLayer.fillColor = [UIColor clearColor].CGColor;
        _backLayer.lineWidth = kShapeLayerLineWidth;
    }
    
    return _backLayer;
}

- (CAShapeLayer *)loadingLayer {
    if (!_loadingLayer) {
        _loadingLayer = [CAShapeLayer layer];
        _loadingLayer.strokeColor = [UIColor redColor].CGColor;
        _loadingLayer.fillColor = [UIColor clearColor].CGColor;
        _loadingLayer.lineWidth = kShapeLayerLineWidth;
    }
    
    return _loadingLayer;
}

- (UIActivityIndicatorView *)activity {
    if (!_activity) {
        _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    
    return _activity;
}

#pragma mark -
- (UIWindow *)window {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    return window ;
}

@end
