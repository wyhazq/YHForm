//
//  YHFormIDCardValidDatePicker.m
//  Neptune
//
//  Created by wyh on 2016/12/5.
//  Copyright © 2016年 NEO Capital. All rights reserved.
//

#import "YHFormIDCardValidDatePicker.h"
#import "YHFormConfig.h"

#import "YHFormPickerScrollView.h"

@interface YHFormIDCardValidDatePicker ()

@property (nonatomic, copy) YHFormIDCardValidDatePickerComplete block;

@property (nonatomic, strong) UIView *horzView;

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UIButton *completeButton;

@property (nonatomic, strong) UIButton *longTimeButton;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) YHFormPickerScrollView *scrollView;

@property (nonatomic, strong) UIDatePicker *beginDatePicker;

@property (nonatomic, strong) UIDatePicker *endDatePicker;

@property (nonatomic, strong) NSDate *beignDate;

@property (nonatomic, strong) NSDate *endDate;

@end

@implementation YHFormIDCardValidDatePicker

+ (instancetype)datePicker:(YHFormIDCardValidDatePickerComplete)block {
    return [[self alloc] initWithBlock:block];
}

- (instancetype)initWithBlock:(YHFormIDCardValidDatePickerComplete)block
{
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, 250.f)];
    if (self) {
        _block = block;
        [self setUI];
    }
    return self;
}

- (void)setCurrentDate:(NSDate *)currentDate {
    _currentDate = currentDate;
    _beignDate = _currentDate;
    _endDate = _currentDate;
    self.titleLabel.text = @"请选择开始日期";
    [self.scrollView toPage:0];
    if ([self.subviews containsObject:self.longTimeButton]) {
        [self.longTimeButton removeFromSuperview];
    }
}

- (void)setUI {
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.horzView];
    [self addSubview:self.backButton];
    [self addSubview:self.completeButton];
    [self addSubview:self.titleLabel];
    
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.beginDatePicker];
    [self.scrollView addSubview:self.endDatePicker];
}

#pragma mark - Action

- (void)backButtonAction:(UIButton *)button {
    if (self.block) self.block(nil);
}

- (void)completeButtonAction:(UIButton *)button {
    if (self.scrollView.pageIndex == 0) {
        [self.scrollView nextPage];
        self.titleLabel.text = @"请选择结束日期";
        [self addSubview:self.longTimeButton];
    }
    else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *beginDateString = [dateFormatter stringFromDate:self.beignDate];
        NSString *endDateString = [dateFormatter stringFromDate:self.endDate];
        if (beginDateString && endDateString) {
            if (self.block) self.block(@[beginDateString, endDateString]);
        }
    }
}

- (void)longTimeButtonAction:(UIButton *)longTimeButton {
    _endDate = [self dateByAddingYears:50];
    
    [self.completeButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void)beginDatePickerValueChanged:(UIDatePicker *)datePicker {
    _beignDate = datePicker.date;
}

- (void)endDatePickerValueChanged:(UIDatePicker *)datePicker {
    _endDate = datePicker.date;
}


#pragma mark - Get

- (UIView *)horzView {
    if (_horzView) return _horzView;
    
    _horzView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.6)];
    _horzView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    return _horzView;
}

- (UIButton *)backButton {
    if (_backButton) return _backButton;
    
    _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    _backButton.titleLabel.font = [UIFont formDefaultFont];
    [_backButton setTitleColor:[UIColor formTextColor] forState:UIControlStateNormal];
    [_backButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_backButton setTitle:@"取消" forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return _backButton;
}

- (UIButton *)completeButton {
    if (_completeButton) return _completeButton;
    
    _completeButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 50, 0, 50, 44)];
    _completeButton.titleLabel.font = [UIFont formDefaultFont];
    [_completeButton setTitleColor:[UIColor formTintColor] forState:UIControlStateNormal];
    [_completeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_completeButton setTitle:@"确定" forState:UIControlStateNormal];
    [_completeButton addTarget:self action:@selector(completeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return _completeButton;
}

- (UIButton *)longTimeButton {
    if (_longTimeButton) return _longTimeButton;
    
    _longTimeButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 100, 0, 50, 44)];
    _longTimeButton.titleLabel.font = [UIFont formDefaultFont];
    [_longTimeButton setTitleColor:[UIColor formTintColor] forState:UIControlStateNormal];
    [_longTimeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_longTimeButton setTitle:@"长期" forState:UIControlStateNormal];
    [_longTimeButton addTarget:self action:@selector(longTimeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return _longTimeButton;
}


- (UILabel *)titleLabel {
    if (_titleLabel) return _titleLabel;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth * 0.2, 0, ScreenWidth * 0.6, 44)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:15.f];
    _titleLabel.textColor = [UIColor formTextColor];
    _titleLabel.text = @"请选择开始日期";
    return _titleLabel;
}

- (YHFormPickerScrollView *)scrollView {
    if (_scrollView) return _scrollView;
    
    _scrollView = [[YHFormPickerScrollView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, CGRectGetHeight(self.bounds) - 44)];
    _scrollView.contentSize = CGSizeMake(2 * ScreenWidth, CGRectGetHeight(self.bounds) - 44);
    return _scrollView;
}

-(UIDatePicker *)beginDatePicker {
    if (_beginDatePicker) return _beginDatePicker;
    
    _beginDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, CGRectGetHeight(self.bounds) - 20)];
    _beginDatePicker.datePickerMode = UIDatePickerModeDate;
    [_beginDatePicker addTarget:self action:@selector(beginDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    return _beginDatePicker;
}

- (UIDatePicker *)endDatePicker {
    if (_endDatePicker) return _endDatePicker;
    
    _endDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(ScreenWidth, 20, ScreenWidth, CGRectGetHeight(self.bounds) - 20)];
    _endDatePicker.datePickerMode = UIDatePickerModeDate;
    [_endDatePicker addTarget:self action:@selector(endDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    return _endDatePicker;
}

- (NSDate *)dateByAddingYears:(NSInteger)dYears {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:dYears];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    return newDate;
}



@end
