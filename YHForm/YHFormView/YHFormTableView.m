//
//  YHFormTableView.m
//  YHFormExample
//
//  Created by wyh on 2016/11/8.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormTableView.h"

@implementation YHFormTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {

    }
    return self;
}

- (void)setFormTable:(YHFormTable *)formTable {
    _formTable = formTable;
    self.separatorStyle = _formTable.separatorStyle;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
