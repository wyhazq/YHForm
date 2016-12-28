//
//  YHFormUI.m
//  YHFormExample
//
//  Created by wyh on 2016/11/18.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormUI.h"

static NSString * const YHFormCellHeight = @"YHFormCellHeight";

static const CGFloat YHFormCellDefaultHeight = 55.f;


@implementation YHFormUI

+ (void)configFormCellHeight:(CGFloat)formCellHeight {
    [[NSUserDefaults standardUserDefaults] setObject:@(formCellHeight) forKey:YHFormCellHeight];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (CGFloat)formCellHeight {
    static CGFloat formCellHeight;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formCellHeight = [[NSUserDefaults standardUserDefaults] floatForKey:YHFormCellHeight];
        if (formCellHeight == 0) {
            formCellHeight = YHFormCellDefaultHeight;
        }
    });
    return formCellHeight;
}

@end
