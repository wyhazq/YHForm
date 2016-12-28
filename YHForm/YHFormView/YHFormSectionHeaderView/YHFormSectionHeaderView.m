//
//  YHFormSectionHeaderView.m
//  YHFormExample
//
//  Created by wyh on 2016/11/8.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormSectionHeaderView.h"

@implementation YHFormSectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUI];
}

- (void)setUI {

}

- (void)setFormSectionHeader:(YHFormSectionHeader *)formSectionHeader {
    _formSectionHeader = formSectionHeader;
    [self updateData];
}

- (void)updateData {
    if ([self.formSectionHeader.sectionHeaderType isEqualToString:NSStringFromClass([YHFormSectionHeaderView class])]) {
        self.textLabel.text = self.formSectionHeader.text;
        self.detailTextLabel.text = self.formSectionHeader.detailText;
    }
}

@end
