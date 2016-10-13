//
//  WBTransitionsAnimationVC.m
//  AnimationSummaryDemo
//
//  Created by 余天龙 on 16/10/10.
//  Copyright © 2016年 http://blog.csdn.net/yutianlong9306/. All rights reserved.
//

#import "WBTransitionsAnimationVC.h"
#import "WBTransitionsCell.h"

@interface WBTransitionsAnimationVC () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<NSDictionary<NSString *, NSString *> *> *titles;
@property (nonatomic, strong) NSArray<NSString *> *imagesNamed;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *pageLabel;

@property (nonatomic, assign) NSInteger currentIndex;           //当前第几张图片
@property (nonatomic, copy) NSString *currentAnimationType;     //当前动画类型

@end

@implementation WBTransitionsAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private methods

- (void)setupUI {
    
    self.animationView.hidden = YES;
    self.starAnimationButton.hidden = YES;
    self.removeAnimationButton.hidden = YES;
    
    self.titles = @[
                    @{@"fade" : @"淡出效果"} ,
                    @{@"movein" : @"新视图移动到旧视图上"} ,
                    @{@"push" : @"新视图推出旧视图"} ,
                    @{@"reveal" : @"移开旧视图显示新视图"} ,
                    @{@"cube" : @"立方体翻转效果"} ,
                    @{@"oglFlip" : @"翻转效果"} ,
                    @{@"suckEffect" : @"收缩效果"} ,
                    @{@"rippleEffect" : @"水滴波纹效果"} ,
                    @{@"pageCurl" : @"向上翻页效果"} ,
                    @{@"pageUnCurl" : @"向下翻页效果"} ,
                    @{@"cameralIrisHollowOpen" : @"摄像头打开效果"} ,
                    @{@"cameraIrisHollowClose" : @"摄像头关闭效果"}
                    ];
  
    self.imagesNamed = @[
                         @"picture1" ,
                         @"picture2" ,
                         @"picture3" ,
                         @"picture4" ,
                         @"picture5" ,
                         @"picture6" ,
                         @"picture7" ,
                         @"picture8" 
                         ];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) collectionViewLayout:layout];
    [_collectionView registerClass:[WBTransitionsCell class] forCellWithReuseIdentifier:[WBTransitionsCell reuseIdentifier]];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.alwaysBounceVertical = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    self.imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imageView];
    
    self.pageLabel = [[UILabel alloc] init];
    self.pageLabel.textColor = [UIColor redColor];
    self.pageLabel.textAlignment = NSTextAlignmentCenter;
    self.pageLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:self.pageLabel];

    [self.view setNeedsLayout];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@70);
        make.leading.trailing.equalTo(@0);
        make.height.equalTo(@50);
    }];

    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom).offset(40);
        make.leading.equalTo(@30);
        make.trailing.equalTo(@(-30));
        make.bottom.equalTo(@(-40));
    }];
    
    [self.pageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom);
        make.bottom.equalTo(@0);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@200);
    }];
    [self.view layoutIfNeeded];
    
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGesture];
    
    [self setupDefaultValue];
}

#pragma mark - Private methods

- (void)setupDefaultValue {
    
    //默认图
    self.currentIndex = 0;
    self.imageView.image = [self fetchCurrentImageWithIndex:self.currentIndex];
    [self updatePageWithIndex:self.currentIndex];
    //默认动画类型
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self updateAnimationTypeWithIndexPath:indexPath];
}

// 获取image
- (UIImage *)fetchCurrentImageWithIndex:(NSInteger)index {
    return [UIImage imageNamed:self.imagesNamed[index]];
}

// 更新动画类型 及 UI
- (void)updateAnimationTypeWithIndexPath:(NSIndexPath *)indexPath {

    self.currentAnimationType = self.titles[indexPath.row].allKeys.firstObject;
    WBTransitionsCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[WBTransitionsCell reuseIdentifier] forIndexPath:indexPath];
    cell.selected = YES;
}

- (void)leftSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimationDirection:YES];
}

- (void)rightSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimationDirection:NO];
}

// 执行动画
- (void)transitionAnimationDirection:(BOOL)isNext {
    
    CATransition *transition = [[CATransition alloc] init];
    //设置动画类型
    transition.type = self.currentAnimationType;
    //设置动画时常
    transition.duration = 1.0f;
    //设置方向
    if (isNext) {
        transition.subtype = kCATransitionFromRight;
        self.currentIndex += 1;
    } else {
        transition.subtype = kCATransitionFromLeft;
        self.currentIndex -= 1;
    }
    
    if (self.currentIndex == -1) {
        self.currentIndex = self.imagesNamed.count - 1;
    } else if (self.currentIndex == self.imagesNamed.count) {
        self.currentIndex = 0;
    }
    [self updatePageWithIndex:self.currentIndex];
    self.imageView.image = [self fetchCurrentImageWithIndex:self.currentIndex];
    [self.imageView.layer addAnimation:transition forKey:@"transitionAnimation"];
}

// 更新 Page
- (void)updatePageWithIndex:(NSInteger)index {
    self.pageLabel.text = [NSString stringWithFormat:@"%ld / %ld", index + 1, self.imagesNamed.count];
}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WBTransitionsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[WBTransitionsCell reuseIdentifier] forIndexPath:indexPath];
    [cell setupWithTitle:self.titles[indexPath.row].allValues.firstObject];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat minWidth = getTextWidth([UIFont systemFontOfSize:15], self.titles[indexPath.row].allValues.firstObject, 50).width;
    return CGSizeMake(minWidth + 20, collectionView.height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self updateAnimationTypeWithIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WBTransitionsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[WBTransitionsCell reuseIdentifier] forIndexPath:indexPath];
    cell.selected = NO;
}

@end
