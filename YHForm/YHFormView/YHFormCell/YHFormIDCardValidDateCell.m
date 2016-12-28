//
//  YHFormIDCardValidDateCell.m
//  Neptune
//
//  Created by wyh on 2016/12/5.
//  Copyright © 2016年 NEO Capital. All rights reserved.
//

#import "YHFormIDCardValidDateCell.h"
#import "YHFormIDCardValidDatePicker.h"

@interface YHFormIDCardValidDateCell ()

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIImageView *arrowRight;

@property (nonatomic, strong) YHFormIDCardValidDatePicker *datePicker;

@end

@implementation YHFormIDCardValidDateCell

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
    
    if ([self.formRow.value isKindOfClass:[NSArray class]]) {
        
        NSMutableArray *values = @[].mutableCopy;
        [self.formRow.value enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (ToFormString(obj).length > 0) {
                [values addObject:[ToFormString(obj) formatDate]];
            }
        }];
        self.textField.text = [values componentsJoinedByString:@"~"];
    }
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
        self.datePicker.currentDate = [NSDate date];
        [self becomeFirstResponder];
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

- (YHFormIDCardValidDatePicker *)datePicker {
    if (_datePicker) return _datePicker;
    
    __weak typeof(self) wSelf = self;
    _datePicker = [YHFormIDCardValidDatePicker datePicker:^(NSArray *idCardValidDates) {
        __strong typeof(wSelf) sSelf = wSelf;
        
        if (idCardValidDates) {
            sSelf.formRow.value = idCardValidDates;
        }
        
        [sSelf resignFirstResponder];
    }];
    
    return _datePicker;
}

@end
