//
//  YHFormTable.m
//  YHFormExample
//
//  Created by wyh on 2016/11/8.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormTable.h"

#import "YHFormData.h"
#import "YHFormTableHeader.h"
#import "YHFormSection.h"
#import "YHFormRow.h"
#import "YHFormTableFooter.h"

@interface YHFormTable ()

@end

@implementation YHFormTable

#pragma mark - Init

+ (instancetype)formTable {
    return [self formTableWithTitle:nil];
}

+ (instancetype)formTableWithTitle:(NSString *)title {
    return [self formTableWithTitle:title buttonTitle:nil];
}

+ (instancetype)formTableWithTitle:(NSString *)title buttonTitle:(NSString *)buttonTitle {
    return [[self alloc] initWithTitle:title buttonTitle:buttonTitle];
}

- (instancetype)init {
    return [self initWithTitle:nil buttonTitle:nil];
}

- (instancetype)initWithTitle:(NSString *)title buttonTitle:(NSString *)buttonTitle {
    self = [super init];
    if (self) {
        _title = title;
        _buttonTitle = buttonTitle;
        _tableViewStyle = UITableViewStyleGrouped;
        _separatorStyle = UITableViewCellSeparatorStyleNone;
        _formSections = @[].mutableCopy;
        [self addObserver:self forKeyPath:@"formSections" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:0];
    }
    return self;
}

#pragma mark - KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (!self.delegate) return;
    if ([keyPath isEqualToString:@"formSections"]){
        if ([[change objectForKey:NSKeyValueChangeKindKey] isEqualToNumber:@(NSKeyValueChangeInsertion)]){
            NSIndexSet *indexSet = [change objectForKey:NSKeyValueChangeIndexesKey];
            YHFormSection *section = [self.formSections objectAtIndex:indexSet.firstIndex];
            if ([self.delegate respondsToSelector:@selector(formSectionHasBeenAdded:atIndex:)]) {
                [self.delegate formSectionHasBeenAdded:section atIndex:indexSet.firstIndex];
            }
        }
        else if ([[change objectForKey:NSKeyValueChangeKindKey] isEqualToNumber:@(NSKeyValueChangeRemoval)]){
            NSIndexSet *indexSet = [change objectForKey:NSKeyValueChangeIndexesKey];
            YHFormSection *removedSection = [[change objectForKey:NSKeyValueChangeOldKey] objectAtIndex:0];
            if ([self.delegate respondsToSelector:@selector(formSectionHasBeenRemoved:atIndex:)]) {
                [self.delegate formSectionHasBeenRemoved:removedSection atIndex:indexSet.firstIndex];
            }
        }
    }
}

- (NSUInteger)countOfFormSections {
    return self.formSections.count;
}

- (id)objectInFormSectionsAtIndex:(NSUInteger)index {
    return [self.formSections objectAtIndex:index];
}

- (NSArray *)formSectionsAtIndexes:(NSIndexSet *)indexes {
    return [self.formSections objectsAtIndexes:indexes];
}

- (void)insertObject:(YHFormSection *)formSection inFormSectionsAtIndex:(NSUInteger)index {
    if (index <= self.formSections.count) {
        formSection.formTable = self;
        [self.formSections insertObject:formSection atIndex:index];
    }
}

- (void)removeObjectFromFormSectionsAtIndex:(NSUInteger)index {
    if (index <= self.formSections.count) {
        [self.formSections removeObjectAtIndex:index];
    }
}

- (void)dealloc {
    @try {
        [self removeObserver:self forKeyPath:@"formSections"];
    }
    @catch (NSException * __unused exception) {}
}

#pragma mark - Update

- (void)addFormSection:(YHFormSection *)formSection {
    [self insertObject:formSection inFormSectionsAtIndex:self.formSections.count];
}

- (void)addFormSection:(YHFormSection *)formSection atIndex:(NSUInteger)sectionIndex {
    [self insertObject:formSection inFormSectionsAtIndex:sectionIndex];
}

- (void)removeFormSection:(YHFormSection *)formSection {
    if ([self.formSections containsObject:formSection]) {
        [self removeObjectFromFormSectionsAtIndex:[self.formSections indexOfObject:formSection]];
    }
}

- (void)removeFormSectionAtIndex:(NSUInteger)sectionIndex {
    [self removeObjectFromFormSectionsAtIndex:sectionIndex];
}

- (void)addFormRow:(YHFormRow *)formRow beforeRow:(YHFormRow *)beforeRow {
    if (beforeRow.formSection) {
        [beforeRow.formSection addFormRow:formRow beforeRow:beforeRow];
    }
    else {
        [[self.formSections lastObject] addFormRow:formRow beforeRow:beforeRow];
    }
}

- (void)addFormRow:(YHFormRow *)formRow afterRow:(YHFormRow *)afterRow {
    if (afterRow.formSection){
        [afterRow.formSection addFormRow:formRow afterRow:afterRow];
    }
    else{
        [[self.formSections lastObject] addFormRow:formRow afterRow:afterRow];
    }
}

-(void)removeFormRow:(YHFormRow *)formRow {
    for (YHFormSection * formSection in self.formSections){
        if ([formSection.formRows containsObject:formRow]){
            [formSection removeFormRow:formRow];
        }
    }
}

#pragma mark - Set

