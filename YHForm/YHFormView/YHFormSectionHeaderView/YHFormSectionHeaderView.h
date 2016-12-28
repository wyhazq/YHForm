//
//  YHFormSectionHeaderView.h
//  YHFormExample
//
//  Created by wyh on 2016/11/8.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHFormConfig.h"
#import "Masonry.h"
#import "SVProgressHUD.h"

#import "YHFormModel.h"
#import "YHFormTools.h"

@interface YHFormSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, weak) YHFormSectionHeader *formSectionHeader;

- (void)setUI;

- (void)updateData;

@end
