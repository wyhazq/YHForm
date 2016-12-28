//
//  YHFormTitleView.h
//  YHFormExample
//
//  Created by wyh on 2016/11/19.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHFormTitleView : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, assign) BOOL isRequired;

- (void)setUI;

@end
