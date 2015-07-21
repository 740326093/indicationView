//
//  JQCyclingCycleAnimation.m
//  JQIndicatorViewDemo
//
//  Created by James on 15/7/21.
//  Copyright (c) 2015年 JQ. All rights reserved.
//

#import "JQCyclingCycleAnimation.h"

@implementation JQCyclingCycleAnimation

- (void)configAnimationAtLayer:(CALayer *)layer withTintColor:(UIColor *)color size:(CGSize)size{
    CAShapeLayer *cycleAnimationLayer = [CAShapeLayer layer];
    
    cycleAnimationLayer.frame = CGRectMake(0, 0, size.width, size.height);
    cycleAnimationLayer.position = CGPointMake(0, 0);
    cycleAnimationLayer.strokeColor = color.CGColor;
    cycleAnimationLayer.fillColor = [UIColor clearColor].CGColor;
    cycleAnimationLayer.lineWidth = 2.f;
    
    CGFloat radius = MIN(size.width/2, size.height/2);
    CGPoint center = CGPointMake(radius, radius);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:-(M_PI_2)
                                                      endAngle:(5*M_PI_4)
                                                     clockwise:YES];
    cycleAnimationLayer.path = path.CGPath;
    
    [layer addSublayer:cycleAnimationLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 1.f;
    animation.repeatCount = CGFLOAT_MAX;
    animation.fromValue = @0;
    animation.toValue = @(2*M_PI);
    [cycleAnimationLayer addAnimation:animation forKey:nil];
    
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    
}

@end
