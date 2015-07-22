//
//  JQIndicatorView.m
//  JQIndicatorViewDemo
//
//  Created by James on 15/7/21.
//  Copyright (c) 2015年 JQ. All rights reserved.
//

#import "JQIndicatorView.h"
#import "JQIndicatorAnimationProtocol.h"
#import "JQMusic1Animation.h"
#import "JQMusic2Animation.h"
#import "JQCyclingSpotAnimation.h"
#import "JQCyclingLineAnimation.h"
#import "JQCyclingCycleAnimation.h"

#define JQIndicatorDefaultTintColor [UIColor colorWithRed:0.049 green:0.849 blue:1.000 alpha:1.000]
#define JQIndicatorDefaultSize CGSizeMake(60,60)

@interface JQIndicatorView ()

@property BOOL continueAnimating;
@property id<JQIndicatorAnimationProtocol> animation;

@end

@implementation JQIndicatorView

- (instancetype)initWithType:(JQIndicatorType)type{
    return [self initWithType:type tintColor:JQIndicatorDefaultTintColor];
}

- (instancetype)initWithType:(JQIndicatorType)type tintColor:(UIColor *)color{
    return [self initWithType:type tintColor:color size:JQIndicatorDefaultSize];
}

- (instancetype)initWithType:(JQIndicatorType)type tintColor:(UIColor *)color size:(CGSize)size{
    if (self = [super init]) {
        self.type = type;
        self.loadingTintColor = color;
        self.size = size;
    }
    
    return self;
}

#pragma mark - Animation

- (void)startAnimating{
    if (self.isAnimating == NO) {
        self.layer.sublayers = nil;
        [self setToNormalState];
        self.animation = [self animationForIndicatorType:self.type];
        if ([self.animation respondsToSelector:@selector(configAnimationAtLayer:withTintColor:size:)]) {
            
            [self.animation configAnimationAtLayer:self.layer withTintColor:self.loadingTintColor size:self.size];
        }
        self.isAnimating = YES;
    }
}

- (void)stopAnimating{
    if (self.isAnimating == YES) {
//        [self fadeOutWithAnimation:YES];
        if ([self.animation respondsToSelector:@selector(removeAnimation)]) {
            [self.animation removeAnimation];
            self.isAnimating = NO;
            self.animation = nil;
        }
        
    }
}

- (id<JQIndicatorAnimationProtocol>)animationForIndicatorType:(JQIndicatorType)type{
    switch (type) {
        case JQIndicatorTypeMusic1:
            return [[JQMusic1Animation alloc] init];
        case JQIndicatorTypeMusic2:
            return [[JQMusic2Animation alloc] init];
        case JQIndicatorTypeCyclingSpot:
            return [[JQCyclingSpotAnimation alloc] init];
        case JQIndicatorTypeCyclingLine:
            return [[JQCyclingLineAnimation alloc] init];
        case JQIndicatorTypeCyclingCycle:
            return [[JQCyclingCycleAnimation alloc] init];
        default:
            break;
    }
}

#pragma mark - Indicator animation methods

- (void)setToNormalState{
    self.layer.backgroundColor = [UIColor grayColor].CGColor;
    self.layer.speed = 1.0f;
    self.layer.opacity = 1.0;
}

- (void)setToFadeOutState{
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
    self.layer.sublayers = nil;
    self.layer.opacity = 0.f;
}

- (void)fadeOutWithAnimation:(BOOL)animated{
    if (animated) {
        CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeAnimation.delegate = self;
        fadeAnimation.beginTime = CACurrentMediaTime();
        fadeAnimation.duration = 0.35;
        fadeAnimation.toValue = @(0);
        [self.layer addAnimation:fadeAnimation forKey:@"fadeOut"];
    }
}

#pragma mark - CAAnimation delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self setToFadeOutState];
}



@end
