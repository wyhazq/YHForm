//
//  YHFormCell.m
//  YHFormExample
//
//  Created by wyh on 2016/11/8.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormCell.h"

@interface YHFormCell ()

@end

@implementation YHFormCell

#pragma mark - Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUI];
}

#pragma mark - Set

- (void)setFormRow:(YHFormRow *)formRow {
    _formRow = formRow;
    [self updateData];
}

- (void)setUI {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor cellContentBackgroundColor];
    
    [self.contentView addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@10);
        make.bottom.equalTo(@-10);
        make.right.equalTo(@-10);
    }];
    
}

- (void)updateData {

}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    self.bgView.backgroundColor = highlighted ? [UIColor colorWithRed:0.92 green:0.92 blue:0.94 alpha:1] : [UIColor whiteColor];

}

- (BOOL)becomeFirstResponder {
    BOOL result = [super becomeFirstResponder];
    
    //已编辑
    self.formRow.formSection.formTable.formData.edited = YES;
    
    return result;
}

#pragma mark - Get

- (UIView *)bgView {
    if (_bgView) return _bgView;
    
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 4.f;
    return _bgView;
}

@end
