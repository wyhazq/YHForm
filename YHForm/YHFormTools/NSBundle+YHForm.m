//
//  NSBundle+YHForm.m
//  YHFormExample
//
//  Created by wyh on 2016/11/14.
//  Copyright © 2016年 . All rights reserved.
//

#import "NSBundle+YHForm.h"

@implementation NSBundle (YHForm)

- (BOOL)yh_containNib:(NSString *)classString {
    return [self pathForResource:classString ofType:@"nib"] != nil;
}

+ (instancetype)yh_formBundle {
    static NSBundle *resourceBundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *resourceBundlePath = [[NSBundle bundleForClass:NSClassFromString(@"YHForm")] pathForResource:@"YHForm" ofType:@"bundle"];
        resourceBundle = [self bundleWithPath:resourceBundlePath];
    });
    
    return resourceBundle;
}


@end
