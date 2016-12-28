//
//  YHFormValueFormat.m
//  Neptune
//
//  Created by wyh on 2016/11/24.
//  Copyright © 2016年 NEO Capital. All rights reserved.
//

#import "YHFormValueFormat.h"

@implementation NSString (YHFormValueFormat)

- (NSString *)yh_formatType:(YHFormValueFormatType)formatType {
    switch (formatType) {
        case YHFormValueFormatTypeDefault:  break;
            
        case YHFormValueFormatTypeHundred: {
            return [self _yh_hundredText];
        } break;
            
        case YHFormValueFormatTypeThousand: {
            return [self _yh_thousandText];
        } break;
            
        case YHFormValueFormatTypeTenThousand: {
            return [self _yh_tenThousandText];
        } break;
    }
    return self;
}

- (NSString *)_yh_hundredText {
    NSInteger money = [self integerValue];
    if (money > 100) {
        return [NSString stringWithFormat:@"%ld", (long)(money / 100 * 100)];
    }
    return self;
}

- (NSString *)_yh_thousandText {
    NSInteger money = [self integerValue];
    if (money > 1000) {
        return [NSString stringWithFormat:@"%ld", (long)(money / 1000 * 1000)];
    }
    return self;
}

- (NSString *)_yh_tenThousandText {
    NSInteger money = [self integerValue];
    if (money > 10000) {
        return [NSString stringWithFormat:@"%ld", (long)(money / 10000 * 10000)];
    }
    return self;
}

@end
