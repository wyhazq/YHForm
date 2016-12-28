//
//  YHFormVC.m
//  YHFormExample
//
//  Created by wyh on 2016/11/8.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormVC.h"

@interface YHFormVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) YHFormData *formData;

@property (nonatomic, strong) YHFormScrollView *scrollView;

@property (nonatomic, copy) NSArray<YHFormTableView *> *tableViews;

@property (nonatomic, copy) NSArray<YHFormButton *> *buttons;

@property (nonatomic, strong) UIScrollView *buttonScrollView;

@end

@implementation YHFormVC

#pragma mark - Lift Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(self.formData.vcTitle, nil);
    
    [self registReuseCell];
    
    if (self.formData.formTables.count > 0) {
        if (self.formData.formTables.count > 1) {
            [self.view addSubview:self.scrollView];
            [self.view addSubview:self.buttonScrollView];

            [self.tableViews enumerateObjectsUsingBlock:^(YHFormTableView * _Nonnull tableView, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.scrollView addSubview:tableView];
            }];
            
            [self.buttons enumerateObjectsUsingBlock:^(YHFormButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
                button.hidden = self.formData.editType == YHFormDataEditTypeComplete;
                [self.buttonScrollView addSubview:button];
            }];
            
            [self addObserver:self.scrollView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
            
            return;
        }
        self.tableViews[0].frame = self.view.bounds;
        [self.view addSubview:self.tableViews[0]];
        
        UIButton *button = self.buttons[0];
        CGRect buttonFrame = button.frame;
        buttonFrame.origin.y = CGRectGetHeight(self.view.bounds) - YHFormButtonHeight;
        button.frame = buttonFrame;
        button.enabled = YES;
        button.hidden = self.formData.editType == YHFormDataEditTypeComplete;
        [self.view addSubview:button];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds) * self.formData.formTables.count, CGRectGetHeight(self.view.bounds) - fabs(_scrollView.contentInset.top));
    [self.tableViews enumerateObjectsUsingBlock:^(YHFormTableView * _Nonnull tableView, NSUInteger idx, BOOL * _Nonnull stop) {
        tableView.frame = CGRectMake(idx * CGRectGetWidth(self.scrollView.bounds), 0, CGRectGetWidth(self.scrollView.bounds), self.scrollView.contentSize.height);
    }];
}

- (void)registReuseCell {
    
    [self.formData.formTables enumerateObjectsUsingBlock:^(YHFormTable * _Nonnull formTable, NSUInteger idxTable, BOOL * _Nonnull stopTable) {
        //setDelegate
        formTable.delegate = self;
        [formTable.formSections enumerateObjectsUsingBlock:^(YHFormSection * _Nonnull formSection, NSUInteger idxSection, BOOL * _Nonnull stopSection) {
            
            //regist sectionHeader
            if (formSection.formSectionHeader) {
                if ([[NSBundle mainBundle] yh_containNib:formSection.formSectionHeader.sectionHeaderType]) {
                    [self.tableViews[idxTable] yh_registerNibForHeaderFooterViewReuseIdentifierString:formSection.formSectionHeader.sectionHeaderType];
                }
                else {
                    [self.tableViews[idxTable] yh_registerForHeaderFooterViewReuseIdentifierString:formSection.formSectionHeader.sectionHeaderType];
                }
            }
            
            //regist cell
            [formSection.formRows enumerateObjectsUsingBlock:^(YHFormRow * _Nonnull formRow, NSUInteger idxRow, BOOL * _Nonnull stopSection) {
                if ([[NSBundle mainBundle] yh_containNib:formRow.rowType]) {
                    [self.tableViews[idxTable] yh_registerNibWithCellReuseIdentifierString:formRow.rowType];
                }
                else {
                    [self.tableViews[idxTable] yh_registerWithCellReuseIdentifierString:formRow.rowType];
                }
            }];
            
            //regist sectionFooter
            if (formSection.formSectionFooter) {
                if ([[NSBundle mainBundle] yh_containNib:formSection.formSectionFooter.sectionFooterType]) {
                    [self.tableViews[idxTable] yh_registerNibForHeaderFooterViewReuseIdentifierString:formSection.formSectionFooter.sectionFooterType];
                }
                else {
                    [self.tableViews[idxTable] yh_registerForHeaderFooterViewReuseIdentifierString:formSection.formSectionFooter.sectionFooterType];
                }
            }
            
        }];
    }];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.scrollView && ([keyPath isEqualToString:@"contentOffset"])) {
        self.buttonScrollView.contentOffset = self.scrollView.contentOffset;
    }
}

