//
//  NSBundle+YHForm.h
//  YHFormExample
//
//  Created by wyh on 2016/11/14.
//  Copyright © 2016年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (YHForm)

- (BOOL)yh_containNib:(NSString *)classString;

+ (instancetype)yh_formBundle;

@end
