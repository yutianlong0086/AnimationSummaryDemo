//
//  WBCurveMovingVC.m
//  AnimationSummaryDemo
//
//  Created by 余天龙 on 16/10/8.
//  Copyright © 2016年 http://blog.csdn.net/yutianlong9306/. All rights reserved.
//

#import "WBCurveMovingVC.h"

@interface WBCurveMovingVC ()

@end

@implementation WBCurveMovingVC

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
    
    //添加轨迹点
    // addQuadCurveToPoint 和 addCurveToPoint 都是曲线方法， 区别在于参数，addCurveToPoint 可以有两个基准点 controlPoint 作为划线的依据
    [path addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT * 0.75) controlPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT * 0.625)];
    [path addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT - self.animationView.height / 2.0) controlPoint:CGPointMake(0, SCREEN_HEIGHT * 0.875)];
    [path addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT * 0.75) controlPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT * 0.875)];
    [path addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT / 2.0) controlPoint:CGPointMake(0, SCREEN_HEIGHT * 0.625)];
    
    // 关键帧动画
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimation.path = path.CGPath;
    keyFrameAnimation.duration = 4.0f;
    keyFrameAnimation.repeatCount = HUGE_VALF;
    
    [self.animationView.layer addAnimation:keyFrameAnimation forKey:@"pathAnimation"];
}

- (void)removeAnimation {
    [self.animationView.layer removeAllAnimations];
}

@end
