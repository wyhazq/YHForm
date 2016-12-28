//
//  ViewController.m
//  YHForm
//
//  Created by wyh on 2016/12/28.
//  Copyright © 2016年 wyh. All rights reserved.
//

#import "ViewController.h"
#import "TestVC.h"
#import "TestJsonVC.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *button0;

@property (nonatomic, strong) UIButton *button1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.button0];
    [self.view addSubview:self.button1];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)button0Action {
    [self.navigationController pushViewController:[[TestVC alloc] init] animated:YES];
}

- (void)button1Action {
    [self.navigationController pushViewController:[[TestJsonVC alloc] init] animated:YES];
}

- (UIButton *)button0 {
    if (_button0) {
        return _button0;
    }
    
    _button0 = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, 100, 100)];
    _button0.backgroundColor = [UIColor greenColor];
    [_button0 setTitle:@"Plist" forState:UIControlStateNormal];
    
    [_button0 addTarget:self action:@selector(button0Action) forControlEvents:UIControlEventTouchUpInside];
    return _button0;
}

- (UIButton *)button1 {
    if (_button1) {
        return _button1;
    }
    
    _button1 = [[UIButton alloc] initWithFrame:CGRectMake(102, 64, 100, 100)];
    _button1.backgroundColor = [UIColor greenColor];
    [_button1 setTitle:@"Json" forState:UIControlStateNormal];

    [_button1 addTarget:self action:@selector(button1Action) forControlEvents:UIControlEventTouchUpInside];
    return _button1;
}


@end
