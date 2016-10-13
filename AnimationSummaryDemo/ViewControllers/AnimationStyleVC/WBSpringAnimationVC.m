//
//  WBSpringAnimationVC.m
//  AnimationSummaryDemo
//
//  Created by 余天龙 on 16/10/9.
//  Copyright © 2016年 http://blog.csdn.net/yutianlong9306/. All rights reserved.
//

#import "WBSpringAnimationVC.h"

@interface WBSpringAnimationVC ()

@property (nonatomic, strong) UIImageView *basketballImageView;

@end

@implementation WBSpringAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (void)setupUI {

    self.animationView.hidden = YES;
    self.starAnimationButton.hidden = YES;
    self.removeAnimationButton.hidden = YES;
    
    self.basketballImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Basketball"]];
    [self.view addSubview:self.basketballImageView];
    [self.basketballImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.height.equalTo(@50);
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=touches.anyObject;
    
    CGPoint location= [touch locationInView:self.view];
    
    /**
     *  弹性动画
     *  Duration    动画持续时间
     *  delay       动画延迟执行时间
     *  Damping     弹性阻尼，范围0.0~1.0 ，值越小，弹簧振幅越大
     *  Velocity    弹性复位的速度
     *  options     动画类型
     *
     - returns:
     */
    [UIView animateWithDuration:5.0 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.basketballImageView.center = location;
    } completion:^(BOOL finished) {
        
    }];
}

@end
