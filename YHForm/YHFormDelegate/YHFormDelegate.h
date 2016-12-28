//
//  YHFormDelegate.h
//  YHFormExample
//
//  Created by wyh on 2016/11/8.
//  Copyright © 2016年 . All rights reserved.
//

#ifndef YHFormDelegate_h
#define YHFormDelegate_h

#import "YHFormTableDelegate.h"

@class YHFormData;
@class YHFormTableView;

@protocol YHFormDelegate <NSObject>

@optional

- (YHFormData *)configFormData;

- (void)formTableView:(YHFormTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)commitRequest;

@end

#endif /* YHFormDelegate_h */
