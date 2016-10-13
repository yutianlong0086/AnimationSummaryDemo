//
//  DKBaseDeinfe.h
//  Cosmetic
//
//  Created by 余天龙 on 16/4/7.
//  Copyright © 2016年 YuTianLong. All rights reserved.
//

#ifndef DKBaseDeinfe_h
#define DKBaseDeinfe_h

/**
 * 获取设备的版本
 */
#define iOS_VERSION                     [[[UIDevice currentDevice] systemVersion] floatValue]
#define iOS_VERSION_NOT_LESS_THAN_7     (iOS_VERSION >= 7.0)
#define iOS_VERSION_NOT_LESS_THAN_8     (iOS_VERSION >= 8.0)

#define isiPhone4S()        (SCREEN_HEIGHT <= 480)
#define isiPhone6Plus()     ([UIScreen mainScreen].scale > 2.9)

#define isSmallPhone()      (isiPhone4S())
#define isBigPhone()        (isiPhone6Plus())

#define isiPhone5()           (SCREEN_HEIGHT == 568)
#define isiPhone6()           (SCREEN_HEIGHT == 667)

/**
 * 获取屏幕的高度和宽度
 */
#define SCREEN_WIDTH        (getScreenSize().width)
#define SCREEN_HEIGHT       (getScreenSize().height)

/**
 * 颜色转换
 */
#define RGB_COLOR_ALPHA(r,g,b,a)    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define RGB_COLOR(r,g,b)            RGB_COLOR_ALPHA(r,g,b,1)
#define RGB_COLOR_HEX(rgbValue)     RGB_COLOR(((float)(((rgbValue) & 0xFF0000) >> 16)), ((float)(((rgbValue) & 0xFF00)>>8)), ((float)((rgbValue) & 0xFF)))

/**
 * to string
 */
#define INT_TO_STRING(i)		[NSString stringWithFormat:@"%zd",i]
#define DOUBLE_TO_STRING(i)		[NSString stringWithFormat:@"%f",i]

/**
 * weak 对象
 */
#define WEAK_OBJECT(obj, weakObj)       __weak typeof(obj) weakObj = obj;
#define WEAK_SELF()                     WEAK_OBJECT(self, weakSelf);

/**
 * 生成 commonInit 方法
 */
#define commonInitSafe(className)                   [self className ## _commonInit]
#define commonInitImplementationSafe(className)     -(void) className##_commonInit

/**
 *  安全地调用 block
 */
#define BLOCK_SAFE_CALLS(block, ...) block ? block(__VA_ARGS__) : nil

#define BLOCK_SAFE_CALLS_In_Main_Queue(block, ...) block ? dispatch_async(dispatch_get_main_queue(), ^{ block(__VA_ARGS__); }) : nil

/**
 * 单例宏
 */
#define SINGLETON_CLASS()      \
static id manager; \
+ (instancetype)sharedInstance { \
static dispatch_once_t onceToken;   \
dispatch_once(&onceToken, ^{    \
manager = [self new];  \
}); \
return manager; \
}


#endif /* DKBaseDeinfe_h */
