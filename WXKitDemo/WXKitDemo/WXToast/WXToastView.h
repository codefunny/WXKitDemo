//
//  WXToastView.h
//  WXKitDemo
//
//  Created by wenchao on 16/2/14.
//  Copyright © 2016年 wenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,WXToastPosition) {
    WXToastPositionTop = 0,
    WXToastPositionMiddle ,
    WXToastPositionBottom,  //default show
};

@interface WXToastView : UIView

+ (void)toastWithMessage:(NSString *)message ;
+ (void)toastWithMessage:(NSString *)message duration:(NSTimeInterval)duration;
+ (void)toastWithMessage:(NSString *)message position:(WXToastPosition)position;
+ (void)toastWithMessage:(NSString *)message position:(WXToastPosition)position duration:(NSTimeInterval)duration ;

@end
