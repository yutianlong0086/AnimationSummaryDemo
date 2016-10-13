//
//  WBSimpleMovingVC.m
//  AnimationSummaryDemo
//
//  Created by 余天龙 on 16/10/8.
//  Copyright © 2016年 http://blog.csdn.net/yutianlong9306/. All rights reserved.
//

#import "WBSimpleMovingVC.h"

@interface WBSimpleMovingVC ()

@end

@implementation WBSimpleMovingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WBBaseAnimationDelegate methods

- (void)starAnimation {
    
    //创建基础动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    //动画持续时间
    animation.duration = 2.0f;
    //重复次数
    animation.repeatCount = HUGE_VALF;
    //是否执行逆动画
    animation.autoreverses = YES;
    //动画的速度变化
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    //动画的起始位置(当前)
    animation.fromValue = [NSValue valueWithCGPoint:self.animationView.layer.position];
    //动画的终点位置
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH - self.animationView.width / 2.0, SCREEN_HEIGHT - self.animationView.height / 2.0)];
    
    [self.animationView.layer addAnimation:animation forKey:@"position"];
}

- (void)removeAnimation {
    [self.animationView.layer removeAllAnimations];
}

@end
