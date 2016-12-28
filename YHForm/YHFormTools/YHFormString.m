//
//  YHFormString.m
//  YHFormExample
//
//  Created by wyh on 2016/11/19.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormString.h"

@implementation YHFormString

NSString *ToFormString(id obj) {
    if (obj) {
        if ([obj isKindOfClass:[NSString class]]) {
            return obj;
        }
        else if ([obj isKindOfClass:[NSNumber class]]) {
            return [obj stringValue];
        }
        else if ([obj isKindOfClass:[NSDate class]]) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *dateString = [dateFormatter stringFromDate:obj];
            return dateString;
        }
    }
    return @"";
}

NSNumber *ToFormNumber(id obj) {
    if (!obj || obj == [NSNull null]) {
        return @(NSIntegerMin);
    }
    else if ([obj isKindOfClass:[NSString class]]) {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        return [numberFormatter numberFromString:obj];
    }
    return obj;
}

@end


@implementation NSString (YHFormString)

- (NSString *)clearSpacing {
    NSString *clearSpacingString = [[self stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"　" withString:@""];
    return clearSpacingString;
}

- (NSDate *)yhForm_date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:self];
    return date;
}

@end
