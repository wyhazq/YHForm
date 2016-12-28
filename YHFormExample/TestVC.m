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

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"req" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:jsonPath];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    self.formData.queryResponse = dictionary;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}


- (YHFormData *)configFormData {
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Test" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    YHFormData *formData = [YHFormData yy_modelWithJSON:dict];
    
    return formData;
}

@end
