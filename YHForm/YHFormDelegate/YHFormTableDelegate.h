//
//  YHFormTableDelegate.h
//  YHFormExample
//
//  Created by wyh on 2016/11/8.
//  Copyright © 2016年 . All rights reserved.
//

#ifndef YHFormTableDelegate_h
#define YHFormTableDelegate_h

@class YHFormSection;
@class YHFormRow;

@protocol YHFormTableDelegate <NSObject>

@required

- (void)formSectionHasBeenRemoved:(YHFormSection *)formSection atIndex:(NSUInteger)index;
- (void)formSectionHasBeenAdded:(YHFormSection *)formSection atIndex:(NSUInteger)index;
- (void)formRowHasBeenAdded:(YHFormRow *)formRow atIndexPath:(NSIndexPath *)indexPath;
- (void)formRowHasBeenRemoved:(YHFormRow *)formRow atIndexPath:(NSIndexPath *)indexPath;
- (void)formRowHasChanged:(YHFormRow *)formRow oldValue:(id)oldValue newValue:(id)newValue;

@optional

- (void)formRow:(YHFormRow *)formRow buttonAction:(UIButton *)button;

- (void)formRow:(YHFormRow *)formRow switchControlValueChange:(UISwitch *)switchControl;

- (void)formRow:(YHFormRow *)formRow editing:(UITextField *)textField;
- (void)formRow:(YHFormRow *)formRow endEdit:(UITextField *)textField;

@end

#endif /* YHFormTableDelegate_h */
