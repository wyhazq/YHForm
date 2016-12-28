//
//  YHFormScrollView.h
//  NRD
//
//  Created by wyh on 2016/10/14.
//  Copyright © 2016年 深圳市小牛资本管理集团. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHFormScrollView : UIScrollView

@property (nonatomic, readonly) NSInteger pageCount;

@property (nonatomic, readonly) NSInteger pageIndex;

@property (nonatomic, readonly) BOOL isLastPage;

- (void)nextPage;

@end
