//
//  WBRotatingVC.m
//  AnimationSummaryDemo
//
//  Created by 余天龙 on 16/10/8.
//  Copyright © 2016年 http://blog.csdn.net/yutianlong9306/. All rights reserved.
//

#import "WBRotatingVC.h"

typedef NS_ENUM(NSUInteger, WBRotatingAxis) {
    
    WBRotatingAxisNone ,
    WBRotatingAxisX ,
    WBRotatingAxisY ,
    WBRotatingAxisZ
};

@interface WBRotatingVC ()

@end

@implementation WBRotatingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *axisX = [UIButton buttonWithType:UIButtonTypeCustom];
    axisX.titleLabel.font = [UIFont systemFontOfSize:15];
    [axisX setTitle:@"X 轴旋转" forState:UIControlStateNormal];
    [axisX setTitleColor:[UIColor colorWithRed:0.307 green:0.397 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    [axisX setBackgroundColor:[UIColor colorWithWhite:0.814 alpha:1.000]];
    [axisX addTarget:self action:@selector(rotatingWithAxisX:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *axisY = [UIButton buttonWithType:UIButtonTypeCustom];
    axisY.titleLabel.font = [UIFont systemFontOfSize:15];
    [axisY setTitle:@"Y 轴旋转" forState:UIControlStateNormal];
    [axisY setTitleColor:[UIColor colorWithRed:0.307 green:0.397 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    [axisY setBackgroundColor:[UIColor colorWithWhite:0.814 alpha:1.000]];
    [axisY addTarget:self action:@selector(rotatingWithAxisY:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *axisZ = [UIButton buttonWithType:UIButtonTypeCustom];
    axisZ.titleLabel.font = [UIFont systemFontOfSize:15];
    [axisZ setTitle:@"Z 轴旋转" forState:UIControlStateNormal];
    [axisZ setTitleColor:[UIColor colorWithRed:0.307 green:0.397 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    [axisZ setBackgroundColor:[UIColor colorWithWhite:0.814 alpha:1.000]];
    [axisZ addTarget:self action:@selector(rotatingWithAxisZ:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:axisX];
    [self.view addSubview:axisY];
    [self.view addSubview:axisZ];
    
    [axisX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@0);
        make.top.equalTo(@129);
        make.width.equalTo(@80);
        make.height.equalTo(@40);
    }];
    
    [axisY mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@0);
        make.top.equalTo(axisX.mas_bottom).offset(10);
        make.width.equalTo(@80);
        make.height.equalTo(@40);
    }];
    
    [axisZ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@0);
        make.top.equalTo(axisY.mas_bottom).offset(10);
        make.width.equalTo(@80);
        make.height.equalTo(@40);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (IBAction)rotatingWithAxisX:(id)sender {
    [self rotatingAnimationWithRotatingAxis:WBRotatingAxisX];
}

- (IBAction)rotatingWithAxisY:(id)sender {
    [self rotatingAnimationWithRotatingAxis:WBRotatingAxisY];
}

- (IBAction)rotatingWithAxisZ:(id)sender {
    [self rotatingAnimationWithRotatingAxis:WBRotatingAxisZ];
}

- (void)rotatingAnimationWithRotatingAxis:(WBRotatingAxis)rotatingAxis {

    [self removeAnimation];
    
    CABasicAnimation *animation;
    if (rotatingAxis == WBRotatingAxisNone) {
        animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];      //平面沿着中心点旋转
    } else if (rotatingAxis == WBRotatingAxisX) {
        animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];    //沿 X
    } else if (rotatingAxis == WBRotatingAxisY) {
        animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];    //沿 Y
    } else if (rotatingAxis == WBRotatingAxisZ) {
        animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];    //沿 Z
    }
    
    //起始
    animation.fromValue = [NSNumber numberWithFloat:0];
    //旋转角度
    animation.toValue = [NSNumber numberWithFloat:M_PI * 6];
    //持续时间
    animation.duration = 2.0f;
    //动画的速度变化
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //重复次数
    animation.repeatCount = HUGE_VALF;
    
    [self.animationView.layer addAnimation:animation forKey:@"rotationAnimation"];
}

#pragma mark - WBBaseAnimationDelegate methods

- (void)starAnimation {
    [self rotatingAnimationWithRotatingAxis:WBRotatingAxisNone];
}

- (void)removeAnimation {
    [self.animationView.layer removeAllAnimations];
}

@end
