//
//  WBTransitionsCell.m
//  AnimationSummaryDemo
//
//  Created by 余天龙 on 16/10/10.
//  Copyright © 2016年 http://blog.csdn.net/yutianlong9306/. All rights reserved.
//

#import "WBTransitionsCell.h"

@interface WBTransitionsCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation WBTransitionsCell

+ (NSString *)reuseIdentifier {
    return @"TRANSITION_CELL";
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    self.contentView.backgroundColor = [UIColor colorWithWhite:0.826 alpha:1.000];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = [UIColor blackColor];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.leading.equalTo(@10);
        make.trailing.equalTo(@10);
    }];
}

- (void)setupWithTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setSelected:(BOOL)selected {
    self.titleLabel.textColor = selected ? [UIColor redColor] : [UIColor blackColor];
}

@end
