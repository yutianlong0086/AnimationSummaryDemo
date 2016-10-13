//
//  WBCombinationOneVC.m
//  AnimationSummaryDemo
//
//  Created by 余天龙 on 16/10/8.
//  Copyright © 2016年 http://blog.csdn.net/yutianlong9306/. All rights reserved.
//

#import "WBCombinationOneVC.h"

@interface WBCombinationOneVC ()

@end

@implementation WBCombinationOneVC

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *animation1 = [UIButton buttonWithType:UIButtonTypeCustom];
    animation1.titleLabel.font = [UIFont systemFontOfSize:15];
    [animation1 setTitle:@"缩放+旋转" forState:UIControlStateNormal];
    [animation1 setTitleColor:[UIColor colorWithRed:0.307 green:0.397 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    [animation1 setBackgroundColor:[UIColor colorWithWhite:0.814 alpha:1.000]];
    [animation1 addTarget:self action:@selector(combinationAnimationOne) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *animation2 = [UIButton buttonWithType:UIButtonTypeCustom];
    animation2.titleLabel.font = [UIFont systemFontOfSize:15];
    [animation2 setTitle:@"轨+缩+Z旋" forState:UIControlStateNormal];
    [animation2 setTitleColor:[UIColor colorWithRed:0.307 green:0.397 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    [animation2 setBackgroundColor:[UIColor colorWithWhite:0.814 alpha:1.000]];
    [animation2 addTarget:self action:@selector(animation2Click:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *animation3 = [UIButton buttonWithType:UIButtonTypeCustom];
    animation3.titleLabel.font = [UIFont systemFontOfSize:15];
    [animation3 setTitle:@"轨+缩+Y旋" forState:UIControlStateNormal];
    [animation3 setTitleColor:[UIColor colorWithRed:0.307 green:0.397 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    [animation3 setBackgroundColor:[UIColor colorWithWhite:0.814 alpha:1.000]];
    [animation3 addTarget:self action:@selector(animation3Click:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:animation1];
    [self.view addSubview:animation2];
    [self.view addSubview:animation3];
    
    [animation1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@0);
        make.top.equalTo(@129);
        make.width.equalTo(@105);
        make.height.equalTo(@40);
    }];
    
    [animation2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@0);
        make.top.equalTo(animation1.mas_bottom).offset(10);
        make.width.equalTo(animation1.mas_width);
        make.height.equalTo(@40);
    }];
    
    [animation3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@0);
        make.top.equalTo(animation2.mas_bottom).offset(10);
        make.width.equalTo(animation2.mas_width);
        make.height.equalTo(@40);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (IBAction)animation2Click:(UIButton *)sender {
    [self combinationAnimationTwoWithAxis:@"Z"];
}

- (IBAction)animation3Click:(UIButton *)sender {
    [self combinationAnimationTwoWithAxis:@"Y"];
}

#pragma mark 旋转+缩放
- (void)combinationAnimationOne {
    
    //创建旋转动画
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:M_PI * 8];
    rotateAnimation.duration = 1.5f;
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotateAnimation.repeatCount = HUGE_VALF;
    rotateAnimation.autoreverses = YES;

    //创建缩放动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 1.5f;
    scaleAnimation.repeatCount = HUGE_VALF;
    scaleAnimation.autoreverses = YES;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:3.0];

    // 创建的动画组
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[rotateAnimation, scaleAnimation];
    groups.duration = 1.5f;
    groups.repeatCount = HUGE_VALF;
    groups.autoreverses = YES;
    
    [self.animationView.layer addAnimation:groups forKey:@"CombinationAnimation"];
}

#pragma mark 移动+旋转+缩放
- (void)combinationAnimationTwoWithAxis:(NSString *)axis {
    
    //创建移动轨迹
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.animationView.layer.position];
    [path addLineToPoint:CGPointMake(SCREEN_WIDTH - self.animationView.width / 2.0, SCREEN_HEIGHT / 2.0)];
    [path addLineToPoint:CGPointMake(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT - self.animationView.width / 2.0)];
    [path addLineToPoint:CGPointMake(self.animationView.width / 2.0, SCREEN_HEIGHT / 2.0)];
    [path addLineToPoint:CGPointMake(SCREEN_WIDTH / 2.0, 64 + self.animationView.width / 2.0)];
    [path closePath];
    
    //创建关键帧动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.path = path.CGPath;           //将路径给予动画
    pathAnimation.duration = 8.0;               //持续时间
    pathAnimation.repeatCount = HUGE_VALF;      // 重复次数
    
    //创建缩放动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 1.5f;
    scaleAnimation.repeatCount = HUGE_VALF;
    scaleAnimation.autoreverses = YES;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:3.0];

    //创建旋转动画
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:[axis isEqualToString:@"Z"] ? @"transform.rotation" :  @"transform.rotation.y"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:12];
    rotateAnimation.duration = 0.5f;
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotateAnimation.repeatCount = 4;
    rotateAnimation.autoreverses = YES;

    // 创建的动画组
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[pathAnimation, rotateAnimation, scaleAnimation];
    groups.duration = 8.0;
    groups.repeatCount = HUGE_VALF;
    groups.autoreverses = YES;
    
    [self.animationView.layer addAnimation:groups forKey:@"CombinationAnimation"];
}

#pragma mark - WBBaseAnimationDelegate methods

- (void)starAnimation {
    [self combinationAnimationTwoWithAxis:@"Z"];
}

- (void)removeAnimation {
    [self.animationView.layer removeAllAnimations];
}

@end
