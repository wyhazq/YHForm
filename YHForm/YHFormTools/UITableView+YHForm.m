//
//  UITableView+YHForm.m
//  YHFormExample
//
//  Created by wyh on 2016/11/14.
//  Copyright © 2016年 . All rights reserved.
//

#import "UITableView+YHForm.h"

@implementation UITableView (YHForm)

- (void)yh_registerNibWithCellReuseIdentifierString:(NSString *)classString {
    [self registerNib:[UINib nibWithNibName:classString bundle:[NSBundle mainBundle]] forCellReuseIdentifier:classString];
}

- (void)yh_registerWithCellReuseIdentifierString:(NSString *)classString {
    [self registerClass:NSClassFromString(classString) forCellReuseIdentifier:classString];
}

- (UITableViewCell *)yh_dequeueReusableCellWithIdentifierString:(NSString *)classString forIndexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableCellWithIdentifier:classString forIndexPath:indexPath];
}

- (void)yh_registerNibForHeaderFooterViewReuseIdentifierString:(NSString *)classString {
    return [self registerNib:[UINib nibWithNibName:classString bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:classString];
}

- (void)yh_registerForHeaderFooterViewReuseIdentifierString:(NSString *)classString {
    return [self registerClass:NSClassFromString(classString) forHeaderFooterViewReuseIdentifier:classString];
}

- (UITableViewHeaderFooterView *)yh_dequeueReusableHeaderFooterViewWithIdentifierString:(NSString *)classString {
    return [self dequeueReusableHeaderFooterViewWithIdentifier:classString];
}



@end
