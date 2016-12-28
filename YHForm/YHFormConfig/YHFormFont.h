//
//  YHFormFont.h
//  YHFormExample
//
//  Created by wyh on 2016/11/19.
//  Copyright © 2016年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YHFormFont : NSObject

+ (void)configFormDefaultFontSize:(CGFloat)fontSize;

+ (CGFloat)formDefaultFontSize;

@end


@interface UIFont (YHFormFont)

+ (instancetype)formDefaultFont;

+ (instancetype)requireLabelFont;

@end