- (void)dealloc {
    if (self.formData.formTables.count > 1) {
        @try {
            [self removeObserver:self.scrollView forKeyPath:@"contentOffset"];
        }
        @catch (NSException * __unused exception) {}
    }
    NSLog(@"%@:%@", NSStringFromSelector(_cmd), NSStringFromClass([self class]));
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(YHFormTableView *)tableView {
    return tableView.formTable.formSections.count;
}

- (NSInteger)tableView:(YHFormTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableView.formTable.formSections[section].formRows.count;
}

- (UITableViewCell *)tableView:(YHFormTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHFormRow *formRow = [tableView.formTable formRowAtIndex:indexPath];
    YHFormCell *cell = [tableView yh_dequeueReusableCellWithIdentifierString:formRow.rowType forIndexPath:indexPath];
    cell.formRow = formRow;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(YHFormTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell.isFirstResponder) {
        [self.view endEditing:YES];
    }
    
    if ([self respondsToSelector:@selector(formTableView:didSelectRowAtIndexPath:)]) {
        [self formTableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(YHFormTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHFormRow *formRow = [tableView.formTable formRowAtIndex:indexPath];
    return formRow.height > 0 ?: [YHFormUI formCellHeight];
}

- (CGFloat)tableView:(YHFormTableView *)tableView heightForHeaderInSection:(NSInteger)section {
    YHFormSectionHeader *formSectionHeader = tableView.formTable.formSections[section].formSectionHeader;
    return formSectionHeader ? formSectionHeader.height : 0.00001;
}

- (CGFloat)tableView:(YHFormTableView *)tableView heightForFooterInSection:(NSInteger)section {
    YHFormSectionFooter *formSectionFooter = tableView.formTable.formSections[section].formSectionFooter;
    return formSectionFooter ? formSectionFooter.height : 0.00001;
}

- (UIView *)tableView:(YHFormTableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YHFormSectionHeader *formSectionHeader = tableView.formTable.formSections[section].formSectionHeader;
    if (formSectionHeader) {
        YHFormSectionHeaderView *formSectionHeaderView = [tableView yh_dequeueReusableHeaderFooterViewWithIdentifierString:formSectionHeader.sectionHeaderType];
        formSectionHeaderView.formSectionHeader = formSectionHeader;
        return formSectionHeaderView;
    }
    return [[UIView alloc] init];
}

- (UIView *)tableView:(YHFormTableView *)tableView viewForFooterInSection:(NSInteger)section {
    YHFormSectionFooter *formSectionFooter = tableView.formTable.formSections[section].formSectionFooter;
    if (formSectionFooter) {
        
    }
    return [[UIView alloc] init];
}

#pragma mark - YHFormTableDelegate(UpdateTableView)

- (void)formSectionHasBeenAdded:(YHFormSection *)formSection atIndex:(NSUInteger)index {
    YHFormTableView *tableView = self.tableViews[[self.formData.formTables indexOfObject:formSection.formTable]];
    if ([tableView.formTable isEqual:formSection.formTable]) {
        [tableView beginUpdates];
        [tableView insertSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationTop];
        [tableView endUpdates];
    }
}

- (void)formSectionHasBeenRemoved:(YHFormSection *)formSection atIndex:(NSUInteger)index {
    YHFormTableView *tableView = self.tableViews[[self.formData.formTables indexOfObject:formSection.formTable]];
    if ([tableView.formTable isEqual:formSection.formTable]) {
        [tableView beginUpdates];
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationTop];
        [tableView endUpdates];
    }
}

- (void)formRowHasBeenAdded:(YHFormRow *)formRow atIndexPath:(NSIndexPath *)indexPath {
    YHFormTableView *tableView = self.tableViews[[self.formData.formTables indexOfObject:formRow.formSection.formTable]];
    if ([tableView.formTable isEqual:formRow.formSection.formTable]) {
        [tableView beginUpdates];
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [tableView endUpdates];
    }
    [formRow setValueFromResponse:self.formData.queryResponse];
}

- (void)formRowHasBeenRemoved:(YHFormRow *)formRow atIndexPath:(NSIndexPath *)indexPath {
    YHFormTableView *tableView = self.tableViews[[self.formData.formTables indexOfObject:formRow.formSection.formTable]];
    if ([tableView.formTable isEqual:formRow.formSection.formTable]) {
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [tableView endUpdates];
    }
}

- (void)formRowHasChanged:(YHFormRow *)formRow oldValue:(id)oldValue newValue:(id)newValue {
    YHFormTableView *tableView = self.tableViews[[self.formData.formTables indexOfObject:formRow.formSection.formTable]];
    [tableView reloadRowsAtIndexPaths:@[[formRow.formSection.formTable indexPathOfFormRow:formRow]] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Action

- (void)buttonAction:(UIButton *)button {
    [self.scrollView nextPage];

    NSLog(@"formParameters:\n%@", [self.formData.formParameters description]);
    if (self.formData.formTables.count == 1 || self.scrollView.isLastPage) {
        if (self.formData.isValid && [self respondsToSelector:@selector(commitRequest)]) {
            [self commitRequest];
        }
    }
}

- (void)commitRequest {

}

#pragma mark - Get

- (YHFormData *)formData {
    if (_formData) return _formData;
    if ([self respondsToSelector:@selector(configFormData)]) {
        _formData = [self configFormData];
    }
    return _formData;
}

- (YHFormData *)configFormData {
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:NSStringFromClass([self class]) ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:jsonPath];
    YHFormData *formData = [YHFormData yy_modelWithJSON:jsonData];
    return formData;
}

- (YHFormScrollView *)scrollView {
    if (_scrollView) return _scrollView;
    
    _scrollView = [[YHFormScrollView alloc] initWithFrame:self.view.bounds];
    return _scrollView;
}

- (NSArray<YHFormTableView *> *)tableViews {
    if (_tableViews) return _tableViews;
    
    NSMutableArray *tableViews = @[].mutableCopy;
    [self.formData.formTables enumerateObjectsUsingBlock:^(YHFormTable * _Nonnull formTable, NSUInteger idx, BOOL * _Nonnull stop) {
        YHFormTableView *tableView = [[YHFormTableView alloc] initWithFrame:CGRectZero style:formTable.tableViewStyle];
        tableView.backgroundColor = [UIColor cellContentBackgroundColor];
        tableView.formTable = formTable;
        tableView.delegate = self;
        tableView.dataSource = self;
        
        if (formTable.formTableHeader) {}
        else {
            tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];//配合坑爹UI写死的高度
        }

        if (formTable.formTableFooter) {}
        else {
            tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, YHFormButtonHeight + 10)];
        }
        
        [tableViews addObject:tableView];
    }];
    _tableViews = tableViews.copy;
    return _tableViews;
}

- (UIScrollView *)buttonScrollView {
    if (_buttonScrollView) return _buttonScrollView;
    
    _buttonScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - YHFormButtonHeight, ScreenWidth, YHFormButtonHeight)];
    _buttonScrollView.contentSize = CGSizeMake(self.formData.formTables.count * ScreenWidth, YHFormButtonHeight);
    _buttonScrollView.scrollEnabled = NO;
    return _buttonScrollView;
}


- (NSArray<YHFormButton *> *)buttons {
    if (_buttons) return _buttons;
    
    NSMutableArray *buttons = @[].mutableCopy;
    [self.formData.formTables enumerateObjectsUsingBlock:^(YHFormTable * _Nonnull formTable, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat buttonX = idx * ScreenWidth;
        YHFormButton *button = [[YHFormButton alloc] initWithFrame:CGRectMake(buttonX, 0, ScreenWidth, YHFormButtonHeight)];
        [button setTitle:formTable.buttonTitle forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [buttons addObject:button];
    }];
    _buttons = buttons.copy;
    return _buttons;
}

@end

//deprecated

//- (NSString *)tableView:(YHFormTableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    YHFormSectionHeader *formSectionHeader = tableView.formTable.formSections[section].formSectionHeader;
//    return formSectionHeader.text ?: nil;
//}
//
//- (NSString *)tableView:(YHFormTableView *)tableView titleForFooterInSection:(NSInteger)section {
//    YHFormSectionFooter *formSectionFooter = tableView.formTable.formSections[section].formSectionFooter;
//    return formSectionFooter.title ?: nil;
//}



