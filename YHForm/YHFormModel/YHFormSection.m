//
//  YHFormSection.m
//  YHFormExample
//
//  Created by wyh on 2016/11/8.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormSection.h"

#import "YHFormTable.h"
#import "YHFormSectionHeader.h"
#import "YHFormRow.h"
#import "YHFormSectionFooter.h"

@interface YHFormSection ()

@end

@implementation YHFormSection

#pragma mark - Init

+ (instancetype)formSection {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        if (self) {
            _formRows = @[].mutableCopy;
            [self addObserver:self forKeyPath:@"formRows" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:0];
        }
    }
    return self;
}

#pragma mark - KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (!self.formTable.delegate) return;
    if ([keyPath isEqualToString:@"formRows"]) {
        if ([self.formTable.formSections containsObject:self]) {
            if ([[change objectForKey:NSKeyValueChangeKindKey] isEqualToNumber:@(NSKeyValueChangeInsertion)]){
                NSIndexSet * indexSet = [change objectForKey:NSKeyValueChangeIndexesKey];
                YHFormRow * formRow = [((YHFormSection *)object).formRows objectAtIndex:indexSet.firstIndex];
                NSUInteger sectionIndex = [self.formTable.formSections indexOfObject:object];
                [self.formTable.delegate formRowHasBeenAdded:formRow atIndexPath:[NSIndexPath indexPathForRow:indexSet.firstIndex inSection:sectionIndex]];
            }
            else if ([[change objectForKey:NSKeyValueChangeKindKey] isEqualToNumber:@(NSKeyValueChangeRemoval)]) {
                NSIndexSet * indexSet = [change objectForKey:NSKeyValueChangeIndexesKey];
                YHFormRow * removedRow = [[change objectForKey:NSKeyValueChangeOldKey] objectAtIndex:0];
                NSUInteger sectionIndex = [self.formTable.formSections indexOfObject:object];
                [self.formTable.delegate formRowHasBeenRemoved:removedRow atIndexPath:[NSIndexPath indexPathForRow:indexSet.firstIndex inSection:sectionIndex]];
            }
        }
    }
}

- (NSUInteger)countOfFormRows {
    return self.formRows.count;
}

- (id)objectInFormRowsAtIndex:(NSUInteger)index {
    return [self.formRows objectAtIndex:index];
}

- (NSArray *)formRowsAtIndexes:(NSIndexSet *)indexes {
    return [self.formRows objectsAtIndexes:indexes];
}

- (void)insertObject:(YHFormRow *)formRow inFormRowsAtIndex:(NSUInteger)index {
    if (index <= self.formRows.count && ![self.formRows containsObject:formRow]) {
        formRow.formSection = self;
        [self.formRows insertObject:formRow atIndex:index];
    }
}

- (void)removeObjectFromFormRowsAtIndex:(NSUInteger)index {
    if (index < self.formRows.count) {
        [self.formRows removeObjectAtIndex:index];
    }
}

- (void)dealloc {
    @try {
        [self removeObserver:self forKeyPath:@"formRows"];
    }
    @catch (NSException * __unused exception) {}
}

#pragma mark - Update

- (void)addFormRow:(YHFormRow *)formRow {
    [self insertObject:formRow inFormRowsAtIndex:self.formRows.count];
}

- (void)addFormRow:(YHFormRow *)formRow atIndex:(NSUInteger)rowIndex {
    [self insertObject:formRow inFormRowsAtIndex:rowIndex];
}

- (void)addFormRow:(YHFormRow *)formRow beforeRow:(YHFormRow *)beforeRow {
    [self insertObject:formRow inFormRowsAtIndex:[self.formRows indexOfObject:beforeRow]];
}

- (void)addFormRow:(YHFormRow *)formRow afterRow:(YHFormRow *)afterRow {
    [self insertObject:formRow inFormRowsAtIndex:[self.formRows indexOfObject:afterRow] + 1];
}

- (void)removeFormRow:(YHFormRow *)formRow {
    if ([self.formRows containsObject:formRow]) {
        [self removeObjectFromFormRowsAtIndex:[self.formRows indexOfObject:formRow]];
    }
}

- (void)removeFormRowAtIndex:(NSUInteger)rowIndex {
    [self removeObjectFromFormRowsAtIndex:rowIndex];
}

#pragma mark - Set

- (void)setFormRows:(NSMutableArray<YHFormRow *> *)formRows {
    _formRows = formRows;
    
    [_formRows enumerateObjectsUsingBlock:^(YHFormRow * _Nonnull formRow, NSUInteger idx, BOOL * _Nonnull stop) {
        formRow.formSection = self;
    }];
}

#pragma mark - Get

- (BOOL)isValid {
    __block BOOL result = YES;
    [self.formRows enumerateObjectsUsingBlock:^(YHFormRow * _Nonnull formRow, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!formRow.isValid) {
            result = NO;
            *stop = YES;
        }
    }];
    return result;
}

- (YHFormRow *)formRowAtIndex:(NSUInteger)rowIndex {
    return rowIndex < self.formRows.count ? self.formRows[rowIndex] : nil;
}

- (NSDictionary *)sectionParameters {
    NSMutableDictionary *sectionParameters = @{}.mutableCopy;
    [self.formRows enumerateObjectsUsingBlock:^(YHFormRow * _Nonnull formRow, NSUInteger idx, BOOL * _Nonnull stop) {
        [formRow.rowParameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [sectionParameters setObject:obj forKey:key];
        }];
    }];
    return sectionParameters.copy;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"formRows" : @"YHFormRow",
             };
}

@end
