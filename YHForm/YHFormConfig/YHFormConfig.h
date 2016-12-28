//
//  YHFormConfig.h
//  YHFormExample
//
//  Created by wyh on 2016/11/19.
//  Copyright © 2016年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "YHFormUI.h"
#import "YHFormFont.h"
#import "YHFormColor.h"
#import "YHFormCellTypeConst.h"

@interface YHFormConfig : NSObject

+ (void)configDefaultFormCellHeight:(CGFloat)formCellHeight
                           fontSize:(CGFloat)fontSize
                          tintColor:(UIColor *)tintColor
         cellContentBackgroundColor:(UIColor *)cellContentBackgroundColor
                          textColor:(UIColor *)textColor;

@end
