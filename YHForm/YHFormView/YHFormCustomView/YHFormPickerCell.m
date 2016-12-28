//
//  YHFormPickerCell.m
//  YHFormExample
//
//  Created by wyh on 2016/11/21.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormPickerCell.h"
#import "YHFormConfig.h"

@interface YHFormPickerCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation YHFormPickerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (UILabel *)titleLabel {
    if (_titleLabel) return _titleLabel;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.contentView.bounds.size.height)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont formDefaultFont];
    _titleLabel.textColor = [UIColor formTextColor];
    return _titleLabel;
}

@end

