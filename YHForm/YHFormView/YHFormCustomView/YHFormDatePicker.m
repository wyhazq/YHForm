//
//  YHFormDatePicker.m
//  YHFormExample
//
//  Created by wyh on 2016/11/21.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormDatePicker.h"
#import "YHFormConfig.h"
#import "YHFormTools.h"

@interface YHFormDatePicker ()

@property (nonatomic, strong) NSDate *currentDate;

@property (nonatomic, strong) NSDate *maxDate;

@property (nonatomic, copy) YHFormDatePickerComplete block;

@property (nonatomic, strong) UIView *horzView;

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UIButton *completeButton;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation YHFormDatePicker

+ (instancetype)datePicker:(YHFormDatePickerComplete)block {
    return [[self alloc] initWithBlock:block];
}

- (instancetype)initWithBlock:(YHFormDatePickerComplete)block
{
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, 250.f)];
    if (self) {
        _block = block;
        [self setUI];
    }
    return self;
}

- (void)setCurrentDateString:(NSString *)currentDateString {
    _currentDate = currentDateString.yhForm_date ? : [NSDate date];
    [self.datePicker setDate:_currentDate];
}

- (void)setMaxDateString:(NSString *)maxDateString {
    _maxDate = maxDateString.yhForm_date;
}

- (void)setUI {
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.datePicker];
    [self addSubview:self.horzView];
    [self addSubview:self.backButton];
    [self addSubview:self.completeButton];
    [self addSubview:self.titleLabel];
}

#pragma mark - Action

- (void)backButtonAction:(UIButton *)button {
    if (self.block) self.block(nil);
}

- (void)completeButtonAction:(UIButton *)button {
    _currentDate = (self.maxDate && [self.currentDate compare:self.maxDate] == NSOrderedAscending) ? self.currentDate : self.maxDate;
    if (self.block) self.block(self.currentDate.yhForm_dateString);
}

- (void)datePickerValueChanged:(UIDatePicker *)datePicker {
    _currentDate = datePicker.date;
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


- (UILabel *)titleLabel {
    if (_titleLabel) return _titleLabel;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth * 0.2, 0, ScreenWidth * 0.6, 44)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:15.f];
    _titleLabel.textColor = [UIColor formTextColor];
    _titleLabel.text = @"请选择日期";
    return _titleLabel;
}

-(UIDatePicker *)datePicker {
    if (_datePicker) return _datePicker;
    
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, CGRectGetHeight(self.bounds) - 20)];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    return _datePicker;
}


@end
