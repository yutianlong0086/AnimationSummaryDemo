//
//  WBTrajectoryMovingVC.m
//  AnimationSummaryDemo
//
//  Created by 余天龙 on 16/10/8.
//  Copyright © 2016年 http://blog.csdn.net/yutianlong9306/. All rights reserved.
//

#import "WBTrajectoryMovingVC.h"

@interface WBTrajectoryMovingVC ()

@end

@implementation WBTrajectoryMovingVC

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
    
    //创建BezierPath 对象
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //设定运行的起点
    [path moveToPoint:self.animationView.layer.position];
    //添加运动的轨迹直线点
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
    //    pathAnimation.autoreverses = YES;           // 是否逆动画
    
    [self.animationView.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
}

- (void)removeAnimation {
    [self.animationView.layer removeAllAnimations];
}

@end
