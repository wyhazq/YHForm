//
//  YHFormPickerView.h
//  YHFormExample
//
//  Created by wyh on 2016/11/21.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHFormSelector;

typedef void(^YHFormPickerViewComplete)(YHFormSelector *selector);


@interface YHFormPickerView : UIView

+ (instancetype)pickerWithTitle:(NSString *)title selectors:(NSArray<YHFormSelector *> *)selectors complete:(YHFormPickerViewComplete)block;

@end
