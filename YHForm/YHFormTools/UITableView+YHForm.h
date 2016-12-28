//
//  UITableView+YHForm.h
//  YHFormExample
//
//  Created by wyh on 2016/11/14.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (YHForm)

- (void)yh_registerNibWithCellReuseIdentifierString:(NSString *)classString;

- (void)yh_registerWithCellReuseIdentifierString:(NSString *)classString;

- (__kindof UITableViewCell *)yh_dequeueReusableCellWithIdentifierString:(NSString *)classString forIndexPath:(NSIndexPath *)indexPath;

- (void)yh_registerNibForHeaderFooterViewReuseIdentifierString:(NSString *)classString;

- (void)yh_registerForHeaderFooterViewReuseIdentifierString:(NSString *)classString;

- (__kindof UITableViewHeaderFooterView *)yh_dequeueReusableHeaderFooterViewWithIdentifierString:(NSString *)classString;

@end
