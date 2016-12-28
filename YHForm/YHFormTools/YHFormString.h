//
//  YHFormString.h
//  YHFormExample
//
//  Created by wyh on 2016/11/19.
//  Copyright © 2016年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHFormString : NSObject

NSString *ToFormString(id obj);

//请原谅我放在这里
NSNumber *ToFormNumber(id obj);

@end

@interface NSString (YHFormString)

- (NSString *)clearSpacing;

//1970-1-1
- (NSDate *)yhForm_date;

@end
