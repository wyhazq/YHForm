//
//  YHFormValueFormat.h
//  Neptune
//
//  Created by wyh on 2016/11/24.
//  Copyright © 2016年 NEO Capital. All rights reserved.
//

#import <Foundation/Foundation.h>

//用户输入文字格式化
typedef NS_ENUM(NSUInteger, YHFormValueFormatType) {
    YHFormValueFormatTypeDefault = 0,
    YHFormValueFormatTypeHundred,       //百元
    YHFormValueFormatTypeThousand,      //千元
    YHFormValueFormatTypeTenThousand,   //万元
};

@interface NSString (YHFormValueFormat)

- (NSString *)yh_formatType:(YHFormValueFormatType)formatType;

@end
