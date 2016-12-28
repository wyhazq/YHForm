//
//  YHFormPickerScrollView.h
//  YHFormExample
//
//  Created by wyh on 2016/11/21.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHFormPickerScrollView : UIScrollView

- (void)nextPage;

- (void)toPage:(NSUInteger)index;

- (NSInteger)pageIndex;

@end
