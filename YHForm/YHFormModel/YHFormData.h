//
//  YHFormData.h
//  YHFormExample
//
//  Created by wyh on 2016/11/13.
//  Copyright © 2016年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHFormTable;
@class YHFormRow;

typedef NS_ENUM(NSUInteger, YHFormDataEditType) {
    YHFormDataEditTypeDefault = 0,
    YHFormDataEditTypeUpdate,
    YHFormDataEditTypeComplete,
    YHFormDataEditTypeRollback = 999,
};

@interface YHFormData : NSObject

//Init
+ (nullable instancetype)formData;

@property (nonatomic, copy, nullable) NSString *vcTitle;

@property (nonatomic, copy, nullable) NSString *title;

@property (nonatomic, assign) YHFormDataEditType editType;

//查询接口填充数据
@property (nonatomic, strong, nullable) id queryResponse;

//配置Selectors;
@property (nonatomic, copy, nullable) NSDictionary *selectors;

//Data
@property (nonatomic, strong, nullable) NSMutableArray<YHFormTable *> *formTables;

@property (nonatomic, readonly, nullable) NSMutableDictionary *formParameters;

//Check Valid
@property (nonatomic, readonly, getter=isValid) BOOL valid;

//是否编辑
@property (nonatomic, assign, getter=isEdited) BOOL edited;

//Update
- (void)addFormTable:(nullable YHFormTable *)formTable;

//Get
- (nullable YHFormRow *)formRowForKey:(nonnull NSString *)key;

/**
 *  don't use this to init
 */
- (nullable instancetype)init UNAVAILABLE_ATTRIBUTE;
- (nullable instancetype)new UNAVAILABLE_ATTRIBUTE;

@end
