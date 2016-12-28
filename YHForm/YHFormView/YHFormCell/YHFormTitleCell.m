//
//  YHFormTitleCell.m
//  YHFormExample
//
//  Created by wyh on 2016/11/19.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormTitleCell.h"

@implementation YHFormTitleCell

- (void)setUI {
    [super setUI];
    
    [self.bgView addSubview:self.titleView];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(@0);
        make.width.equalTo(@90);
    }];
    [self.titleView setUI];
}

- (void)updateData {

    self.titleView.title = self.formRow.title;
    self.titleView.isRequired = self.formRow.isRequired;
    
}


#pragma mark - Get

- (BOOL)becomeFirstResponder {
    BOOL result = [super becomeFirstResponder];
    
    if (result && self.formRow.isCanSelecte) {
        self.titleView.titleColor = [UIColor formTintColor];
    }
    
    return result;
}

- (BOOL)resignFirstResponder {
    BOOL result = [super resignFirstResponder];
    
    self.titleView.titleColor = [UIColor formTextColor];
    
    return result;
}


#pragma mark - Get

- (YHFormTitleView *)titleView {
    if (_titleView) return _titleView;
    
    _titleView = [[YHFormTitleView alloc] init];
    return _titleView;
}

@end
