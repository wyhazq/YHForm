//
//  YHFormTitleDetailCell.m
//  Neptune
//
//  Created by wyh on 2016/11/24.
//  Copyright © 2016年 NEO Capital. All rights reserved.
//

#import "YHFormTitleDetailCell.h"

@interface YHFormTitleDetailCell ()

@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation YHFormTitleDetailCell

- (void)setUI {
    [super setUI];
    [self.bgView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.left.equalTo(self.titleView.mas_right).offset(10);
        make.right.equalTo(@-4);
    }];
}

- (void)updateData {
    [super updateData];
    
    self.detailLabel.text = ToFormString(self.formRow.value);
    
    if (self.formRow.suffixText && self.detailLabel.text.length > 0 && ![self.detailLabel.text hasSuffix:self.formRow.suffixText]) {
        self.detailLabel.text = [self.detailLabel.text stringByAppendingString:self.formRow.suffixText];
    }
}

#pragma mark - Get

- (UILabel *)detailLabel {
    if (_detailLabel) return _detailLabel;
    
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.font = [UIFont formDefaultFont];
    _detailLabel.textColor = [UIColor formTextColor];
    return _detailLabel;
}

@end
