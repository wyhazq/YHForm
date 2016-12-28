//
//  YHFormDatePicker.h
//  YHFormExample
//
//  Created by wyh on 2016/11/21.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YHFormDatePickerComplete)(NSString *dateString);

@interface YHFormDatePicker : UIView

+ (instancetype)datePicker:(YHFormDatePickerComplete)block;

@property (nonatomic, copy) NSString *currentDateString;

//格式1970-1-1
@property (nonatomic, copy) NSString *maxDateString;

@end
