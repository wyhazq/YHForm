//
//  YHFormRelationshipPicker.m
//  Neptune
//
//  Created by wyh on 2016/12/5.
//  Copyright © 2016年 NEO Capital. All rights reserved.
//

#import "YHFormRelationshipPicker.h"
#import "YHFormConfig.h"

#import "YHFormPickerScrollView.h"
#import "YHFormPickerCell.h"

@interface YHFormRelationshipPicker() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray<NSDictionary *> *relationshipArray;

@property (nonatomic, copy) NSArray<NSString *> *subRelationshipArray;

@property (nonatomic, copy) YHFormRelationshipPickerComplete block;

@property (nonatomic, strong) UIView *horzView;

@property (nonatomic, strong) UIButton *completeButton;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) YHFormPickerScrollView *scrollView;

@property (nonatomic, strong) UITableView *relationshipTableView;

@property (nonatomic, strong) UITableView *subRelationshipTableView;

@property (nonatomic, copy) NSString *relationshipName;

@property (nonatomic, copy) NSString *subRelationshipName;

@end

@implementation YHFormRelationshipPicker

+ (instancetype)pickerWithRelationship:(NSArray<NSDictionary *> *)relationshipArray complete:(YHFormRelationshipPickerComplete)block {
    return [[self alloc] initWithRelationship:relationshipArray complete:block];
}

- (instancetype)initWithRelationship:(NSArray<NSDictionary *> *)relationshipArray complete:(YHFormRelationshipPickerComplete)block
{
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight / 2)];
    if (self) {
        _relationshipArray = relationshipArray;
        _block = block;
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.horzView];
    [self addSubview:self.completeButton];
    [self addSubview:self.titleLabel];
    
    [self addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.relationshipTableView];
    [self.scrollView addSubview:self.subRelationshipTableView];
}

- (void)reset {
    [self.scrollView toPage:0];
    _relationshipName = nil;
    _subRelationshipName = nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([tableView isEqual:self.relationshipTableView]) {
        return self.relationshipArray.count;
    }
    else if ([tableView isEqual:self.subRelationshipTableView]) {
        return self.subRelationshipArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHFormPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YHFormPickerCell class]) forIndexPath:indexPath];
    
    if ([tableView isEqual:self.relationshipTableView]) {
        cell.title = self.relationshipArray[indexPath.row][@"relationshipName"];
    }
    else if ([tableView isEqual:self.subRelationshipTableView]) {
        cell.title = self.subRelationshipArray[indexPath.row];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.scrollView nextPage];
    
    if ([tableView isEqual:self.relationshipTableView]) {
        _relationshipName = self.relationshipArray[indexPath.row][@"relationshipName"];
        _subRelationshipArray = self.relationshipArray[indexPath.row][@"relationshipList"];
        [self.subRelationshipTableView reloadData];
    }
    else if ([tableView isEqual:self.subRelationshipTableView]) {
        _subRelationshipName = self.subRelationshipArray[indexPath.row];
        NSArray *array;
        if (self.relationshipName && self.subRelationshipName) {
            array = @[self.relationshipName, self.subRelationshipName];
        }
        if (self.block) self.block(array);
    }
}

#pragma mark - Action

- (void)completeButtonAction:(UIButton *)button {
    if (self.block) self.block(nil);
}

#pragma mark - Get

- (UIView *)horzView {
    if (_horzView) return _horzView;
    
    _horzView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.6)];
    _horzView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    return _horzView;
}

- (UIButton *)completeButton {
    if (_completeButton) return _completeButton;
    
    _completeButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 50, 0, 50, 44)];
    _completeButton.titleLabel.font = [UIFont formDefaultFont];
    [_completeButton setTitleColor:[UIColor formTintColor] forState:UIControlStateNormal];
    [_completeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_completeButton setTitle:@"完成" forState:UIControlStateNormal];
    [_completeButton addTarget:self action:@selector(completeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return _completeButton;
}


- (UILabel *)titleLabel {
    if (_titleLabel) return _titleLabel;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth * 0.2, 0, ScreenWidth * 0.6, 44)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:15.f];
    _titleLabel.textColor = [UIColor formTextColor];
    _titleLabel.text = @"请选择关系";
    return _titleLabel;
}

- (YHFormPickerScrollView *)scrollView {
    if (_scrollView) return _scrollView;
    
    _scrollView = [[YHFormPickerScrollView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, CGRectGetHeight(self.bounds) - 44)];
    _scrollView.contentSize = CGSizeMake(3 * ScreenWidth, CGRectGetHeight(self.bounds) - 44);
    return _scrollView;
}

- (UITableView *)relationshipTableView {
    if (_relationshipTableView) return _relationshipTableView;
    
    _relationshipTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(self.scrollView.bounds))];
    _relationshipTableView.delegate = self;
    _relationshipTableView.dataSource = self;
    _relationshipTableView.tableFooterView = [[UIView alloc] init];
    [_relationshipTableView registerClass:[YHFormPickerCell class] forCellReuseIdentifier:NSStringFromClass([YHFormPickerCell class])];
    return _relationshipTableView;
}

- (UITableView *)subRelationshipTableView {
    if (_subRelationshipTableView) return _subRelationshipTableView;
    
    _subRelationshipTableView = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, CGRectGetHeight(self.scrollView.bounds))];
    _subRelationshipTableView.delegate = self;
    _subRelationshipTableView.dataSource = self;
    _subRelationshipTableView.tableFooterView = [[UIView alloc] init];
    [_subRelationshipTableView registerClass:[YHFormPickerCell class] forCellReuseIdentifier:NSStringFromClass([YHFormPickerCell class])];
    return _subRelationshipTableView;
}

@end
