//
//  YHFormConfig.m
//  YHFormExample
//
//  Created by wyh on 2016/11/19.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormConfig.h"

@implementation YHFormConfig

+ (void)configDefaultFormCellHeight:(CGFloat)formCellHeight fontSize:(CGFloat)fontSize tintColor:(UIColor *)tintColor cellContentBackgroundColor:(UIColor *)cellContentBackgroundColor textColor:(UIColor *)textColor {
    [YHFormUI configFormCellHeight:formCellHeight];
    [YHFormFont configFormDefaultFontSize:fontSize];
    [YHFormColor configFormTintColor:tintColor cellContentBackgroundColor:cellContentBackgroundColor textColor:textColor];
}

@end