- (void)setFormSections:(NSMutableArray<YHFormSection *> *)formSections {
    _formSections = formSections;
    
    [_formSections enumerateObjectsUsingBlock:^(YHFormSection * _Nonnull formSection, NSUInteger idx, BOOL * _Nonnull stop) {
        formSection.formTable = self;
    }];
}

#pragma mark - Get

- (BOOL)isValid {
    __block BOOL result = YES;
    [self.formSections enumerateObjectsUsingBlock:^(YHFormSection * _Nonnull formSection, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!formSection.isValid) {
            result = NO;
            *stop = YES;
        }
    }];
    return result;
}

- (YHFormSection *)formSectionAtIndex:(NSUInteger)sectionIndex {
    return sectionIndex < self.formSections.count ? self.formSections[sectionIndex] : nil;
}

-(YHFormRow *)formRowAtIndex:(NSIndexPath *)indexPath {
    if ((self.formSections.count > indexPath.section) && [[self.formSections objectAtIndex:indexPath.section] formRows].count > indexPath.row){
        return [[[self.formSections objectAtIndex:indexPath.section] formRows] objectAtIndex:indexPath.row];
    }
    return nil;
}

- (YHFormRow *)formRowForKey:(NSString *)key {
    __block YHFormRow *returnFormRow;
    if (key.length > 0) {
        [self.formSections enumerateObjectsUsingBlock:^(YHFormSection * _Nonnull formSection, NSUInteger idx, BOOL * _Nonnull stop0) {
            [formSection.formRows enumerateObjectsUsingBlock:^(YHFormRow * _Nonnull formRow, NSUInteger idx, BOOL * _Nonnull stop1) {
                if ([formRow.key isKindOfClass:[NSArray class]]) {
                    if ([formRow.key containsObject:key]) {
                        returnFormRow = formRow;
                        *stop1 = YES;
                        *stop0 = YES;
                    }
                }
                else if ([formRow.key isKindOfClass:[NSString class]]) {
                    if ([formRow.key isEqualToString:key]) {
                        returnFormRow = formRow;
                        *stop1 = YES;
                        *stop0 = YES;
                    }
                }
            }];
        }];
    }
    return returnFormRow;
}

- (YHFormRow *)nextRowDescriptorForRow:(YHFormRow *)currentRow {
    NSUInteger indexOfRow = [currentRow.formSection.formRows indexOfObject:currentRow];
    if (indexOfRow != NSNotFound){
        if (indexOfRow + 1 < currentRow.formSection.formRows.count){
            return [currentRow.formSection.formRows objectAtIndex:++indexOfRow];
        }
        else{
            NSUInteger sectionIndex = [self.formSections indexOfObject:currentRow.formSection];
            NSUInteger numberOfSections = [self.formSections count];
            if (sectionIndex != NSNotFound && sectionIndex < numberOfSections - 1){
                sectionIndex++;
                YHFormSection * formSection;
                while ([[(formSection = [currentRow.formSection.formTable.formSections objectAtIndex:sectionIndex]) formRows] count] == 0 && sectionIndex < numberOfSections - 1){
                    sectionIndex++;
                }
                return [formSection.formRows firstObject];
            }
        }
    }
    return nil;
}

- (YHFormRow *)previousRowDescriptorForRow:(YHFormRow *)currentRow {
    NSUInteger indexOfRow = [currentRow.formSection.formRows indexOfObject:currentRow];
    if (indexOfRow != NSNotFound){
        if (indexOfRow > 0 ){
            return [currentRow.formSection.formRows objectAtIndex:--indexOfRow];
        }
        else{
            NSUInteger sectionIndex = [self.formSections indexOfObject:currentRow.formSection];
            if (sectionIndex != NSNotFound && sectionIndex > 0){
                sectionIndex--;
                YHFormSection * formSection;
                while ([[(formSection = [currentRow.formSection.formTable.formSections objectAtIndex:sectionIndex]) formRows] count] == 0 && sectionIndex > 0 ){
                    sectionIndex--;
                }
                return [formSection.formRows lastObject];
            }
        }
    }
    return nil;
}

-(NSIndexPath *)indexPathOfFormRow:(YHFormRow *)formRow {
    YHFormSection * section = formRow.formSection;
    if (section){
        NSUInteger sectionIndex = [self.formSections indexOfObject:section];
        if (sectionIndex != NSNotFound){
            NSUInteger rowIndex = [section.formRows indexOfObject:formRow];
            if (rowIndex != NSNotFound){
                return [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
            }
        }
    }
    return nil;
}

- (NSArray<YHFormRow *> *)allFormRows {
    NSMutableArray<YHFormRow *> *allFormRows = @[].mutableCopy;
    [self.formSections enumerateObjectsUsingBlock:^(YHFormSection * _Nonnull formSection, NSUInteger idx, BOOL * _Nonnull stop) {
        [allFormRows addObjectsFromArray:formSection.formRows];
    }];
    return allFormRows;
}

- (NSDictionary *)tableParameters {
    NSMutableDictionary *tableParameters = @{}.mutableCopy;
    [self.formSections enumerateObjectsUsingBlock:^(YHFormSection * _Nonnull formSection, NSUInteger idx, BOOL * _Nonnull stop) {
        [formSection.sectionParameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [tableParameters setObject:obj forKey:key];
        }];
    }];
    return tableParameters.copy;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"formSections" : @"YHFormSection",
             };
}

@end
