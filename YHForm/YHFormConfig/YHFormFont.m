//
//  YHFormFont.m
//  YHFormExample
//
//  Created by wyh on 2016/11/19.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormFont.h"

static NSString * const YHFormFontSize = @"YHFormFontSize";

static const CGFloat YHFormDefaultFontSize = 14.f;

@implementation YHFormFont

+ (void)configFormDefaultFontSize:(CGFloat)fontSize {
    [[NSUserDefaults standardUserDefaults] setObject:@(fontSize) forKey:YHFormFontSize];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (CGFloat)formDefaultFontSize {
    static CGFloat formDefaultFontSize;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formDefaultFontSize = [[NSUserDefaults standardUserDefaults] floatForKey:YHFormFontSize];
        if (formDefaultFontSize == 0) {
            formDefaultFontSize = YHFormDefaultFontSize;
        }
    });
    return formDefaultFontSize;
}

@end


@implementation UIFont (YHFormFont)

+ (instancetype)formDefaultFont {
    return [self yh_lightFontOfSize:[YHFormFont formDefaultFontSize]];
}

+ (instancetype)requireLabelFont {
    return [self yh_lightFontOfSize:8.f];
}

+ (instancetype)yh_lightFontOfSize:(CGFloat)fontSize {
    return [[[UIDevice currentDevice] systemName] floatValue] >= 8.2 ? [self systemFontOfSize:fontSize weight:UIFontWeightLight] : [self systemFontOfSize:fontSize];
}

@end
