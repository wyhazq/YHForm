//
//  YHFormTextCell.m
//  YHFormExample
//
//  Created by wyh on 2016/11/19.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormTextCell.h"
#import "JVFloatLabeledTextField.h"
#import "APNumberPad.h"

static const CGFloat kFloatingLabelFontSize = 10.0f;

@interface YHFormTextCell () <UITextFieldDelegate, APNumberPadDelegate>

@property (nonatomic, strong, nullable) JVFloatLabeledTextField *textField;

@end

@implementation YHFormTextCell


- (void)setUI {
    [super setUI];
    
    [self.bgView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(2, 10, 0, 0));
    }];
    
}

- (void)updateData {
    [super updateData];
    
    self.textField.placeholder = self.formRow.placeholder ?: [@"请输入" stringByAppendingString:self.formRow.title.clearSpacing];
    self.textField.text = ToFormString(self.formRow.value);
    self.textField.text = [self.textField.text formatAddSuffixText:self.formRow.suffixText];
    
    self.textField.floatingLabel.text = self.formRow.title;
    
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
        }
            break;
    }
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //已编辑
    self.formRow.formSection.formTable.formData.edited = YES;
    
    textField.text = [textField.text formatClearSuffixText:self.formRow.suffixText];
    
    return YES;
}

- (void)textFieldEditing:(UITextField *)textField {
    
//    textField.text = [textField.text formatTextFieldEditing:self.formRow];
    
    if ([self.formRow.formSection.formTable.delegate respondsToSelector:@selector(formRow:editing:)]) {
        [self.formRow.formSection.formTable.delegate formRow:self.formRow editing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    textField.text = [textField.text formatTextFieldEndEditing:self.formRow];
    
    self.formRow.value = textField.text;
    
    if ([self.formRow.formSection.formTable.delegate respondsToSelector:@selector(formRow:endEdit:)]) {
        [self.formRow.formSection.formTable.delegate formRow:self.formRow endEdit:textField];
    }
    
    textField.text = [textField.text formatAddSuffixText:self.formRow.suffixText];
}

- (void)numberPad:(APNumberPad *)numberPad functionButtonAction:(UIButton *)functionButton textInput:(UIResponder<UITextInput> *)textInput {
    [functionButton setTitle:functionButton.currentTitle forState:UIControlStateNormal];
    [textInput insertText:self.formRow.customKeyboardKeyString];
}

#pragma mark - Get

- (JVFloatLabeledTextField *)textField {
    if (_textField) return _textField;
    
    _textField = [[JVFloatLabeledTextField alloc] init];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _textField.font = [UIFont formDefaultFont];
    _textField.textColor = [UIColor formTextColor];
    _textField.delegate = self;
    
    _textField.floatingLabel.font = [UIFont boldSystemFontOfSize:kFloatingLabelFontSize];
    _textField.floatingLabelTextColor = [UIColor formTextColor];
    _textField.floatingLabelActiveTextColor = [UIColor formTintColor];
    
    [_textField addTarget:self action:@selector(textFieldEditing:) forControlEvents:UIControlEventEditingChanged];
    
    return _textField;
}

@end
