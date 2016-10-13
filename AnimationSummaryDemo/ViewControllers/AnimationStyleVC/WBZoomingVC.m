//
//  WBZoomingVC.m
//  AnimationSummaryDemo
//
//  Created by 余天龙 on 16/10/8.
//  Copyright © 2016年 http://blog.csdn.net/yutianlong9306/. All rights reserved.
//

#import "WBZoomingVC.h"

@interface WBZoomingVC ()

@end

@implementation WBZoomingVC

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
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 1.5f;
    animation.repeatCount = HUGE_VALF;
    animation.autoreverses = YES;           
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    //起始倍率
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    //结束时倍率
    animation.toValue = [NSNumber numberWithFloat:2.0];
    
    [self.animationView.layer addAnimation:animation forKey:@"scaleAnimation"];
}

- (void)removeAnimation {
    [self.animationView.layer removeAllAnimations];
}

@end
