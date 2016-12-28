//
//  YHFormTable.h
//  YHFormExample
//
//  Created by wyh on 2016/11/8.
//  Copyright © 2016年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "YHFormDelegate.h"

#import "YHFormData.h"
@class YHFormTableHeader;
@class YHFormSection;
@class YHFormTableFooter;



@interface YHFormTable : NSObject

//Init
+ (nullable instancetype)formTable;
+ (nullable instancetype)formTableWithTitle:(nullable NSString *)title;
+ (nullable instancetype)formTableWithTitle:(nullable NSString *)title buttonTitle:(nullable NSString *)buttonTitle;

//UI
@property (nonatomic, copy, nullable) NSString *title;

@property (nonatomic, assign)UITableViewStyle tableViewStyle;

@property (nonatomic, assign)UITableViewCellSeparatorStyle separatorStyle;

@property (nonatomic, copy, nullable) NSString *buttonTitle;

//Data
@property (nonatomic, strong, nullable) YHFormTableHeader *formTableHeader;

@property (nonatomic, strong, nullable) NSMutableArray<YHFormSection *> *formSections;

@property (nonatomic, strong, nullable) YHFormTableFooter *formTableFooter;

@property (weak, null_unspecified) YHFormData * formData;

@property (nonatomic, readonly, nullable) NSDictionary *tableParameters;

//Update
@property (nonatomic, weak, nullable) id <YHFormTableDelegate> delegate;

- (void)addFormSection:(nonnull YHFormSection *)formSection;
- (void)addFormSection:(nonnull YHFormSection *)formSection atIndex:(NSUInteger)sectionIndex;

- (void)removeFormSectionAtIndex:(NSUInteger)sectionIndex;
- (void)removeFormSection:(nonnull YHFormSection *)formSection;

- (void)addFormRow:(nonnull YHFormRow *)formRow beforeRow:(nonnull YHFormRow *)beforeRow;
- (void)addFormRow:(nonnull YHFormRow *)formRow afterRow:(nonnull YHFormRow *)afterRow;

- (void)removeFormRow:(nonnull YHFormRow *)formRow;

//Get
- (nullable YHFormSection *)formSectionAtIndex:(NSUInteger)sectionIndex;
- (nullable YHFormRow *)formRowAtIndex:(nonnull NSIndexPath *)indexPath;
- (nullable YHFormRow *)formRowForKey:(nonnull NSString *)key;

- (nullable YHFormRow *)nextRowDescriptorForRow:(nonnull YHFormRow *)currentRow;
- (nullable YHFormRow *)previousRowDescriptorForRow:(nonnull YHFormRow *)currentRow;

- (nullable NSIndexPath *)indexPathOfFormRow:(nonnull YHFormRow *)formRow;

@property (nonatomic, readonly, nullable) NSArray<YHFormRow *> *allFormRows;

//Check Valid
@property (nonatomic, readonly, getter=isValid) BOOL valid;

/**
 *  don't use this to init
 */
- (nullable instancetype)init UNAVAILABLE_ATTRIBUTE;
- (nullable instancetype)new UNAVAILABLE_ATTRIBUTE;

@end
