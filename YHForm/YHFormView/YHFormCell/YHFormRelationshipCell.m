//
//  YHFormRelationshipCell.m
//  Neptune
//
//  Created by wyh on 2016/12/5.
//  Copyright © 2016年 NEO Capital. All rights reserved.
//

#import "YHFormRelationshipCell.h"
#import "YYModel.h"
#import "YHFormRelationshipPicker.h"

@interface YHFormRelationshipCell ()

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIImageView *arrowRight;

@property (nonatomic, strong) YHFormRelationshipPicker *relationshipPicker;

@property (nonatomic, copy) NSArray<NSDictionary *> *relationshipArray;

@end

@implementation YHFormRelationshipCell

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
    
    self.textField.text = [self relationshipString];
}

- (UIView *)inputView {
    return self.relationshipPicker;
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

- (YHFormRelationshipPicker *)relationshipPicker {
    if (_relationshipPicker) return _relationshipPicker;
    
    __weak typeof(self) wSelf = self;
    _relationshipPicker = [YHFormRelationshipPicker pickerWithRelationship:self.relationshipArray complete:^(NSArray *relationshipArray) {
        __strong typeof(wSelf) sSelf = wSelf;
        
        if (relationshipArray) {
            sSelf.formRow.value = relationshipArray;
        }
        
        [sSelf resignFirstResponder];
        [self.relationshipPicker reset];
    }];
    
    return _relationshipPicker;
}

- (NSArray<NSDictionary *> *)relationshipArray {
    static NSArray *relationshipArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"NTRelationship" ofType:@"json"];
        NSData *jsonData = [[NSData alloc] initWithContentsOfFile:jsonPath];
        relationshipArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    });
    return relationshipArray;
}

- (NSString *)relationshipString {
    if ([self.formRow.value isKindOfClass:[NSArray class]] &&[self.formRow.value count] == 2) {
        return [self.formRow.value lastObject];
    }
    return nil;
}

@end
