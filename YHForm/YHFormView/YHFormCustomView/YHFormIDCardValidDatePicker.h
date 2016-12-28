//
//  YHFormIDCardValidDatePicker.h
//  Neptune
//
//  Created by wyh on 2016/12/5.
//  Copyright © 2016年 NEO Capital. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YHFormIDCardValidDatePickerComplete)(NSArray *idCardValidDates);


@interface YHFormIDCardValidDatePicker : UIView

+ (instancetype)datePicker:(YHFormIDCardValidDatePickerComplete)block;

@property (nonatomic, strong) NSDate *currentDate;

@end
