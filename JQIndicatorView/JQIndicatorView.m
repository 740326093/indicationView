//
//  JQIndicatorView.m
//  JQIndicatorViewDemo
//
//  Created by James on 15/7/18.
//  Copyright (c) 2015年 JQ. All rights reserved.
//

#import "JQIndicatorView.h"

#define JQIndicatorDefaultTintColor [UIColor colorWithRed:0.049 green:0.849 blue:1.000 alpha:1.000]
#define JQIndicatorDefaultSize CGSizeMake(60,60)

@interface JQIndicatorView ()

@property (nonatomic, assign) JQIndicatorType type;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, strong) UIColor *loadingTintColor;

@property (nonatomic, strong) CAReplicatorLayer *replicatorLayer;

@end

@implementation JQIndicatorView

#pragma mark - Setter & getter
- (CAReplicatorLayer *)replicatorLayer{
    if (_replicatorLayer == nil) {
        _replicatorLayer = [CAReplicatorLayer layer];
        _replicatorLayer.frame = CGRectMake(0, 0, self.size.width, self.size.height);
        _replicatorLayer.position = CGPointMake(0,0);
        _replicatorLayer.backgroundColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:_replicatorLayer];
        return _replicatorLayer;
    }
    return _replicatorLayer;
}

#pragma mark - Init methods
- (instancetype)initWithType:(JQIndicatorType)type{
    return [self initWithType:type TintColor:JQIndicatorDefaultTintColor];
}

- (instancetype)initWithType:(JQIndicatorType)type TintColor:(UIColor *)tintColor{
    return [self initWithType:type TintColor:tintColor Size:JQIndicatorDefaultSize];
}

- (instancetype)initWithType:(JQIndicatorType)type TintColor:(UIColor *)tintColor Size:(CGSize)size{
    if (self = [super init]) {
        self.type = type;
        self.loadingTintColor = tintColor;
        self.size = size;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - Indicator action methods

- (void)startAnimating{
    if (self.isAnimating == NO) {
        self.layer.sublayers = nil;
        self.layer.backgroundColor = [UIColor clearColor].CGColor;
        self.layer.speed = 0.f;
        [self setupAnimationForType:self.type];
        [self setToNormalState];
        self.isAnimating = YES;
    }
}

- (void)stopAnimating{
    if (self.isAnimating == YES) {
        [self fadeOutWithAnimation:YES];
        [self removeFromSuperview];
        self.isAnimating = NO;
    }
}

#pragma mark - Indicator animation methods
- (void)setupAnimationForType:(JQIndicatorType)type{
    if (type == JQIndicatorTypeMusicBar) {
        [self configMusicBarReplicatorLayer];
    }else if (type == JQIndicatorTypeCyclingDot){
        [self configCyclingDotReplicatorLayer];
    }
}

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
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.delegate = self;
    fadeAnimation.beginTime = CACurrentMediaTime();
    fadeAnimation.duration = 0.35;
    fadeAnimation.toValue = @(0);
    [self.layer addAnimation:fadeAnimation forKey:@"fadeOut"];
}

#pragma mark - CAAnimation delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self setToFadeOutState];
}

#pragma mark - Music Indicator animation

- (void)configMusicBarReplicatorLayer{
    [self addMusicBarAnimationLayerWithSize:self.size TintColor:self.loadingTintColor];
    self.replicatorLayer.instanceCount = 3;
    self.replicatorLayer.instanceDelay = 0.2;
    self.replicatorLayer.instanceTransform = CATransform3DMakeTranslation(self.size.width*3/10, 0.f, 0.f);
    self.replicatorLayer.masksToBounds = YES;
}

- (void)addMusicBarAnimationLayerWithSize:(CGSize)size TintColor:(UIColor *)color{
    CGFloat width = self.size.width/5;
    CGFloat height = self.size.height;
    CALayer *bar = [CALayer layer];
    bar.bounds = CGRectMake(0, 0, width, height);
    bar.position = CGPointMake(size.width/2-width*3/2, size.height + 15);
    bar.cornerRadius = 2.0;
    bar.backgroundColor = color.CGColor;
    [self.replicatorLayer addSublayer:bar];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.toValue = @(bar.position.y - bar.bounds.size.height/2);
    animation.duration = 0.4;
    animation.autoreverses = YES;
    animation.repeatCount = CGFLOAT_MAX;
    
    [bar addAnimation:animation forKey:nil];
}

#pragma mark - Cycling indicator animation

- (void)configCyclingDotReplicatorLayer{
    [self addCyclingDotAnimationLayerWithTintColor:self.loadingTintColor];
    NSInteger numOfDot = 15;
    self.replicatorLayer.instanceCount = numOfDot;
    CGFloat angle = (M_PI * 2)/numOfDot;
    self.replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    self.replicatorLayer.instanceDelay = 1.5/numOfDot;
}

- (void)addCyclingDotAnimationLayerWithTintColor:(UIColor *)color{
    CALayer *dot = [CALayer layer];
    dot.bounds = CGRectMake(0, 0, self.size.width/6, self.size.width/6);
    dot.position = CGPointMake(self.size.width/2, 5);
    dot.cornerRadius = dot.bounds.size.width/2;
    dot.backgroundColor = color.CGColor;
    dot.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
    
    [self.replicatorLayer addSublayer:dot];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @1;
    animation.toValue = @0.1;
    animation.duration = 1.5;
    animation.repeatCount = CGFLOAT_MAX;
    
    [dot addAnimation:animation forKey:nil];
}


@end
