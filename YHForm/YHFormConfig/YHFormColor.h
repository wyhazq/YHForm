//
//  YHFormColor.h
//  YHFormExample
//
//  Created by wyh on 2016/11/19.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHFormColor : NSObject

+ (void)configFormTintColor:(UIColor *)formTintColor cellContentBackgroundColor:(UIColor *)cellContentBackgroundColor textColor:(UIColor *)textColor;

+ (UIColor *)formTintColor;

+ (UIColor *)cellContentBackgroundColor;

+ (UIColor *)formTextColor;

@end

@interface UIColor (YHFormColor)

+ (instancetype)formTintColor;

+ (instancetype)cellContentBackgroundColor;

+ (instancetype)formTextColor;

+ (instancetype)requireTextColor;

+ (instancetype)lineColor;

@end
