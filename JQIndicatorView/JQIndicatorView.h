//
//  JQIndicatorView.h
//  JQIndicatorViewDemo
//
//  Created by James on 15/7/21.
//  Copyright (c) 2015年 JQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JQIndicatorType){
    JQIndicatorTypeMusic,
    JQIndicatorTypeCyclingSpot,
    JQIndicatorTypeCyclingLine,
    JQIndicatorTypeCyclingCycle
};

@interface JQIndicatorView : UIView

- (instancetype)initWithType:(JQIndicatorType)type;
- (instancetype)initWithType:(JQIndicatorType)type tintColor:(UIColor *)color;
- (instancetype)initWithType:(JQIndicatorType)type tintColor:(UIColor *)color size:(CGSize)size;


- (void)startAnimating;
- (void)stopAnimating;

- (void)setToNormalState;
- (void)setToFadeOutState;
- (void)fadeOutWithAnimation:(BOOL)animated;


@property BOOL isAnimating;
@property JQIndicatorType type;
@property CGSize size;
@property UIColor *loadingTintColor;

@end
