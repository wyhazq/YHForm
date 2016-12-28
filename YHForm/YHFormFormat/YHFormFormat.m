//
//  YHFormFormat.m
//  Neptune
//
//  Created by wyh on 2016/11/24.
//  Copyright © 2016年 NEO Capital. All rights reserved.
//

#import "YHFormFormat.h"
#import "YHFormRow.h"
#import "SVProgressHUD.h"
#import "YHFormCheckValid.h"

@implementation NSString (YHFormFormat)

//- (NSString *)formatMaxTextLength:(YHFormRow *)formRow {
//    NSString *text = self;
//    if (formRow.maxTextLength > 0) {
//        if (text.length > formRow.maxTextLength) {
//            text = [text substringToIndex:formRow.maxTextLength];
//            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"最多可输入%lu位", formRow.maxTextLength]];
//        }
//    }
//    return text;
//}

- (NSString *)formatTextFieldEndEditing:(YHFormRow *)formRow {
    NSString *text = self;
    if (formRow.maxTextLength > 0) {
        if (text.length > formRow.maxTextLength) {
            text = [text substringToIndex:formRow.maxTextLength];
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"最多可输入%lu位", (unsigned long)formRow.maxTextLength]];
        }
    }
    if (formRow.valueFormatType != YHFormValueFormatTypeDefault) {
        text = [text yh_formatType:formRow.valueFormatType];
    }
    if (formRow.minNum != 0 && [text floatValue] < formRow.minNum) {
        text = [NSString stringWithFormat:@"%.0f", formRow.minNum];
    }
    if (formRow.maxNum != 0 && [text floatValue] > formRow.maxNum) {
        text = [NSString stringWithFormat:@"%.0f", formRow.maxNum];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [text yh_checkValid:formRow.checkValidType];
    });
    return text;
}

- (NSString *)formatAddSuffixText:(NSString *)suffixText {
    NSString *text = self;
    if (suffixText && text.length > 0 && ![text hasSuffix:suffixText]) {
        text = [text stringByAppendingString:suffixText];
    }
    return text;
}

- (NSString *)formatClearSuffixText:(NSString *)suffixText {
    NSString *text = self;
    if (suffixText && [text hasSuffix:suffixText]) {
        text = [text stringByReplacingOccurrencesOfString:suffixText withString:@""];
    }
    return text;
}

- (id)formatValue:(YHFormRow *)formRow {
    if (self.length > 0) {
        if ([formRow.key isKindOfClass:[NSArray class]]) {
            return [self componentsSeparatedByString:formRow.separatedString];
        }
        return self;
    }
    return nil;
}

- (NSString *)formatDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:SS"];
    NSDate *date = [dateFormatter dateFromString:self];
    
    if (date) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [dateFormatter stringFromDate:date];
        return dateString;
    }
    return self;
}

@end
