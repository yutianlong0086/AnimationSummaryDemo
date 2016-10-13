//
//  WBAnimationStyleVC.m
//  AnimationSummaryDemo
//
//  Created by 余天龙 on 16/9/30.
//  Copyright © 2016年 http://blog.csdn.net/yutianlong9306/. All rights reserved.
//

#import "WBAnimationStyleVC.h"
#import "WBSimpleMovingVC.h"
#import "WBRotatingVC.h"
#import "WBZoomingVC.h"
#import "WBTrajectoryMovingVC.h"
#import "WBCurveMovingVC.h"
#import "WBCombinationOneVC.h"
#import "WBSpringAnimationVC.h"
#import "WBTransitionsAnimationVC.h"

@interface WBAnimationStyleVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<NSString *> *titles;

@end

@implementation WBAnimationStyleVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = COMMON_BACKGROUND_COLOR;
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private methods

- (void)setupUI {

    self.titles = @[@"简单移动", @"简单旋转", @"简单缩放", @"轨迹移动", @"曲线移动", @"组合动画 ", @"弹簧动画", @"转场动画"];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc;
    switch (indexPath.row) {
        case 0: {
            vc = [WBSimpleMovingVC new];
        }   break;
        case 1: {
            vc = [WBRotatingVC new];
        }   break;
        case 2: {
            vc = [WBZoomingVC new];
        }   break;
        case 3: {
            vc = [WBTrajectoryMovingVC new];
        }   break;
        case 4: {
            vc = [WBCurveMovingVC new];
        }   break;
        case 5: {
            vc = [WBCombinationOneVC new];
        }   break;
        case 6: {
            vc = [WBSpringAnimationVC new];
        }   break;
        case 7: {
            vc = [WBTransitionsAnimationVC new];
        }   break;
        
        default:
            break;
    }
    vc.navigationItem.title = self.titles[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

@end
