//
//  ViewController.m
//  YHForm
//
//  Created by wyh on 2016/12/28.
//  Copyright © 2016年 wyh. All rights reserved.
//

#import "ViewController.h"
#import "TestVC.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.button];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonAction {
    
    [self.navigationController pushViewController:[[TestVC alloc] init] animated:YES];
}

- (UIButton *)button {
    if (_button) {
        return _button;
    }
    
    _button = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, 100, 100)];
    _button.backgroundColor = [UIColor greenColor];
    
    [_button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    return _button;
}



@end
