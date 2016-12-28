//
//  YHFormSelectorCell.m
//  YHFormExample
//
//  Created by wyh on 2016/11/20.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormSelectorCell.h"
#import "YHFormPickerView.h"

@interface YHFormSelectorCell () <UIAlertViewDelegate>

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIImageView *arrowRight;

@property (nonatomic, strong) YHFormPickerView *pickerView;

@property (nonatomic, strong) UIAlertView *alertView;

@property (nonatomic, strong) YHFormSelector *changeSelector;

@end

@implementation YHFormSelectorCell

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
    self.textField.text = self.formRow.selectorDisplayText;
}

- (UIView *)inputView {
    return self.formRow.isCanSelecte ? self.pickerView : nil;
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

- (YHFormPickerView *)pickerView {
    
    __weak typeof(self) wSelf = self;
    _pickerView = [YHFormPickerView pickerWithTitle:self.formRow.title selectors:self.formRow.formSelectors complete:^(YHFormSelector *selector) {
        __strong typeof(wSelf) sSelf = wSelf;
        [sSelf resignFirstResponder];

        if (![sSelf.formRow isEqualToSelector:selector]) {
            sSelf.changeSelector = selector;
            if (sSelf.formRow.changeValueTips) {
                //坑爹的，不延时的话，又会becomeFirstResponder
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [sSelf.alertView show];
                });
            }
            else {
                [sSelf changeValue];
            }
        }
        
    }];
    
    return _pickerView;
}

- (UIAlertView *)alertView {
    _alertView = [[UIAlertView alloc] initWithTitle:nil message:self.formRow.changeValueTips delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    return _alertView;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != alertView.cancelButtonIndex) {
        [self changeValue];
    }
}

- (void)changeValue {
    if (self.changeSelector) {
        if ([self.formRow.key isKindOfClass:[NSArray class]]) {
            self.formRow.value = @[ToFormString(self.changeSelector.value), ToFormString(self.changeSelector.displayText)];
        }
        else if ([self.formRow.key isKindOfClass:[NSString class]]) {
            self.formRow.value = self.changeSelector.value;
        }
    }
}

@end
