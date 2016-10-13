//
//  WBBaseAnimationVC.h
//  AnimationSummaryDemo
//
//  Created by 余天龙 on 16/10/8.
//  Copyright © 2016年 http://blog.csdn.net/yutianlong9306/. All rights reserved.
//

#import "ViewController.h"

@protocol WBBaseAnimationDelegate <NSObject>

- (void)starAnimation;

- (void)removeAnimation;

@end

@interface WBBaseAnimationVC : UIViewController <WBBaseAnimationDelegate>

@property (nonatomic, strong) UIView *animationView;
@property (nonatomic, readonly) UIButton *starAnimationButton;
@property (nonatomic, readonly) UIButton *removeAnimationButton;

@end
