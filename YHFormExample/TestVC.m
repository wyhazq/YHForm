//
//  TestVC.m
//  YHFormExample
//
//  Created by wyh on 2016/11/13.
//  Copyright © 2016年 wyh. All rights reserved.
//

#import "TestVC.h"
#import "YYModel.h"

@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
        
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"req" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:jsonPath];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    self.formData.queryResponse = dictionary;
//    self.formData.queryResponse = dictionary[@"table"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)formTableView:(YHFormTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    YHFormRow *row = [tableView.formTable formRowAtIndex:indexPath];
//    
//    row.value = @"fuck";
    
//    YHFormRow *row = [YHFormRow formRowWithRowType:@"YHFormCell" key:nil];
//    row.title = @"身高";
//    
//    [tableView.formTable.formSections[0] addFormRow:row];
    
//    [tableView.formTable.formSections[0] removeFormRowAtIndex:0];
    
//    [tableView.formTable removeFormSectionAtIndex:0];

//    YHFormSection *formSection = [YHFormSection formSection];
//    
//    YHFormRow *row0 = [YHFormRow formRowWithRowType:@"YHFormCell" key:nil];
//    row0.title = @"身高";
//    [formSection addFormRow:row0];
//    
//    YHFormRow *row1 = [YHFormRow formRowWithRowType:@"YHFormCell" key:nil];
//    row1.title = @"体重";
//    [formSection addFormRow:row1];
//    
//    [tableView.formTable addFormSection:formSection];
    
}

- (YHFormData *)configFormData {
//    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"json"];
//    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:jsonPath];
//    YHFormData *formData = [YHFormData yy_modelWithJSON:jsonData];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Test" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    YHFormData *formData = [YHFormData yy_modelWithJSON:dict];
    
//    YHFormTable *formTable = [YHFormTable formTable];
//    [formData addFormTable:formTable];
//
//    YHFormSection *formSection = [YHFormSection formSection];
//    [formTable addFormSection:formSection];
//
//    YHFormRow *row = [YHFormRow formRowWithRowType:@"YHFormCell" key:nil];
//    [formSection addFormRow:row];
//    
//    row = [YHFormRow formRowWithRowType:@"YHFormCell" key:nil];
//    [formSection addFormRow:row];
//    
//    row = [YHFormRow formRowWithRowType:@"YHFormCell" key:nil];
//    [formSection addFormRow:row];
//    
//    row = [YHFormRow formRowWithRowType:@"YHFormCell" key:nil];
//    [formSection addFormRow:row];
//    
//    row = [YHFormRow formRowWithRowType:@"YHFormCell" key:nil];
//    [formSection addFormRow:row];
    
    return formData;
}

@end
