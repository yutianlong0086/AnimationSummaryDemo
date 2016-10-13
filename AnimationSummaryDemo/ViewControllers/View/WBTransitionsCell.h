//
//  WBTransitionsCell.h
//  AnimationSummaryDemo
//
//  Created by 余天龙 on 16/10/10.
//  Copyright © 2016年 http://blog.csdn.net/yutianlong9306/. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBTransitionsCell : UICollectionViewCell

+ (NSString *)reuseIdentifier;

- (void)setupWithTitle:(NSString *)title;

@end
