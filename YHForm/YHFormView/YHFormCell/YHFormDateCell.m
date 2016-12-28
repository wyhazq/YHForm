//
//  YHFormDateCell.m
//  YHFormExample
//
//  Created by wyh on 2016/11/21.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormDateCell.h"
#import "YHFormDatePicker.h"

@interface YHFormDateCell ()

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIImageView *arrowRight;

@property (nonatomic, strong) YHFormDatePicker *datePicker;

@end

@implementation YHFormDateCell

- (void)setUI {
    [super setUI];
    
    [self.bgView addSubview:self.arrowRight];
    [self.bgView addSubview:self.textField];
    
    [self.arrowRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(@-10);
        make.width.equalTo(@8);
        make.height.equalTo(@13);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.left.equalTo(self.titleView.mas_right).offset(10);
        make.right.equalTo(self.arrowRight.mas_left).offset(-8);
    }];
}

- (void)updateData {
    [super updateData];
    
    self.textField.placeholder = self.formRow.placeholder;
    self.textField.text = [ToFormString(self.formRow.value) formatDate];
}

- (UIView *)inputView {
    return self.datePicker;
}

- (BOOL)canBecomeFirstResponder {
    
    return YES;
}

#pragma mark - Set

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        [self becomeFirstResponder];
        self.datePicker.currentDateString = self.formRow.value;
    }
}

#pragma mark - Get

- (UIImageView *)arrowRight {
    if (_arrowRight) return _arrowRight;
    _arrowRight = [[UIImageView alloc] init];
    _arrowRight.image = [UIImage imageNamed:@"YHForm.bundle/ArrowRight"];
    
    return _arrowRight;
}

- (UITextField *)textField {
    if (_textField) return _textField;
    _textField = [[UITextField alloc] init];
    _textField.font = [UIFont formDefaultFont];
    _textField.textColor = [UIColor formTextColor];
    _textField.enabled = NO;
    return _textField;
}

- (YHFormDatePicker *)datePicker {
    if (_datePicker) return _datePicker;
    
    __weak typeof(self) wSelf = self;
    _datePicker = [YHFormDatePicker datePicker:^(NSString *dateString) {
        __strong typeof(wSelf) sSelf = wSelf;
        
        if (dateString) {
            sSelf.formRow.value = dateString;
        }
        
        [sSelf resignFirstResponder];

    }];
    
    if (self.formRow.maxDateString) {
        NSString *maxDateString = [self.formRow.maxDateString isEqualToString:@"now"] ? [NSDate date].yhForm_dateString : self.formRow.maxDateString;
        _datePicker.maxDateString = maxDateString;
    }
    
    return _datePicker;
}


@end
