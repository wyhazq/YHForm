//
//  YHFormSelector.m
//  YHFormExample
//
//  Created by wyh on 2016/11/20.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormSelector.h"

@implementation YHFormSelector

+ (instancetype)selectorWithValue:(id)value displayText:(NSString *)displayText {
    return [[self alloc] initWithValue:value displayText:displayText];
}

- (instancetype)initWithValue:(id)value displayText:(NSString *)displayText {
    self = [super init];
    if (self) {
        _value = value;
        _displayText = displayText;
    }
    return self;
}

@end
