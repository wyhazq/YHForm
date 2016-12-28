//
//  YHFormButton.m
//  NRD
//
//  Created by wyh on 2016/10/14.
//  Copyright © 2016年 深圳市小牛资本管理集团. All rights reserved.
//

#import "YHFormButton.h"
#import "YHFormConfig.h"

@implementation YHFormButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[self imageWithColor:[[UIColor formTintColor] colorWithAlphaComponent:0.7]] forState:UIControlStateHighlighted];
    }
    return self;
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    self.backgroundColor = enabled ? [[UIColor formTintColor] colorWithAlphaComponent:0.9] : [UIColor colorWithWhite:0.82 alpha:0.9];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect =  CGRectMake (0, 0, 1 ,1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef  context =  UIGraphicsGetCurrentContext ();
    CGContextSetFillColorWithColor (context,color.CGColor);
    CGContextFillRect (context, rect);
    UIImage  *img =  UIGraphicsGetImageFromCurrentImageContext ();
    UIGraphicsEndImageContext ();
    return  img;
}


@end
