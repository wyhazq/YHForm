//
//  YHFormRow.m
//  YHFormExample
//
//  Created by wyh on 2016/11/8.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormRow.h"

#import "YHFormTable.h"
#import "YHFormSection.h"
#import "YHFormString.h"
#import "SVProgressHUD.h"
#import "YHFormTools.h"
#import "YYModel.h"

@implementation YHFormRow

#pragma mark - Init

+ (instancetype)formRowWithRowType:(NSString *)rowType key:(id)key {
    return [self formRowWithRowType:rowType key:key value:nil];
}

+ (instancetype)formRowWithRowType:(NSString *)rowType key:(id)key value:(id)value {
    return [[self alloc] initWithRowType:rowType key:key value:value];
}

- (instancetype)init
{
    return [self initWithRowType:nil key:nil value:nil];
}

- (instancetype)initWithRowType:(NSString *)rowType key:(id)key value:(id)value {
    self = [super init];
    if (self) {
        _rowType = rowType;
        _key = key;
        _value = value;
        _required = YES;
        _canSelecte = YES;
        [self.observerKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
            [self addObserver:self forKeyPath:key options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:0];
        }];
    }
    return self;
}


#pragma mark - KVO

- (NSArray<NSString *> *)observerKeys {
    return @[@"value", @"placeholder"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (!self.formSection) return;
    if (object == self && [self.observerKeys containsObject:keyPath]) {
        if ([[change objectForKey:NSKeyValueChangeKindKey] isEqualToNumber:@(NSKeyValueChangeSetting)]) {
            id newValue = [change objectForKey:NSKeyValueChangeNewKey];
            id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
            [self.formSection.formTable.delegate formRowHasChanged:object oldValue:oldValue newValue:newValue];
        }
    }
}

-(void)dealloc
{
    @try {
        [self.observerKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
            [self removeObserver:self forKeyPath:key];
        }];
    }
    @catch (NSException * __unused exception) {}
}

#pragma mark - Set

- (void)setValueFromResponse:(id)response {
    if (response) {
        NSDictionary *responseDict;
        if ([response isKindOfClass:[NSArray class]]) {
            NSUInteger tableIndex = [self.formSection.formTable.formData.formTables indexOfObject:self.formSection.formTable];
            responseDict = [response objectAtIndex:tableIndex];
        }
        else if ([response isKindOfClass:[NSDictionary class]]) {
            responseDict = response;
        }
        if ([self.key isKindOfClass:[NSString class]]) {
            id value = responseDict[self.key];
            if (value && value != [NSNull null]) {
                self.value = value;
            }
        }
        else if ([self.key isKindOfClass:[NSArray class]]) {
            NSMutableArray *formRowValues = @[].mutableCopy;
            [self.key enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                id value = responseDict[obj];
                if (value && value != [NSNull null]) {
                    [formRowValues addObject:value];
                }
                else {
                    [formRowValues addObject:ToFormString(value)];
                }
            }];
            self.value = formRowValues;
        }
    }
}

- (void)configFormSelectors:(NSArray<NSDictionary *> *)selectors {
    self.formSelectors = [NSArray yy_modelArrayWithClass:[YHFormSelector class] json:selectors];
}

#pragma mark - Get

- (BOOL)isValid {
    NSString *valueString;
    if ([self.value isKindOfClass:[NSString class]] || [self.value isKindOfClass:[NSNumber class]] || [self.value isKindOfClass:[NSDate class]]) {
        valueString = ToFormString(self.value);
    }
    else if ([self.value isKindOfClass:[NSArray class]]) {
        valueString = [self.value componentsJoinedByString:self.separatedString];
    }

    //选填 && (空 || 符合格式)
    if (!self.isRequired) {
        if (ToFormString(self.value).length == 0 || [valueString yh_checkValid:self.checkValidType]) {
            return YES;
        }
    }
    //必填 && Length > 0 && 符合格式
    else if ([self hasValueText] && [ToFormString(valueString) yh_checkValid:self.checkValidType]) {
        return YES;
    }
    
    NSLog(@"FormRow isValid:\nkey:%@\ntitle:%@\nvalue:%@", self.key, self.title, self.value);
    return NO;
}

- (BOOL)hasValueText {
    BOOL result;
    if ([self.key isKindOfClass:[NSString class]]) {
        result = ToFormString(self.value).length > 0;
    }
    else if ([self.key isKindOfClass:[NSArray class]]) {
        //这里本来value的count要和key的count相同才过，但为了适应比如单位电话区号号码必填，分机号选填而做的修改
        result = [self.value count] > 0;
    }
    
    if (!result) {
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@未填写", self.title.clearSpacing]];
    }
    return result;
}

