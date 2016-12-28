//
//  YHFormSelectorButtonCell.m
//  YHFormExample
//
//  Created by wyh on 2016/11/21.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormSelectorButtonCell.h"
#import "YHFormPickerView.h"

@interface YHFormSelectorButtonCell ()

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) YHFormPickerView *pickerView;

@property (nonatomic, strong) UIView *vertLine;

@end

@implementation YHFormSelectorButtonCell

- (void)setUI {
    [super setUI];
    
    [self.bgView addSubview:self.button];
    [self.bgView addSubview:self.textField];
    [self.bgView addSubview:self.vertLine];

    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(@0);
        make.width.equalTo(@88);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.left.equalTo(self.titleView.mas_right).offset(10);
        make.right.equalTo(self.button.mas_left).offset(-1);
    }];
    
    [self.vertLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@8);
        make.bottom.equalTo(@-8);
        make.left.equalTo(self.textField.mas_right).offset(0.6);
        make.width.equalTo(@0.6);
    }];
    
}

- (void)updateData {
    [super updateData];
    
    [self.button setTitle:self.formRow.buttonTitle forState:UIControlStateNormal];
    
    self.textField.placeholder = self.formRow.placeholder ?: [@"请选择" stringByAppendingString:self.formRow.title.clearSpacing];
    self.textField.text = self.formRow.selectorDisplayText;
    
}

- (UIView *)inputView {
    return self.pickerView;
}

- (BOOL)canBecomeFirstResponder {
    
    return YES;
}

#pragma mark - Set

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        [self becomeFirstResponder];
    }
}

#pragma mark - Action

- (void)buttonAction:(UIButton *)button {
    if ([self.formRow.formSection.formTable.delegate respondsToSelector:@selector(formRow:buttonAction:)]) {
        [self.formRow.formSection.formTable.delegate formRow:self.formRow buttonAction:button];
    }
}

#pragma mark - Get

- (UITextField *)textField {
    if (_textField) return _textField;
    _textField = [[UITextField alloc] init];
    _textField.font = [UIFont formDefaultFont];
    _textField.textColor = [UIColor formTextColor];
    _textField.enabled = NO;
    return _textField;
}

- (UIView *)vertLine {
    if (_vertLine) return _vertLine;
    
    _vertLine = [[UIView alloc] init];
    _vertLine.backgroundColor = [UIColor lineColor];
    return _vertLine;
}

- (UIButton *)button {
    if (_button) return _button;
    
    _button = [[UIButton alloc] init];
    _button.titleLabel.font = [UIFont formDefaultFont];
    [_button setTitleColor:[UIColor formTintColor] forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    return _button;
}

- (YHFormPickerView *)pickerView {
    if (_pickerView) return _pickerView;
    
    __weak typeof(self) wSelf = self;
    _pickerView = [YHFormPickerView pickerWithTitle:self.formRow.title selectors:self.formRow.formSelectors complete:^(id value) {
        __strong typeof(wSelf) sSelf = wSelf;
        
        if (value) {
            sSelf.formRow.value = value;
        }
        
        [sSelf resignFirstResponder];
    }];
    
    return _pickerView;
}

@end
