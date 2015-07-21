//
//  JQMusicAnimation.m
//  JQMusicAnimationDemo
//
//  Created by James on 15/7/18.
//  Copyright (c) 2015年 JQ. All rights reserved.
//

#import "JQMusicAnimation.h"

@implementation JQMusicAnimation

- (void)configAnimationAtLayer:(CALayer *)layer withTintColor:(UIColor *)color size:(CGSize)size{
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(0, 0, size.width, size.height);
    replicatorLayer.position = CGPointMake(0, 0);
    replicatorLayer.backgroundColor = [UIColor clearColor].CGColor;
    [layer addSublayer:replicatorLayer];
    
    [self addMusicBarAnimationLayerAtLayer:replicatorLayer withSize:size tintColor:color];
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceDelay = 0.2;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(size.width*3/10, 0.f, 0.f);
    replicatorLayer.masksToBounds = YES;
}

#pragma mark - Music Indicator animation


- (void)addMusicBarAnimationLayerAtLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)color{
    CGFloat width = size.width/5;
    CGFloat height = size.height;
    CALayer *bar = [CALayer layer];
    bar.bounds = CGRectMake(0, 0, width, height);
    bar.position = CGPointMake(size.width/2-width*3/2, size.height + 15);
    bar.cornerRadius = 2.0;
    bar.backgroundColor = color.CGColor;
    [layer addSublayer:bar];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.toValue = @(bar.position.y - bar.bounds.size.height/2);
    animation.duration = 0.4;
    animation.autoreverses = YES;
    animation.repeatCount = CGFLOAT_MAX;
    
    [bar addAnimation:animation forKey:nil];
}



@end