- (NSDictionary *)rowParameters {
    if (self.key && self.value) {
        if ([self.key isKindOfClass:[NSString class]] && ([self.value isKindOfClass:[NSString class]] || [self.value isKindOfClass:[NSNumber class]] || [self.value isKindOfClass:[NSDate class]])) {
            return [NSDictionary dictionaryWithObject:self.value forKey:self.key];
        }
        else if ([self.key isKindOfClass:[NSArray class]] && [self.value isKindOfClass:[NSArray class]]) {
            NSMutableDictionary *parametersDict = @{}.mutableCopy;
            [self.key enumerateObjectsUsingBlock:^(id  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx < [self.key count]) {
                    [parametersDict setObject:idx < [self.value count] ? self.value[idx] : @"" forKey:key];
                }
            }];
            return parametersDict.copy;
        }
        else if ([self.value isKindOfClass:[NSDictionary class]]) {
            return self.value;
        }
    }
    return nil;
}

- (NSString *)selectorDisplayText {
    __block NSString *selectorDisplayText;
    if ([self.key isKindOfClass:[NSArray class]] && [self.value isKindOfClass:[NSArray class]]) {
        //不能保证value数组的顺序一定是最后一个是显示的文字，所以必须遍历
        NSArray *values = self.value;
        [values enumerateObjectsUsingBlock:^(id  _Nonnull value, NSUInteger idx, BOOL * _Nonnull stopValue) {
            [self.formSelectors enumerateObjectsUsingBlock:^(YHFormSelector * _Nonnull formSelector, NSUInteger idx, BOOL * _Nonnull stopSelector) {
                //防止你传给后台的数据和后台传给你的数据类型不同
                if ([value isKindOfClass:[NSNumber class]] && [value isEqualToNumber:ToFormNumber(formSelector.value)]) {
                    selectorDisplayText = formSelector.displayText;
                    *stopSelector = YES;
                    *stopValue = YES;
                }
                else if ([value isKindOfClass:[NSString class]] && [ToFormString(value) isEqualToString:ToFormString(formSelector.value)]) {
                    selectorDisplayText = formSelector.displayText;
                    *stopSelector = YES;
                    *stopValue = YES;
                }
            }];
        }];
    }
    if ([self.key isKindOfClass:[NSString class]] && self.formSelectors.count > 0) {
        [self.formSelectors enumerateObjectsUsingBlock:^(YHFormSelector * _Nonnull formSelector, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([ToFormString(self.value) isEqualToString:ToFormString(formSelector.value)]) {
                selectorDisplayText = formSelector.displayText;
                *stop = YES;
            }
        }];
    }
    return selectorDisplayText;
}

- (NSString *)textDisplayString {
    if ([self.key isKindOfClass:[NSString class]] && ([self.value isKindOfClass:[NSString class]] || [self.value isKindOfClass:[NSNumber class]] || [self.value isKindOfClass:[NSDate class]])) {
        return ToFormString(self.value);
    }
    else if ([self.key isKindOfClass:[NSArray class]] && [self.value isKindOfClass:[NSArray class]]) {
        return [self.value componentsJoinedByString:self.separatedString];
    }
    return nil;
}

- (BOOL)isEqualToFormKey:(NSString *)key {
    if ([self.key isKindOfClass:[NSArray class]] && [self.key containsObject:key]) {
        return YES;
    }
    else if ([self.key isKindOfClass:[NSString class]] && [self.key isEqualToString:key]) {
        return YES;
    }
    return NO;
}

- (BOOL)isEqualToSelector:(YHFormSelector *)formSelector {
    __block BOOL result = NO;
    if (formSelector) {
        if ([self.value isKindOfClass:[NSArray class]]) {
            NSArray *values = self.value;
            [values enumerateObjectsUsingBlock:^(id  _Nonnull value, NSUInteger idx, BOOL * _Nonnull stopValue) {
                if ([value isKindOfClass:[NSNumber class]] && [value isEqualToNumber:ToFormNumber(formSelector.value)]) {
                    result = YES;
                }
                else if ([value isKindOfClass:[NSString class]] && [ToFormString(value) isEqualToString:ToFormString(formSelector.value)]) {
                    result = YES;
                }
            }];
        }
        else if ([self.value isKindOfClass:[NSNumber class]] && [self.value isEqualToNumber:ToFormNumber(formSelector.value)]) {
            return YES;
        }
        else if ([self.value isKindOfClass:[NSString class]] && [ToFormString(self.value) isEqualToString:ToFormString(formSelector.value)]) {
            return YES;
        }
    }
    return result;
}

- (NSString *)customKeyboardKeyString {
    return self.customKeyboardKeyDict[@(self.keyboardType)];
}

- (NSDictionary *)customKeyboardKeyDict {
    static NSDictionary *customKeyboardKeyDict;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        customKeyboardKeyDict = @{
                                  @(YHKeyboardTypeHomePhone) : @"-",
                                  @(YHKeyboardTypeIDCard) : @"X",
                                  };
    });
    return customKeyboardKeyDict;
}

- (NSString *)separatedString {
    if (_separatedString) return _separatedString;
    
    _separatedString = @" ";
    return _separatedString;
}

- (BOOL)isCanSelecte {
    if (!_canSelecte) {
        [SVProgressHUD showErrorWithStatus:self.cannotSelecteTips];
    }
    return _canSelecte;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"formSelectors" : @"YHFormSelector"};
}

@end

//#if NTDEBUG
//    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"出现这个，请找YH\nFormRow isValid:\nkey:%@\ntitle:%@\nvalue:%@", self.key, self.title, self.value]];
//#endif
