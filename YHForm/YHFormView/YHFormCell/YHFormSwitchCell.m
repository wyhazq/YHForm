//
//  YHFormSwitchCell.m
//  YHFormExample
//
//  Created by wyh on 2016/11/19.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormSwitchCell.h"

@interface YHFormSwitchCell ()

@property (nonatomic, strong) UISwitch *switchControl;

@end

@implementation YHFormSwitchCell

- (void)setUI {
    [super setUI];
    
    [self.bgView addSubview:self.switchControl];
    
    [self.switchControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(@-10);
    }];
}

- (void)updateData {
    [super updateData];
    
    self.switchControl.on = self.formRow.isSwitchReverse ? ![ToFormString(self.formRow.value) boolValue] : [self.formRow.value boolValue];
}

#pragma mark - Action

- (void)switchControlValueChanged:(UISwitch *)switchControl {
    //已编辑
    self.formRow.formSection.formTable.formData.edited = YES;
    
    self.formRow.value = self.formRow.isSwitchReverse ? @(!self.switchControl.on) : @(self.switchControl.on);
    
    if ([self.formRow.formSection.formTable.delegate respondsToSelector:@selector(formRow:switchControlValueChange:)]) {
        [self.formRow.formSection.formTable.delegate formRow:self.formRow switchControlValueChange:switchControl];
    }
}

#pragma mark - Get

- (UISwitch *)switchControl {
    if (_switchControl) return _switchControl;
    
    _switchControl = [[UISwitch alloc] init];
    _switchControl.onTintColor = [UIColor formTintColor];
    [_switchControl addTarget:self action:@selector(switchControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    return _switchControl;
}

@end
