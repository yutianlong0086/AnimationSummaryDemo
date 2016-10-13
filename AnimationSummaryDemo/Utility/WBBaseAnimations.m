//
//  WBBaseAnimations.m
//  Cosmetic
//
//  Created by 余天龙 on 16/9/30.
//  Copyright © 2016年 YuTianLong. All rights reserved.
//

#import "WBBaseAnimations.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#define Screen_Width        ([UIScreen mainScreen].bounds.size.width)
#define Screen_Height       ([UIScreen mainScreen].bounds.size.height)

#define kAnimType           (@"kAnimType")
#define kAnimationGroups    (@"kAnimationGroups")
#define kAnimationShake     (@"kAnimationShake")

static const NSTimeInterval kAnimationDuration = 1.2;

@interface WBBaseAnimations ()

@property (nonatomic, strong) CALayer *animationLayer;
@property (nonatomic, copy) void (^animationCompletedBlock)(BOOL finish);
@property (nonatomic, copy) void (^shakeCompletedBlock)(BOOL finish);

@end

@implementation WBBaseAnimations

+ (instancetype)sharedInstance {
    return [[WBBaseAnimations alloc] init];
}

#pragma mark - Public methods

- (void)starAnimationWithView:(UIView *)view
                     starRect:(CGRect)starRect
                  finishPoint:(CGPoint)finishPoint
               completedBlock:(void (^)(BOOL finish))completed {

    if (!completed) {
        return;
    }
    self.animationCompletedBlock = completed;

    // adjust
    starRect.size.width = starRect.size.width * 0.8;
    starRect.size.height = starRect.size.height * 0.8;
    
    // create animation layer.
    self.animationLayer = [CALayer layer];
    _animationLayer.contents = view.layer.contents;
    _animationLayer.contentsGravity = kCAGravityResizeAspectFill;
    _animationLayer.bounds = starRect;
    _animationLayer.masksToBounds = YES;
    _animationLayer.cornerRadius = starRect.size.width / 2.0;
    _animationLayer.position = CGPointMake(starRect.origin.x + view.frame.size.width / 2.0, CGRectGetMidY(starRect));
    
    // path point.
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:_animationLayer.position];
    [path addQuadCurveToPoint:finishPoint controlPoint:CGPointMake(Screen_Width / 2.0 + 80, starRect.origin.y + 20)];
    
    // 关键帧动画
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimation.path = path.CGPath;
    
    // 旋转动画
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.removedOnCompletion = YES;
    rotateAnimation.duration = kAnimationDuration;
    rotateAnimation.repeatCount = HUGE_VALF;
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:12];
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // 缩放动画
    CABasicAnimation *zoomAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    zoomAnimation.removedOnCompletion = YES;
    zoomAnimation.duration = kAnimationDuration;
    zoomAnimation.repeatCount = HUGE_VALF;
    zoomAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    zoomAnimation.toValue = [NSNumber numberWithFloat:0.3];
    zoomAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // 组合动画
    CAAnimationGroup *animationGroups = [CAAnimationGroup animation];
    animationGroups.animations = @[keyFrameAnimation, rotateAnimation, zoomAnimation];
    animationGroups.removedOnCompletion = NO;
    animationGroups.fillMode = kCAFillModeForwards;
    animationGroups.duration = kAnimationDuration;
    animationGroups.repeatCount = 1;
    animationGroups.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [animationGroups setValue:kAnimationGroups forKey:kAnimType];
    animationGroups.delegate = self;
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.window.layer addSublayer:_animationLayer];
    [_animationLayer addAnimation:animationGroups forKey:kAnimationGroups];
}

- (void)shakeAnimationWithView:(UIView *)view
                completedBlock:(void (^)(BOOL finish))completed {

    if (!completed) {
        return;
    }
    self.shakeCompletedBlock = completed;
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    moveAnimation.duration = 0.25f;
    moveAnimation.fromValue = [NSNumber numberWithFloat:-5];
    moveAnimation.toValue = [NSNumber numberWithFloat:5];
    moveAnimation.repeatCount = 2;
    moveAnimation.autoreverses = YES;
    [moveAnimation setValue:kAnimationShake forKey:kAnimType];
    moveAnimation.delegate = self;
    
    [view.layer addAnimation:moveAnimation forKey:kAnimationShake];
}

#pragma mark - CAAnimationDelegate methods

- (void)animationDidStart:(CAAnimation *)anim {
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if ([[anim valueForKey:kAnimType] isEqualToString:kAnimationGroups]) {
        [_animationLayer removeFromSuperlayer];
        _animationLayer = nil;
        if (_animationCompletedBlock) {
            self.animationCompletedBlock(YES);
        }
    } else if ([[anim valueForKey:kAnimType] isEqualToString:kAnimationShake]) {
        if (_shakeCompletedBlock) {
            self.shakeCompletedBlock(YES);
        }
    }
}


@end
