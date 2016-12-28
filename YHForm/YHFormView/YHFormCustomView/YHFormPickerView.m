//
//  YHFormPickerView.m
//  YHFormExample
//
//  Created by wyh on 2016/11/21.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormPickerView.h"
#import "YHFormConfig.h"
#import "YHFormSelector.h"
#import "YHFormPickerCell.h"
#import "YHFormTools.h"

@interface YHFormPickerView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSArray<YHFormSelector *> *selectors;

@property (nonatomic, copy) YHFormPickerViewComplete block;

@property (nonatomic, strong) UIView *horzView;

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YHFormPickerView
{
    CGFloat _Height;
}

+ (instancetype)pickerWithTitle:(NSString *)title selectors:(NSArray<YHFormSelector *> *)selectors complete:(YHFormPickerViewComplete)block {
    return [[self alloc] initWithTitle:title selectors:selectors complete:block];
}

- (instancetype)initWithTitle:(NSString *)title selectors:(NSArray<YHFormSelector *> *)selectors complete:(YHFormPickerViewComplete)block {
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight /2)];
    if (self) {
        _title = title;
        _selectors = [selectors sortedArrayUsingComparator:^NSComparisonResult(YHFormSelector *  _Nonnull obj1, YHFormSelector *  _Nonnull obj2) {
            return [obj1.value compare:obj2.value];
        }];
        _block = block;
        
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.backgroundColor = [UIColor whiteColor];
    
    _Height = CGRectGetHeight(self.bounds);
    
    [self addSubview:self.horzView];
    [self addSubview:self.backButton];
    [self addSubview:self.titleLabel];
    [self addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.selectors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHFormPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YHFormPickerCell class]) forIndexPath:indexPath];
    cell.title = self.selectors[indexPath.row].displayText;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.block) self.block(self.selectors[indexPath.row]);
}

#pragma mark - Action

- (void)backButtonAction:(UIButton *)button {
    if (self.block) self.block(nil);
}


#pragma mark - Get

- (UIButton *)backButton {
    if (_backButton) return _backButton;
    
    _backButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 50, 0, 50, 44)];
    _backButton.titleLabel.font = [UIFont formDefaultFont];
    [_backButton setTitleColor:[UIColor formTintColor] forState:UIControlStateNormal];
    [_backButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_backButton setTitle:@"完成" forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return _backButton;
}

- (UIView *)horzView {
    if (_horzView) return _horzView;
    
    _horzView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.6)];
    _horzView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    return _horzView;
}

- (UILabel *)titleLabel {
    if (_titleLabel) return _titleLabel;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth * 0.2, 0, ScreenWidth * 0.6, 44)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:15.f];
    _titleLabel.textColor = [UIColor formTextColor];
    _titleLabel.text = self.title ? [@"请选择" stringByAppendingString:self.title.clearSpacing] : nil;
    return _titleLabel;
}

- (UITableView *)tableView {
    if (_tableView) return _tableView;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, _Height - 44)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView registerClass:[YHFormPickerCell class] forCellReuseIdentifier:NSStringFromClass([YHFormPickerCell class])];
    return _tableView;
}

@end
