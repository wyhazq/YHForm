//
//  YHFormSegmentCell.m
//  Neptune
//
//  Created by wyh on 2016/11/24.
//  Copyright © 2016年 NEO Capital. All rights reserved.
//

#import "YHFormSegmentCell.h"

@interface YHFormSegmentCell ()

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@end

@implementation YHFormSegmentCell

- (void)setUI {
    [super setUI];
    
    [self.bgView addSubview:self.segmentedControl];
    
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(@-10);
    }];
    
}

- (void)updateData {
    [super updateData];
    
    [self.segmentedControl removeAllSegments];
    
    [self.formRow.formSelectors enumerateObjectsUsingBlock:^(YHFormSelector * _Nonnull formSelector, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.segmentedControl insertSegmentWithTitle:formSelector.displayText atIndex:idx animated:NO];
        [self.segmentedControl setWidth:(12 * formSelector.displayText.length + 30) forSegmentAtIndex:idx];
    }];
    
    __block NSInteger selectedIndex = 0;
    
    [self.formRow.formSelectors enumerateObjectsUsingBlock:^(YHFormSelector * _Nonnull formSelector, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([formSelector.value integerValue] == [self.formRow.value integerValue]) {
            selectedIndex = idx;
        }
    }];
    self.segmentedControl.selectedSegmentIndex = self.formRow.value ? selectedIndex : 0;
}


#pragma mark - Action

- (void)segmentedControlValueChange:(UISegmentedControl *)segmentedControl {
    //已编辑
    self.formRow.formSection.formTable.formData.edited = YES;
    
    self.formRow.value = self.formRow.formSelectors[segmentedControl.selectedSegmentIndex].value;
}

#pragma mark - Get

- (UISegmentedControl *)segmentedControl {
    if (_segmentedControl) return _segmentedControl;
    
    _segmentedControl = [[UISegmentedControl alloc] init];
    _segmentedControl.tintColor = [UIColor formTintColor];
    [_segmentedControl addTarget:self action:@selector(segmentedControlValueChange:) forControlEvents:UIControlEventValueChanged];
    return _segmentedControl;
}

@end
