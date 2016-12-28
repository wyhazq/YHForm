//
//  YHFormSelector.h
//  YHFormExample
//
//  Created by wyh on 2016/11/20.
//  Copyright © 2016年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHFormSelector : NSObject

@property (nonatomic, strong, nullable) id value;

@property (nonatomic, copy, nullable) NSString *displayText;

+ (nullable instancetype)selectorWithValue:(nullable id)value displayText:(nullable NSString *)displayText;

/**
 *  don't use this to init
 */
- (nullable instancetype)init UNAVAILABLE_ATTRIBUTE;
- (nullable instancetype)new UNAVAILABLE_ATTRIBUTE;

@end
