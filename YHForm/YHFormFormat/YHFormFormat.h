//
//  YHFormFormat.h
//  YHFormExample
//
//  Created by wyh on 2016/11/18.
//  Copyright © 2016年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHFormValueFormat.h"
#import "YHFormCheckValid.h"

@class YHFormRow;

@interface NSString (YHFormFormat)

//- (NSString *)formatTextFieldEditing:(YHFormRow *)formRow;

- (NSString *)formatTextFieldEndEditing:(YHFormRow *)formRow;

- (NSString *)formatAddSuffixText:(NSString *)suffixText;

- (NSString *)formatClearSuffixText:(NSString *)suffixText;

- (id)formatValue:(YHFormRow *)formRow;

- (NSString *)formatDate;

@end
