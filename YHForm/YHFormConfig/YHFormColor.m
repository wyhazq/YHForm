//
//  YHFormColor.m
//  YHFormExample
//
//  Created by wyh on 2016/11/19.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormColor.h"

static NSString * const YHFormTintColor = @"YHFormTintColor";
static NSString * const YHFormCellContentBackgroundColor = @"YHFormCellContentBackgroundColor";
static NSString * const YHFormTextColor = @"YHFormTextColor";

#ifndef YHFormDefaultTintColor
#define YHFormDefaultTintColor      [UIColor colorWithRed:0.96 green:0.56 blue:0.25 alpha:1.00]
#endif

#ifndef YHFormCellContentDefaultBackgroundColor
#define YHFormCellContentDefaultBackgroundColor      [UIColor colorWithRed:0.95 green:0.95 blue:0.96 alpha:1]
#endif

#ifndef YHFormDefaultTextColor
#define YHFormDefaultTextColor      [UIColor colorWithWhite:0.40 alpha:1]
#endif

@implementation YHFormColor

+ (void)configFormTintColor:(UIColor *)formTintColor cellContentBackgroundColor:(UIColor *)cellContentBackgroundColor textColor:(UIColor *)textColor {
    [[NSUserDefaults standardUserDefaults] setObject:formTintColor forKey:YHFormTintColor];
    [[NSUserDefaults standardUserDefaults] setObject:cellContentBackgroundColor forKey:YHFormCellContentBackgroundColor];
    [[NSUserDefaults standardUserDefaults] setObject:textColor forKey:YHFormTextColor];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (UIColor *)formTintColor {
    static UIColor *formTintColor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formTintColor = [[NSUserDefaults standardUserDefaults] objectForKey:YHFormTintColor];
        if (!formTintColor) {
            formTintColor = YHFormDefaultTintColor;
        }
    });
    return formTintColor;
}

+ (UIColor *)cellContentBackgroundColor {
    static UIColor *cellContentBackgroundColor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cellContentBackgroundColor = [[NSUserDefaults standardUserDefaults] objectForKey:YHFormCellContentBackgroundColor];
        if (!cellContentBackgroundColor) {
            cellContentBackgroundColor = YHFormCellContentDefaultBackgroundColor;
        }
    });
    return cellContentBackgroundColor;
}

+ (UIColor *)formTextColor {
    static UIColor *formTextColor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formTextColor = [[NSUserDefaults standardUserDefaults] objectForKey:YHFormCellContentBackgroundColor];
        if (!formTextColor) {
            formTextColor = YHFormDefaultTextColor;
        }
    });
    return formTextColor;
}

@end

@implementation UIColor (YHFormColor)

+ (instancetype)formTintColor {
    return [YHFormColor formTintColor];
}

+ (instancetype)cellContentBackgroundColor {
    return [YHFormColor cellContentBackgroundColor];
}

+ (instancetype)formTextColor {
    return [YHFormColor formTextColor];
}

+ (instancetype)requireTextColor {
    return [UIColor colorWithWhite:0.64 alpha:1];
}

+ (instancetype)lineColor {
    return [UIColor colorWithWhite:0.90 alpha:1];
}

@end
