//
//  YHFormAddressPickerCell.m
//  YHFormExample
//
//  Created by wyh on 2016/11/21.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormAddressPickerCell.h"
#import "YHFormAddressPicker.h"

@interface YHFormAddressPickerCell ()

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIImageView *arrowRight;

@property (nonatomic, strong) YHFormAddressPicker *addressPicker;

@property (nonatomic, copy) NSArray<NSDictionary *> *addressArray;

@end

@implementation YHFormAddressPickerCell

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
    
    self.textField.text = [self addressString];
}

- (UIView *)inputView {
    return self.addressPicker;
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
    _arrowRight.image = [UIImage imageNamed:@"ArrowRight.png" inBundle:[NSBundle yh_formBundle] compatibleWithTraitCollection:nil];
    
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

- (YHFormAddressPicker *)addressPicker {
    if (_addressPicker) return _addressPicker;
    
    __weak typeof(self) wSelf = self;
    _addressPicker = [YHFormAddressPicker addressPickerWithAddress:self.addressArray complete:^(NSArray *addressArray) {
        __strong typeof(wSelf) sSelf = wSelf;
        
        if (addressArray) {
            sSelf.formRow.value = addressArray;
        }
        
        [sSelf resignFirstResponder];
        [self.addressPicker reset];
    }];

    return _addressPicker;
}

- (NSArray<NSDictionary *> *)addressArray {
    static NSArray *addressArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //先这样吧，没时间配置了。。。朝耦合度最大的路径走
//        addressArray = [NTCache objectForKey:NTAddressCache];
    });
    return addressArray;
}

- (NSString *)addressString {
    if ([self.formRow.value isKindOfClass:[NSArray class]] &&[self.formRow.value count] == 3) {
        return [self.formRow.value componentsJoinedByString:@" "];
    }
    return nil;
}

@end
