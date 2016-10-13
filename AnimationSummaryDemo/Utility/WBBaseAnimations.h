//
//  WBBaseAnimations.h
//  Cosmetic
//
//  Created by 余天龙 on 16/9/30.
//  Copyright © 2016年 YuTianLong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBBaseAnimations : NSObject

+ (instancetype)sharedInstance;

/**
 *  加入购物车 动画
 *
 *  @param view        需要动画的视图
 *  @param starRect    动画的起始位置 Rect (相对于window的位置)
 *  @param finishPoint 动画的终点 Point
 *  @param completed   动画完成回调
 */
- (void)starAnimationWithView:(UIView *)view
                     starRect:(CGRect)starRect
                  finishPoint:(CGPoint)finishPoint
               completedBlock:(void (^)(BOOL finish))completed;

/**
 *  摇一摇动画
 *
 *  @param view      需要动画的视图
 *  @param completed 动画完成回调
 */
- (void)shakeAnimationWithView:(UIView *)view
                completedBlock:(void (^)(BOOL finish))completed;

@end
