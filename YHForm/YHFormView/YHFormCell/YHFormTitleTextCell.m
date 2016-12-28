//
//  YHFormTitleTextCell.m
//  YHFormExample
//
//  Created by wyh on 2016/11/19.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormTitleTextCell.h"
#import "APNumberPad.h"

@interface YHFormTitleTextCell () <UITextFieldDelegate, APNumberPadDelegate>

@property (nonatomic, strong) UITextField *textField;

@end

@implementation YHFormTitleTextCell

- (void)setUI {
    [super setUI];
    
    [self.bgView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.left.equalTo(self.titleView.mas_right).offset(10);
        make.right.equalTo(@-4);
    }];
    
}

- (void)updateData {
    [super updateData];
    
    self.textField.placeholder = self.formRow.placeholder ?: [@"请输入" stringByAppendingString:self.formRow.title.clearSpacing];
    self.textField.text = self.formRow.textDisplayString;
    self.textField.text = [self.textField.text formatAddSuffixText:self.formRow.suffixText];
    
    [self changeKeyboardType];
    
}

- (void)changeKeyboardType {
    switch (self.formRow.keyboardType) {
        case YHKeyboardTypeHomePhone:
        case YHKeyboardTypeIDCard: {
            self.textField.inputView = ({
                APNumberPad *numberPad = [APNumberPad numberPadWithDelegate:self];
                [numberPad.leftFunctionButton setTitle:self.formRow.customKeyboardKeyString forState:UIControlStateNormal];
                numberPad;
            });
        }
            break;
            
        case YHKeyboardTypePassWord: {
            self.textField.secureTextEntry = YES;
            self.textField.keyboardType = UIKeyboardTypeASCIICapable;
        }
            break;
            
        default: {
            self.textField.keyboardType = (UIKeyboardType)self.formRow.keyboardType;
            self.textField.inputView = nil;
        }
            break;
    }
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //已编辑
    self.formRow.formSection.formTable.formData.edited = YES;
    
    self.titleView.titleColor = [UIColor formTintColor];
    textField.text = [textField.text formatClearSuffixText:self.formRow.suffixText];
    if (self.formRow.clearValueWhenBecomeFirstResponder) {
        textField.text = nil;
    }
}

- (void)textFieldEditing:(UITextField *)textField {
        
    if ([self.formRow.formSection.formTable.delegate respondsToSelector:@selector(formRow:editing:)]) {
        [self.formRow.formSection.formTable.delegate formRow:self.formRow editing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.titleView.titleColor = [UIColor formTextColor];
    
    textField.text = [textField.text formatTextFieldEndEditing:self.formRow];
    
    self.formRow.value = [textField.text formatValue:self.formRow];
    
    if ([self.formRow.formSection.formTable.delegate respondsToSelector:@selector(formRow:endEdit:)]) {
        [self.formRow.formSection.formTable.delegate formRow:self.formRow endEdit:textField];
    }
    
    textField.text = [textField.text formatAddSuffixText:self.formRow.suffixText];
}

- (void)numberPad:(APNumberPad *)numberPad functionButtonAction:(UIButton *)functionButton textInput:(UIResponder<UITextInput> *)textInput {
    [functionButton setTitle:functionButton.currentTitle forState:UIControlStateNormal];
    if (self.formRow.customKeyboardKeyString) {
        [textInput insertText:self.formRow.customKeyboardKeyString];
    }
}

#pragma mark - Get

- (UITextField *)textField {
    if (_textField) return _textField;
    
    _textField = [[UITextField alloc] init];
    _textField.font = [UIFont formDefaultFont];
    _textField.textColor = [UIColor formTextColor];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.delegate = self;
    
    [_textField addTarget:self action:@selector(textFieldEditing:) forControlEvents:UIControlEventEditingChanged];
    
    return _textField;
}

@end
