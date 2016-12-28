//
//  YHFormUI.h
//  YHFormExample
//
//  Created by wyh on 2016/11/14.
//  Copyright © 2016年 . All rights reserved.
//

#ifndef YHFormUI_h
#define YHFormUI_h

#import <UIKit/UIKit.h>

#ifndef ScreenWidth
#define ScreenWidth   [UIScreen mainScreen].bounds.size.width
#endif

#ifndef ScreenHeight
#define ScreenHeight   [UIScreen mainScreen].bounds.size.height
#endif

#ifndef ScreenSize
#define ScreenSize   [UIScreen mainScreen].bounds.size
#endif

#ifndef NaviHeight
#define NaviHeight   (64.f)
#endif

@interface YHFormUI : NSObject

+ (void)configFormCellHeight:(CGFloat)formCellHeight;

+ (CGFloat)formCellHeight;

@end

#endif /* YHFormUI_h */


