//
//  WBBaseAnimationVC.m
//  AnimationSummaryDemo
//
//  Created by 余天龙 on 16/10/8.
//  Copyright © 2016年 http://blog.csdn.net/yutianlong9306/. All rights reserved.
//

#import "WBBaseAnimationVC.h"

@interface WBBaseAnimationVC ()

@property (nonatomic, strong) UIButton *starAnimationButton;
@property (nonatomic, strong) UIButton *removeAnimationButton;

@end

@implementation WBBaseAnimationVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.starAnimationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.starAnimationButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.starAnimationButton setTitle:@"开始动画" forState:UIControlStateNormal];
    [self.starAnimationButton setTitleColor:[UIColor colorWithRed:0.307 green:0.397 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    [self.starAnimationButton setBackgroundColor:[UIColor colorWithWhite:0.814 alpha:1.000]];
    [self.starAnimationButton addTarget:self action:@selector(starAnimationClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.removeAnimationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.removeAnimationButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.removeAnimationButton setTitle:@"移除动画" forState:UIControlStateNormal];
    [self.removeAnimationButton setTitleColor:[UIColor colorWithRed:0.307 green:0.397 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    [self.removeAnimationButton setBackgroundColor:[UIColor colorWithWhite:0.814 alpha:1.000]];
    [self.removeAnimationButton addTarget:self action:@selector(removeAnimationClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.animationView = [UIView new];
    self.animationView.backgroundColor = [UIColor colorWithRed:0.679 green:0.677 blue:0.982 alpha:1.000];
    
    [self.view addSubview:self.starAnimationButton];
    [self.view addSubview:self.removeAnimationButton];
    [self.view addSubview:self.animationView];
    
    [self.view setNeedsLayout];
    [self.starAnimationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@0);
        make.top.equalTo(@64);
        make.width.equalTo(@105);
        make.height.equalTo(@55);
    }];
    
    [self.removeAnimationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@0);
        make.top.equalTo(self.starAnimationButton.mas_top);
        make.width.equalTo(@105);
        make.height.equalTo(@55);
    }];
    
    [self.animationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.height.equalTo(@80);
    }];
    [self.view layoutIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (IBAction)starAnimationClick:(UIButton *)sender {
    [self starAnimation];
}

- (IBAction)removeAnimationClick:(UIButton *)sender {
    [self removeAnimation];
}

#pragma mark - WBBaseAnimationDelegate methods

- (void)starAnimation {}

- (void)removeAnimation {}

@end
