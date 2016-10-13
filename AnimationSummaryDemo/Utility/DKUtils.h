//
//  DKUtils.h
//  Cosmetic
//
//  Created by 余天龙 on 16/4/7.
//  Copyright © 2016年 YuTianLong. All rights reserved.
//

#ifndef portfolio_DKUtils_h
#define portfolio_DKUtils_h

#import <UIKit/UIKit.h>

#ifdef __cplusplus
extern "C" {
#endif
    
    /**
     * 计算text所需要的size
     */
    CGSize getTextSize(UIFont *font,NSString *text, CGFloat maxWidth);
    
    /**
     * 计算text所需要的size，并保证最小宽度
     */
    CGSize getTextSizeMinWidth(UIFont *font,NSString *text, CGFloat minWidth);
    
    /**
     * 获取当前屏幕的尺寸，兼容iOS7、iOS8
     */
    CGSize getScreenSize();
    
    /**
     * 计算text所需要的size
     */
    CGSize getTextWidth(UIFont *font,NSString *text, CGFloat maxHeight);
    
    /**
     *  请求 Photo 权限
     */
    
#ifdef __cplusplus
}
#endif

#endif
