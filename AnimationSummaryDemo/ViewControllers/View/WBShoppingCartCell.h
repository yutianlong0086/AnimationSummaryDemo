//
//  WBShoppingCartCell.h
//  AnimationSummaryDemo
//
//  Created by 余天龙 on 16/10/8.
//  Copyright © 2016年 http://blog.csdn.net/yutianlong9306/. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBShoppingCartCell : UITableViewCell

@property (nonatomic, copy) void (^addCartGoodsImageViewBlock)(UIImageView *imageView);

@end
