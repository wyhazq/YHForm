//
//  YHFormData.m
//  YHFormExample
//
//  Created by wyh on 2016/11/13.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormData.h"
#import "YHFormTable.h"
#import "YHFormSection.h"
#import "YHFormRow.h"
#import "YHFormConfig.h"
#import "YHFormTools.h"

@interface YHFormData ()

@end

@implementation YHFormData

#pragma mark - Init

+ (instancetype)formData {
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _formTables = @[].mutableCopy;
    }
    return self;
}

#pragma mark - Update

- (void)addFormTable:(nullable YHFormTable *)formTable {
    [self.formTables addObject:formTable];
}

#pragma mark - Set
- (void)setFormTables:(NSMutableArray<YHFormTable *> *)formTables {
    _formTables = formTables;
    
    [_formTables enumerateObjectsUsingBlock:^(YHFormTable * _Nonnull formTable, NSUInteger idx, BOOL * _Nonnull stop) {
        formTable.formData = self;
    }];
}

- (void)setQueryResponse:(id)queryResponse {
    _queryResponse = queryResponse;
    NSArray<NSDictionary *> *responseArray;
    if ([queryResponse isKindOfClass:[NSDictionary class]] && [queryResponse count] > 0) {
        responseArray = [NSArray arrayWithObject:queryResponse];
    }
    else if ([queryResponse isKindOfClass:[NSArray class]] && [queryResponse count] > 0) {
        responseArray = queryResponse;
    }
    else {
        return;
    }
    
    [self.formTables enumerateObjectsUsingBlock:^(YHFormTable * _Nonnull formTable, NSUInteger idxTable, BOOL * _Nonnull stop) {
        NSDictionary *tableDict = responseArray[idxTable];
        [formTable.formSections enumerateObjectsUsingBlock:^(YHFormSection * _Nonnull formSection, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray<YHFormRow *> *formRows = formSection.formRows.copy;
                [formRows enumerateObjectsUsingBlock:^(YHFormRow * _Nonnull formRow, NSUInteger idxRow, BOOL * _Nonnull stop) {
                    if ([formRow.key isKindOfClass:[NSArray class]]) {
                        NSArray<NSString *> *formRowKeys = formRow.key;
                        NSMutableArray *formRowValues = @[].mutableCopy;
                        [formRowKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
                            id obj = [tableDict objectForKey:key];
                            if (obj && obj != [NSNull null] && ToFormString(obj).length > 0) {
                                [formRowValues addObject:obj];
                            }
                        }];
                        formRow.value = formRowValues;
                    }
                    else if([formRow.key isKindOfClass:[NSString class]]) {
                        id obj = [tableDict objectForKey:formRow.key];
                        if (obj && obj != [NSNull null]) {
                            formRow.value = obj;
                        }
                    }
                }];
        }];
    }];
}

- (void)setSelectors:(NSDictionary *)selectors {
    [selectors enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        YHFormRow *formRow = [self formRowForKey:key];
        if ([formRow.rowType isEqualToString:YHFormSelectorButtonCellType] || [formRow.rowType isEqualToString:YHFormSelectorCellType]) {
            [formRow configFormSelectors:obj];
        }
    }];
}

#pragma mark - Get

- (BOOL)isValid {
    __block BOOL result = YES;
    [self.formTables enumerateObjectsUsingBlock:^(YHFormTable * _Nonnull formTable, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!formTable.isValid) {
            result = NO;
            *stop = YES;
        }
    }];
    return result;
}

- (YHFormRow *)formRowForKey:(NSString *)key {
    __block YHFormRow *resultFormRow;
    if (key.length > 0) {
        [self.formTables enumerateObjectsUsingBlock:^(YHFormTable * _Nonnull formTable, NSUInteger idx, BOOL * _Nonnull stop0) {
            [formTable.formSections enumerateObjectsUsingBlock:^(YHFormSection * _Nonnull formSection, NSUInteger idx, BOOL * _Nonnull stop1) {
                [formSection.formRows enumerateObjectsUsingBlock:^(YHFormRow * _Nonnull formRow, NSUInteger idx, BOOL * _Nonnull stop2) {
                    if ([formRow.key isKindOfClass:[NSArray class]]) {
                        if ([formRow.key containsObject:key]) {
                            resultFormRow = formRow;
                            *stop2 = YES;
                            *stop1 = YES;
                            *stop0 = YES;
                        }
                    }
                    else if ([formRow.key isKindOfClass:[NSString class]]) {
                        if ([formRow.key isEqualToString:key]) {
                            resultFormRow = formRow;
                            *stop2 = YES;
                            *stop1 = YES;
                            *stop0 = YES;
                        }
                    }
                }];
            }];
        }];
    }
    return resultFormRow;
}

- (NSMutableDictionary *)formParameters {
    NSMutableDictionary *formParameters = @{}.mutableCopy;
    [self.formTables enumerateObjectsUsingBlock:^(YHFormTable * _Nonnull formTable, NSUInteger idx, BOOL * _Nonnull stop) {
        [formTable.tableParameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [formParameters setObject:obj forKey:key];
        }];
    }];
    return formParameters;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"formTables" : @"YHFormTable",
             };
}

@end
