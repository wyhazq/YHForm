//
//  YHFormPickerScrollView.m
//  YHFormExample
//
//  Created by wyh on 2016/11/21.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormPickerScrollView.h"

@implementation YHFormPickerScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)nextPage {
    [self scrollRectToVisible:CGRectMake(self.contentOffset.x + CGRectGetWidth(self.bounds), 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) animated:YES];
}

- (void)toPage:(NSUInteger)index {
    [self scrollRectToVisible:CGRectMake(index * CGRectGetWidth(self.bounds), 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) animated:YES];
}

- (NSInteger)pageIndex {
    return (long)roundf(self.contentOffset.x / CGRectGetWidth(self.bounds));
}

@end
