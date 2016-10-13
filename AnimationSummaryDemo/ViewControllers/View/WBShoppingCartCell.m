//
//  WBShoppingCartCell.m
//  AnimationSummaryDemo
//
//  Created by 余天龙 on 16/10/8.
//  Copyright © 2016年 http://blog.csdn.net/yutianlong9306/. All rights reserved.
//

#import "WBShoppingCartCell.h"

@interface WBShoppingCartCell ()

@property (strong, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (strong, nonatomic) IBOutlet UILabel *goodsName;
@property (strong, nonatomic) IBOutlet UILabel *goodsPrice;
@property (strong, nonatomic) IBOutlet UIButton *addCartButton;

@end

@implementation WBShoppingCartCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self.addCartButton addTarget:self action:@selector(addCartClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonInit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Private methods

- (IBAction)addCartClick:(UIButton *)sender {
    self.addCartGoodsImageViewBlock(self.goodsImageView);
}

@end
