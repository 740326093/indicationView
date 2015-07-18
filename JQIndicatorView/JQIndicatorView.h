//
//  JQIndicatorView.h
//  JQIndicatorViewDemo
//
//  Created by James on 15/7/18.
//  Copyright (c) 2015年 JQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,JQIndicatorType){
    JQIndicatorTypeMusicBar,
    JQIndicatorTypeCyclingDot
};

@interface JQIndicatorView : UIView

- (instancetype)initWithType:(JQIndicatorType)type;
- (instancetype)initWithType:(JQIndicatorType)type TintColor:(UIColor *)tintColor;
- (instancetype)initWithType:(JQIndicatorType)type TintColor:(UIColor *)tintColor Size:(CGSize)size;

@property (nonatomic, assign) BOOL isAnimating;

- (void)startAnimating;
- (void)stopAnimating;

@end
