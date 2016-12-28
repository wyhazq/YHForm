//
//  YHFormSection.h
//  YHFormExample
//
//  Created by wyh on 2016/11/8.
//  Copyright © 2016年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class YHFormTable;
@class YHFormSectionHeader;
@class YHFormRow;
@class YHFormSectionFooter;

@interface YHFormSection : NSObject

//Init
+(nonnull instancetype)formSection;

//Data
@property (nonatomic, strong, nullable) YHFormSectionHeader *formSectionHeader;

@property (nonatomic, strong, nullable) NSMutableArray<YHFormRow *> *formRows;

@property (nonatomic, strong, nullable) YHFormSectionFooter *formSectionFooter;

@property (weak, null_unspecified) YHFormTable * formTable;

@property (nonatomic, readonly, nullable) NSDictionary *sectionParameters;

//Check Valid
@property (nonatomic, readonly, getter=isValid) BOOL valid;

//Update
-(void)addFormRow:(nonnull YHFormRow *)formRow;
-(void)addFormRow:(nonnull YHFormRow *)formRow atIndex:(NSUInteger)rowIndex;
-(void)addFormRow:(nonnull YHFormRow *)formRow afterRow:(nonnull YHFormRow *)afterRow;
-(void)addFormRow:(nonnull YHFormRow *)formRow beforeRow:(nonnull YHFormRow *)beforeRow;

-(void)removeFormRow:(nonnull YHFormRow *)formRow;
-(void)removeFormRowAtIndex:(NSUInteger)rowIndex;

//Get
- (nullable YHFormRow *)formRowAtIndex:(NSUInteger)rowIndex;

@end
