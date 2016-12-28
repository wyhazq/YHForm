//
//  YHFormAddressPicker.m
//  YHFormExample
//
//  Created by wyh on 2016/11/21.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormAddressPicker.h"
#import "YHFormConfig.h"

#import "YHFormPickerScrollView.h"
#import "YHFormPickerCell.h"

#import "YYModel.h"

@interface YHFormAddressPicker () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) YHFormAddressPickerComplete block;

@property (nonatomic, strong) UIView *horzView;

//@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UIButton *completeButton;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) YHFormPickerScrollView *scrollView;

@property (nonatomic, copy) NSArray<NSDictionary *> *provinceArray;

@property (nonatomic, copy) NSArray<NSDictionary *> *cityArray;

@property (nonatomic, copy) NSArray<NSDictionary *> *districtArray;

@property (nonatomic, strong) UITableView *provinceTableView;

@property (nonatomic, strong) UITableView *cityTableView;

@property (nonatomic, strong) UITableView *districtTableView;

@property (nonatomic, copy) NSString *provinceCode;

@property (nonatomic, copy) NSString *provinceName;

@property (nonatomic, copy) NSString *cityCode;

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, copy) NSString *districtCode;

@property (nonatomic, copy) NSString *districtName;

@end

@implementation YHFormAddressPicker

+ (instancetype)addressPickerWithAddress:(NSArray<NSDictionary *> *)address complete:(YHFormAddressPickerComplete)block {
    return [[self alloc] initWithAddress:address complete:block];
}

- (instancetype)initWithAddress:(NSArray<NSDictionary *> *)address complete:(YHFormAddressPickerComplete)block {
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight /2)];
    if (self) {
        _provinceArray = address;
        _block = block;
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.horzView];
//    [self addSubview:self.backButton];
    [self addSubview:self.completeButton];
    [self addSubview:self.titleLabel];
    
    [self addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.provinceTableView];
    [self.scrollView addSubview:self.cityTableView];
    [self.scrollView addSubview:self.districtTableView];
}

- (void)reset {
    [self.scrollView toPage:0];
    _provinceCode = nil;
    _provinceName = nil;
    _cityCode = nil;
    _cityName = nil;
    _districtCode = nil;
    _districtName = nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([tableView isEqual:self.provinceTableView]) {
        return self.provinceArray.count;
    }
    else if ([tableView isEqual:self.cityTableView]) {
        return self.cityArray.count;
    }
    else if ([tableView isEqual:self.districtTableView]) {
        return self.districtArray.count;
    }
   
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHFormPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YHFormPickerCell class]) forIndexPath:indexPath];
    
    if ([tableView isEqual:self.provinceTableView]) {
        cell.title = self.provinceArray[indexPath.row][@"provinceName"];
    }
    else if ([tableView isEqual:self.cityTableView]) {
        cell.title = self.cityArray[indexPath.row][@"cityName"];
    }
    else if ([tableView isEqual:self.districtTableView]) {
        cell.title = self.districtArray[indexPath.row][@"discName"];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.scrollView nextPage];
    
    if ([tableView isEqual:self.provinceTableView]) {
        self.provinceCode = self.provinceArray[indexPath.row][@"provinceCode"];
        self.provinceName = self.provinceArray[indexPath.row][@"provinceName"];
        self.cityArray = self.provinceArray[indexPath.row][@"cityList"];
        [self.cityTableView reloadData];
    }
    else if ([tableView isEqual:self.cityTableView]) {
        self.cityCode = self.cityArray[indexPath.row][@"cityCode"];
        self.cityName = self.cityArray[indexPath.row][@"cityName"];
        self.districtArray = self.cityArray[indexPath.row][@"discList"];
        [self.districtTableView reloadData];
    }
    else if ([tableView isEqual:self.districtTableView]) {
        self.districtCode = self.districtArray[indexPath.row][@"discCode"];
        self.districtName = self.districtArray[indexPath.row][@"discName"];
        NSArray *array;
        if (self.provinceCode && self.provinceName && self.cityCode && self.cityName && self.districtCode && self.districtName) {
            array = @[self.provinceName, self.cityName, self.districtName];
        }
        if (self.block) self.block(array);
    }
}

#pragma mark - Action

//- (void)backButtonAction:(UIButton *)button {
//    if (self.block) self.block(nil);
//}

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

//- (UIButton *)backButton {
//    if (_backButton) return _backButton;
//    
//    _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
//    _backButton.titleLabel.font = [UIFont formDefaultFont];
//    [_backButton setTitleColor:[UIColor formTextColor] forState:UIControlStateNormal];
//    [_backButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
//    [_backButton setTitle:@"取消" forState:UIControlStateNormal];
//    [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    return _backButton;
//}

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
    _titleLabel.text = @"请选择地区";
    return _titleLabel;
}

- (YHFormPickerScrollView *)scrollView {
    if (_scrollView) return _scrollView;
    
    _scrollView = [[YHFormPickerScrollView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, CGRectGetHeight(self.bounds) - 44)];
    _scrollView.contentSize = CGSizeMake(3 * ScreenWidth, CGRectGetHeight(self.bounds) - 44);
    return _scrollView;
}

- (UITableView *)provinceTableView {
    if (_provinceTableView) return _provinceTableView;
    
    _provinceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(self.scrollView.bounds))];
    _provinceTableView.delegate = self;
    _provinceTableView.dataSource = self;
    _provinceTableView.tableFooterView = [[UIView alloc] init];
    [_provinceTableView registerClass:[YHFormPickerCell class] forCellReuseIdentifier:NSStringFromClass([YHFormPickerCell class])];
    return _provinceTableView;
}

- (UITableView *)cityTableView {
    if (_cityTableView) return _cityTableView;
    
    _cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, CGRectGetHeight(self.scrollView.bounds))];
    _cityTableView.delegate = self;
    _cityTableView.dataSource = self;
    _cityTableView.tableFooterView = [[UIView alloc] init];
    [_cityTableView registerClass:[YHFormPickerCell class] forCellReuseIdentifier:NSStringFromClass([YHFormPickerCell class])];
    return _cityTableView;
}

- (UITableView *)districtTableView {
    if (_districtTableView) return _districtTableView;
    
    _districtTableView = [[UITableView alloc] initWithFrame:CGRectMake(2 * ScreenWidth, 0, ScreenWidth, CGRectGetHeight(self.scrollView.bounds))];
    _districtTableView.delegate = self;
    _districtTableView.dataSource = self;
    _districtTableView.tableFooterView = [[UIView alloc] init];
    [_districtTableView registerClass:[YHFormPickerCell class] forCellReuseIdentifier:NSStringFromClass([YHFormPickerCell class])];
    return _districtTableView;
}

@end
