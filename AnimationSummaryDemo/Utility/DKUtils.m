//
//  DKUtils.m
//  Cosmetic
//
//  Created by 余天龙 on 16/4/7.
//  Copyright © 2016年 YuTianLong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DKUtils.h"
#import <Photos/Photos.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CGSize getTextSize(UIFont *font, NSString *text, CGFloat maxWidth) {
    if (iOS_VERSION_NOT_LESS_THAN_7) {
        CGSize textSize = [text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                             options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                          attributes:@{ NSFontAttributeName : font }
                                             context:nil].size;
        return textSize;
    }
    
    CGSize textSize = [text sizeWithFont:font
                       constrainedToSize:CGSizeMake(maxWidth, MAXFLOAT)
                           lineBreakMode:NSLineBreakByCharWrapping];
    return textSize;
}

CGSize getTextWidth(UIFont *font, NSString *text, CGFloat maxHeight) {
    if (iOS_VERSION_NOT_LESS_THAN_7) {
        CGSize textSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, maxHeight)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{ NSFontAttributeName : font }
                                             context:nil].size;
        return textSize;
    }
    
    CGSize textSize = [text sizeWithFont:font
                       constrainedToSize:CGSizeMake(MAXFLOAT, maxHeight)
                           lineBreakMode:NSLineBreakByCharWrapping];
    return textSize;
}

CGSize getTextSizeMinWidth(UIFont *font, NSString *text, CGFloat minWidth) {
    CGSize textSize = getTextSize(font, text, MAXFLOAT);
    textSize.width = MAX(minWidth, textSize.width);
    return textSize;
}

CGSize getScreenSize() {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) &&
        UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return CGSizeMake(screenSize.height, screenSize.width);
    }
    return screenSize;
}
