//
//  WBShoppingCartVC.m
//  AnimationSummaryDemo
//
//  Created by 余天龙 on 16/9/30.
//  Copyright © 2016年 http://blog.csdn.net/yutianlong9306/. All rights reserved.
//

#import "WBShoppingCartVC.h"
#import "WBShoppingCartCell.h"
#import "WBBaseAnimations.h"

@interface WBShoppingCartVC ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation WBShoppingCartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (void)addCartAnimationWithView:(UIView *)view {

    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    CGRect goodsImageRect = [view convertRect:view.bounds toView:window];
    //动画期间禁止交互，可以一次只执行一次动画.
//    window.userInteractionEnabled = NO;
    
    WBBaseAnimations *animation = [WBBaseAnimations sharedInstance];
    [animation starAnimationWithView:view starRect:goodsImageRect finishPoint:CGPointMake(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT - 49) completedBlock:^(BOOL finish) {
        if (finish) {
            UIView *tabbarView = self.tabBarController.tabBar.subviews[2];
            [animation shakeAnimationWithView:tabbarView completedBlock:^(BOOL finish) {
                if (finish) {
//                    window.userInteractionEnabled = YES;
                }
            }];
        }
    }];
}

#pragma mark - UITableViewDelegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WBShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shoppingCartCell" forIndexPath:indexPath];
    [cell setAddCartGoodsImageViewBlock:^(UIImageView *imageView) {
        [self addCartAnimationWithView:imageView];
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
