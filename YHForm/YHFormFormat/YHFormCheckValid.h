//
//  YHFormCheckValid.h
//  Neptune
//
//  Created by wyh on 2016/11/24.
//  Copyright © 2016年 NEO Capital. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YHFormCheckValidType) {
    YHFormCheckValidTypeDefault = 0,
    YHFormCheckValidTypePhone,          //手机号格式
    YHFormCheckValidTypeIDCard,         //身份证格式
    YHFormCheckValidTypeEmail,          //Email格式
    YHFormCheckValidTypeCompanyPhone,   //单位区号号码分机格式
    YHFormCheckValidTypeHomePhone,      //住宅区号号码格式
};

@interface NSString (YHFormCheckValid)

- (BOOL)yh_checkValid:(YHFormCheckValidType)checkValidType;

@end
